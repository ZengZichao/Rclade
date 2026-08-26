# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Pipeline steps for plot_timetree()
# Internal functions that break down the 700+ line monolithic function
# into discrete, testable, single-responsibility steps.

#' Step 1: Prepare and validate inputs
#'
#' Reads tree from file (if path), validates structure, converts units,
#' checks for large trees, and handles cladogram mode.
#'
#' @return A named list with:
#'   \item{tree}{validated phylo object}
#'   \item{unit}{resolved time unit}
#'   \item{branch_length_mode}{"branch.length" or "none"}
#'   \item{add_timescale}{possibly modified}
#' @keywords internal
pt_step1_prepare_inputs <- function(
    tree, tree_index, multi_tree_mode, rank, unit, layout,
    triangle_mode, space_mode, add_timescale, groups, clade, overwrite,
    ignore_branch_length, low_memory
) {
  # Step 1: Input validation and reading
  next_step("Input validation and reading")
  timer_start("input_reading")

  if (is.character(tree)) {
    stop("Internal error: pt_step1 received a file path instead of a phylo object. ",
         "This should have been resolved by plot_timetree().", call. = FALSE)
  }
  if (!is.null(tree_index)) {
    log_warning("tree_index is ignored when 'tree' is a phylo object (not a file path).",
                .module = "plot-timetree-pipeline")
  }

  validated <- validate_inputs(tree, rank, unit, layout, triangle_mode,
                                 space_mode, add_timescale, groups, clade, overwrite)
  tree <- validated$tree
  unit <- validated$unit
  tree <- convert_unit(tree, unit)

  # Optional: ignore original branch lengths and draw a cladogram
  branch_length_mode <- "branch.length"
  if (isTRUE(ignore_branch_length)) {
    log_info("Ignoring original branch lengths; drawing cladogram with aligned tips")
    branch_length_mode <- "none"
    if (isTRUE(add_timescale)) {
      log_warning("ignore_branch_length = TRUE disables the geological timescale. Setting add_timescale = FALSE.",
                  .module = "plot-timetree-pipeline")
      add_timescale <- FALSE
    }
  }

  # Large tree resource warning
  n_tips <- ape::Ntip(tree)
  if (n_tips > 10000) {
    log_warning("Large tree detected: %d tips. This may require significant memory and time.",
                n_tips, .module = "plot-timetree-pipeline/validate_input")
    log_info("Consider using --low_memory mode for trees with >10000 tips.")
  }
  if (n_tips > 50000) {
    log_warning("Very large tree: %d tips. Expect high memory usage (>4GB) and slow rendering.",
                n_tips, .module = "plot-timetree-pipeline/validate_input")
  }

  timer_stop("input_reading")
  log_memory("After input reading")
  if (low_memory) gc(verbose = FALSE)

  list(
    tree = tree,
    unit = unit,
    branch_length_mode = branch_length_mode,
    add_timescale = add_timescale
  )
}


#' Step 2: Resolve taxonomy / collapsing mode
#'
#' Determines whether we are in clade-specific, custom-groups, or rank-based
#' mode and parses the taxonomy accordingly.
#'
#' @return A named list with:
#'   \item{group_vec}{named vector mapping tip labels to groups}
#'   \item{detected_format}{resolved taxonomy format string}
#' @keywords internal
pt_step2_resolve_taxonomy <- function(
    tree, clade, strict, groups, rank, taxonomy_format, custom_patterns,
    taxonomy_file, taxonomy_file_sep, taxonomy_file_header,
    taxonomy_file_priority, taxonomy_table_sep, taxonomy_delimiter_mode,
    taxonomy_levels, low_memory
) {
  next_step("Taxonomy parsing")
  timer_start("taxonomy_parsing")
  detected_format <- taxonomy_format
  group_vec <- NULL

  if (!is.null(clade)) {
    # ---- Mode C: specific clade collapsing ----
    log_info("Clade-specific mode: %s", clade)
    log_keyvalue("Strict mode", strict)

    search_ranks <- c("domain", "phylum", "class", "order", "family", "genus", "species")
    rank_std <- normalize_rank(rank)
    if (rank_std != "none" && rank_std %in% search_ranks) {
      search_ranks <- unique(c(rank_std, search_ranks))
    }

    # M-D4: parse every rank ONCE into a single full-rank data.frame, then
    # search the precomputed rank columns (instead of calling
    # parse_taxonomy_with_file once per rank, which re-parses labels / re-reads
    # the taxonomy file 7 times).
    taxa_full <- build_full_taxa_df(
      tree$tip.label, taxonomy_format, custom_patterns,
      taxonomy_file, taxonomy_file_sep, taxonomy_file_header,
      taxonomy_file_priority, taxonomy_table_sep,
      taxonomy_delimiter_mode, taxonomy_levels
    )

    found <- FALSE
    group_lower <- tolower(clade)
    for (rn in search_ranks) {
      if (!rn %in% names(taxa_full)) next
      vals <- taxa_full[[rn]]
      if (group_lower %in% tolower(na.omit(vals))) {
        group_vec <- setNames(vals, taxa_full$label)
        # Normalize the match to its true case so step3 needs no fuzzy re-match
        matched_name <- unique(vals[tolower(vals) == group_lower])
        clade <- matched_name[1]
        log_info("Found '%s' at rank: %s", clade, rn)
        found <- TRUE
        break
      }
    }

    if (!found) {
      stop("Clade '", clade, "' not found in any taxonomic rank.", call. = FALSE)
    }
    if (taxonomy_format == "auto") detected_format <- detect_taxonomy_format(tree$tip.label)
  } else if (!is.null(groups)) {
    # ---- Mode B: custom groups ----
    log_info("Using custom groups mode")
    validate_custom_groups(tree, groups)
    group_vec <- build_group_vec(groups, tree$tip.label)
    detected_format <- "custom"
    log_keyvalue("Custom groups", length(groups))
  } else if (rank != "none") {
    # ---- Mode A: rank-based taxonomy ----
    log_info("Using rank-based taxonomy: %s", rank)
    rank_std <- normalize_rank(rank)
    taxa_df <- parse_taxonomy_with_file(
      tree$tip.label, rank_std, taxonomy_format, custom_patterns,
      taxonomy_file, taxonomy_file_sep, taxonomy_file_header,
      taxonomy_file_priority, taxonomy_table_sep,
      taxonomy_delimiter_mode, taxonomy_levels
    )
    group_vec <- setNames(taxa_df$Group, taxa_df$label)
    if (taxonomy_format == "auto") detected_format <- detect_taxonomy_format(tree$tip.label)
    n_groups <- length(unique(na.omit(group_vec)))
    log_keyvalue("Detected format", detected_format)
    log_keyvalue("Groups found", n_groups)
  }

  # Assert: group_vec names align with tree$tip.label (compute_mrca_map relies
  # on positional matching)
  if (!is.null(group_vec) && !identical(names(group_vec), tree$tip.label)) {
    log_warning("group_vec names do not match tree$tip.label exactly; MRCA computation will use positional alignment.",
                .module = "plot-timetree-pipeline/prepare_groups")
  }

  timer_stop("taxonomy_parsing")
  log_memory("After taxonomy parsing")
  if (low_memory) gc(verbose = FALSE)

  list(
    group_vec = group_vec,
    detected_format = detected_format
  )
}


#' Step 3: Compute MRCA and check monophyly
#'
#' Computes MRCA map for each group, checks monophyly, and detects
#' nesting conflicts.
#'
#' @return A named list with:
#'   \item{mrca_map}{list of MRCA nodes per group}
#'   \item{singleton_map}{singleton group map (attr from compute_mrca_map)}
#'   \item{all_group_names}{union of mrca and singleton names}
#' @keywords internal
pt_step3_compute_mrca <- function(
    tree, group_vec, clade, strict, low_memory
) {
  next_step("MRCA computation and monophyly check")
  timer_start("mrca_computation")
  log_info("Checking monophyly and computing MRCA for each group...")

  # For clade-specific mode, filter to only the target clade
  if (!is.null(clade)) {
    clade_mask <- !is.na(group_vec) & tolower(group_vec) == tolower(clade)
    if (sum(clade_mask) == 0) {
      stop("No tips found for clade '", clade, "'.", call. = FALSE)
    }
    group_vec[!clade_mask] <- NA_character_
    log_info("Tips in clade '%s': %d", clade, sum(clade_mask))
  }

  mrca_map <- if (!is.null(group_vec) && any(!is.na(group_vec))) {
    compute_mrca_map(tree, group_vec, check_monophyly = TRUE, strict = strict)
  } else {
    list()
  }
  singleton_map <- attr(mrca_map, "singleton_map")
  all_group_names <- union(names(mrca_map), names(singleton_map))
  log_keyvalue("Valid MRCA nodes", length(mrca_map))

  timer_stop("mrca_computation")
  log_memory("After MRCA computation")
  if (low_memory) gc(verbose = FALSE)

  # Nesting conflict detection
  if (length(mrca_map) > 1) {
    log_debug("Checking for nesting conflicts...")
    validate_collapse_plan(mrca_map, tree)
  }

  list(
    mrca_map = mrca_map,
    singleton_map = singleton_map,
    all_group_names = all_group_names
  )
}


#' Step 4: Generate colors
#'
#' Generates color palette for all identified groups.
#'
#' @return Named character vector of colors (group -> hex color).
#' @keywords internal
pt_step4_generate_colors <- function(all_group_names, color_palette, color_mapping) {
  next_step("Color generation")
  colors <- if (length(all_group_names) > 0) {
    generate_colors(all_group_names, color_palette, color_mapping)
  } else {
    character(0)
  }
  log_keyvalue("Color palette", color_palette)
  colors
}


#' Step 5: Render base tree and collapse clades
#'
#' Builds the ggplot tree, binds taxonomy data, collapses clades,
#' handles circular layout rescaling, and colors collapse branches.
#'
#' @return A named list with:
#'   \item{p}{ggplot object}
#'   \item{actual_ntips}{displayed tip count after collapse (or NULL)}
#' @keywords internal
pt_step5_render_and_collapse <- function(
    tree, group_vec, mrca_map, colors, layout, angle, line_width,
    branch_length_mode, triangle_mode, space_mode, low_memory,
    color_group_vec = NULL
) {
  next_step("Tree rendering")
  timer_start("tree_rendering")
  p <- build_base_tree(tree, layout, angle, line_width, branch_length_mode)

  # Reverse time axis — must happen BEFORE collapse for BOTH layouts.
  # For rectangular, revts negates x so tips are at x=0.
  # For circular, revts must also be applied before collapse so that
  # ggtree::collapse() creates triangle polygons on the final (reversed)
  # x coordinates.  Previously revts was deferred to add_geo_timescale()
  # for circular layout, which meant collapse() built triangles on
  # non-reversed x values and a later revts negated them afterward,
  # distorting the triangle geometry in the polar coordinate system.
  if (layout == "rectangular" || layout == "circular") {
    p <- ggtree::revts(p)
    attr(p, "revts.done") <- TRUE
    log_debug("Time axis reversed (layout=%s)", layout)
  }

  # Bind taxonomy data: use color_group_vec for Group column if available
  bind_vec <- if (!is.null(color_group_vec)) color_group_vec else group_vec
  if (!is.null(bind_vec)) {
    group_df <- data.frame(label = tree$tip.label, Group = unname(bind_vec),
                           stringsAsFactors = FALSE)
    p <- suppressWarnings(p %<+% group_df)
    class(p$data) <- c("tbl_tree", "tbl_df", "tbl", "data.frame")
    log_debug("Taxonomy data bound to tree")
  }

  # Propagate Group to internal nodes for monophyletic clades (branch coloring)
  if (!is.null(color_group_vec) && length(colors) > 0) {
    d <- p$data
    group_names <- unique(na.omit(color_group_vec))
    for (g in group_names) {
      tip_labels <- names(color_group_vec)[which(color_group_vec == g)]
      tip_labels <- tip_labels[!is.na(tip_labels)]
      if (length(tip_labels) < 2) next
      mrca_node <- tryCatch(ape::getMRCA(tree, tip_labels), error = function(e) NULL)
      if (is.null(mrca_node)) next
      descendants <- tryCatch(
        treeio::offspring(tree, mrca_node),
        error = function(e) integer(0)
      )
      if (length(descendants) > 0) {
        # Include the MRCA node itself so that the branch leading TO the
        # collapsed clade is also colored by the group color via the
        # aes(colour = Group) aesthetic on ggtree's standard branch layer.
        node_col <- which(d$node %in% c(mrca_node, descendants))
        d$Group[node_col] <- g
      }
    }
    p$data <- d
    # Set colour aesthetic on the EXISTING geom_tree layer (from ggtree()).
    # Adding a second geom_tree() layer would draw diagonal segments instead of
    # the layout-aware right-angle / arc branches that the original layer uses.
    p <- p + ggplot2::aes(colour = Group)
    color_values <- colors[unique(na.omit(d$Group))]
    color_values <- color_values[!is.na(color_values)]
    p <- p + ggplot2::scale_color_manual(
      values = color_values,
      na.value = "grey50",
      guide = "none"
    )
    log_debug("Branch coloring by color_rank applied")
  }

  # Circular layout: ggtree's "fan" layout already uses coord_polar(theta = y)
  # internally, so y does NOT need to be in [0, 360].  The polar coordinate
  # system maps y linearly to angle regardless of its absolute range.
  #
  # Previous code rescaled y to [0, 360] before collapse, but this was
  # harmful: it broke ggtree's internal y-coordinate system and caused
  # scaleClade() to compute incorrect vertical offsets, which distorted the
  # triangle polygons created by ggtree::collapse() into irregular shapes
  # (wavy / flame-like outlines) in the circular plot.
  #
  # The correct approach is to leave y as-is (ggtree assigns y = 1..Ntip for
  # tips in tree order) and let coord_polar handle the angle mapping.

  # Batch collapse
  actual_ntips <- NULL
  if (length(mrca_map) > 0) {
    log_info("Collapsing %d clades...", length(mrca_map))
    p <- collapse_by_groups(p, tree, mrca_map, triangle_mode, space_mode, colors,
                            layout = layout)
    actual_ntips <- attr(p, "actual_ntips")
    log_info("Clade collapse complete")
  }

  # Branch coloring for collapsed clades is now handled entirely by the
  # aes(colour = Group) aesthetic set above.  The MRCA node's Group is set
  # in the propagation step, so ggtree's standard right-angle / arc branch
  # rendering (StatTreeHorizontal / StatTreeVertical) will use the correct
  # color for the branch leading to each collapsed clade.
  #
  # Previously, color_collapse_branches() added a geom_segment layer that
  # drew diagonal lines from parent to collapsed child (StatIdentity), which
  # broke the T-shaped bifurcation convention in rectangular layout and
  # produced visual artifacts in circular layout.

  timer_stop("tree_rendering")
  log_memory("After tree rendering")
  if (low_memory) gc(verbose = FALSE)

  list(p = p, actual_ntips = actual_ntips)
}


#' Step 6: Add annotations (tip labels, timescale, support, HPD, clade labels, highlight)
#'
#' @return Updated ggplot object.
#' @keywords internal
pt_step6_add_annotations <- function(
    p, tree, layout, add_timescale, timescale_levels, actual_ntips,
    timescale_version, show_tip_labels, tip_label_size, show_support,
    support_threshold, show_hpd, hpd_color, geo_events, show_clade_label,
    show_clade_count, clade_label_offset, clade_label_fontsize, mrca_map,
    singleton_map, highlight, highlight_alpha, rank, taxonomy_format,
    custom_patterns, taxonomy_delimiter_mode, taxonomy_levels, ignore_branch_length,
    colors, timescale_mode = "radial", timescale_position = "right",
    angle = 360, tree_start_position = "right"
) {
  # Tip labels
  if (show_tip_labels) {
    p <- p + ggtree::geom_tiplab(size = tip_label_size, align = FALSE)
    log_debug("Tip labels added")
  }

  # Timescale
  next_step("Timescale integration")
  if (add_timescale && (layout == "rectangular" || layout == "circular")) {
    p <- add_geo_timescale(p, tree, timescale_levels, layout, timescale_version,
                           actual_ntips = actual_ntips,
                           timescale_mode = timescale_mode,
                           timescale_position = timescale_position,
                           angle = angle,
                           tree_start_position = tree_start_position)
    log_debug("Geological timescale added")
  } else if (!add_timescale && layout == "rectangular") {
    # pt_step5 applies revts BEFORE collapse and marks attr(p, "revts.done").
    # Do NOT revts again: when every tip is collapsed away, max(p$data$x) is
    # the shallowest MRCA instead of 0, so a second revts shifts the whole
    # tree horizontally while the fixed-coordinate triangle polygons stay
    # behind, misaligning them (vertical stays correct).
    if (!isTRUE(attr(p, "revts.done"))) {
      p <- ggtree::revts(p)
      attr(p, "revts.done") <- TRUE
    }
    if (isTRUE(ignore_branch_length)) {
      p <- p + ggtree::theme_tree2()
    } else {
      x_min <- compute_x_min(tree)
      time_info <- compute_time_breaks(x_min, 0)
      p <- p + ggplot2::scale_x_continuous(
        name = time_info$unit_label,
        breaks = time_info$breaks,
        labels = time_info$labels
      ) + ggtree::theme_tree2()
    }
  } else if (layout == "circular") {
    p <- p + ggtree::theme_tree()
  }

  # Node support labels
  if (show_support) {
    p <- add_support_labels(p, tree, support_threshold)
  }

  # Geological events
  if (add_timescale && layout == "rectangular" && !isFALSE(geo_events)) {
    p <- add_geo_events(p, tree, if (isTRUE(geo_events)) NULL else geo_events)
  }

  # HPD range
  if (show_hpd) {
    p <- add_hpd_range(p, tree, color = hpd_color)
  }

  # Clade labels
  if (show_clade_label && (length(mrca_map) > 0 || length(singleton_map) > 0)) {
    p <- annotate_clade(p, tree, mrca_map, colors,
                        show_count = show_clade_count,
                        offset = clade_label_offset,
                        fontsize = clade_label_fontsize,
                        singleton_map = singleton_map)
  }

  # Highlight
  if (!is.null(highlight)) {
    highlight_colors <- generate_colors(highlight, palette = "Set1")
    p <- highlight_clades(p, tree, highlight, rank, taxonomy_format,
                          colors = highlight_colors, alpha = highlight_alpha,
                          custom_patterns = custom_patterns,
                          delimiter_mode = taxonomy_delimiter_mode,
                          taxonomy_levels = taxonomy_levels)
  }

  p
}


#' Step 7: Finalize plot (legend, theme, title, save, metadata)
#'
#' @return Final ggplot object with \code{rclade_info} attribute.
#' @keywords internal
pt_step7_finalize_plot <- function(
    p, colors, groups, rank, legend_position, legend_nrow, legend_ncol,
    legend_title, theme_fun, add_timescale, layout, main_title, sub_title,
    output, width, height, overwrite, tree, mrca_map, all_group_names,
    actual_ntips, detected_format, color_palette
) {
  # Legend
  if (length(colors) > 0) {
    if (!is.null(legend_title)) {
      legend_label <- legend_title
    } else if (!is.null(groups)) {
      legend_label <- "Groups"
    } else {
      legend_label <- get_rank_name(rank)
    }
    p <- add_smart_legend(p, colors, legend_label,
                          legend_position, legend_nrow, legend_ncol)
  }

  # Theme
  if (!is.null(theme_fun)) {
    theme_result <- theme_fun()
    # theme_timetree() returns a list(theme, coord) with clip="off" to prevent
    # collapsed triangle vertices from being clipped at the panel boundary.
    # For backward compatibility, also handle plain theme objects.
    if (is.list(theme_result) && !is.null(theme_result$theme)) {
      p <- p + theme_result$theme
    } else {
      p <- p + theme_result
    }
    # T05 / decision 3 (H1): apply clip="off" via the single sanctioned helper.
    # Previously theme_result$coord (coord_cartesian(clip="off")) was added
    # unconditionally, which overwrote the polar coordinate system used by
    # circular/fan layouts and silently mis-rendered them.
    #
    # When add_timescale = TRUE the coordinate system is already set by
    # add_geo_timescale() (deeptime::coord_geo / coord_geo_radial, both applied
    # with clip = "off"). Adding coord_cartesian/coord_polar here would
    # overwrite that geological coordinate and silently drop the timescale
    # (regression observed on ggplot2 4.x). Only apply the clip-off coord when
    # no timescale coordinate is present.
    if (!isTRUE(add_timescale)) {
      p <- add_clip_off(p, layout)
    }
  } else if (add_timescale || layout == "rectangular") {
    p <- p + ggtree::theme_tree2()
  }

  # Title
  if (!is.null(main_title) || !is.null(sub_title)) {
    title_args <- list()
    title_args$label <- if (!is.null(main_title)) main_title else ""
    if (!is.null(sub_title)) {
      title_args$subtitle <- sub_title
    }
    p <- p + do.call(ggplot2::ggtitle, title_args) +
      ggplot2::theme(
        plot.title = ggplot2::element_text(hjust = 0.5, face = "bold", size = 14),
        plot.subtitle = ggplot2::element_text(hjust = 0.5, color = "grey40", size = 10)
      )
    log_debug("Title added")
  }

  # Save output (backward compatibility)
  if (!is.null(output)) {
    next_step("Saving output")
    log_info("Saving to: %s", output)
    save_timetree(p, output, width, height, overwrite = overwrite)
    log_info("Output saved successfully")
  }

  # Attach metadata
  #
  # v1.1.0 (reviewer issues 2/8): report the full group-status breakdown so
  # results tables can distinguish parsed candidates from groups actually
  # collapsed. `n_groups` is retained for backward compatibility but counts
  # collapsed-plus-singleton groups only; `groups_total` additionally
  # includes every skipped candidate group.
  skipped_non_monophyletic <- attr(mrca_map, "non_monophyletic")
  if (is.null(skipped_non_monophyletic)) skipped_non_monophyletic <- character(0)
  skipped_root <- attr(mrca_map, "skipped_root")
  if (is.null(skipped_root)) skipped_root <- character(0)
  skipped_zero_tip <- attr(mrca_map, "skipped_zero_tip")
  if (is.null(skipped_zero_tip)) skipped_zero_tip <- character(0)
  singleton_names <- names(attr(mrca_map, "singleton_map"))
  attr(p, "rclade_info") <- list(
    n_tips = ape::Ntip(tree),
    n_groups = length(all_group_names),
    groups_total = length(all_group_names) +
      length(skipped_non_monophyletic) + length(skipped_root) + length(skipped_zero_tip),
    groups_collapsed = length(mrca_map),
    groups_singleton = length(singleton_names),
    groups_skipped_non_monophyletic = length(skipped_non_monophyletic),
    groups_skipped_other = length(skipped_root) + length(skipped_zero_tip),
    skipped_non_monophyletic = skipped_non_monophyletic,
    skipped_other = c(skipped_root, skipped_zero_tip),
    actual_ntips = if (!is.null(actual_ntips)) actual_ntips else ape::Ntip(tree),
    taxonomy_format = detected_format,
    rank = rank,
    palette = color_palette,
    layout = layout,
    add_timescale = add_timescale,
    mrca_map = mrca_map
  )

  p
}


#' Single-tree plotting pipeline
#'
#' Orchestrates all pipeline steps for a single phylo object.
#' This is the internal counterpart to \code{plot_timetree()} that handles
#' one tree after batch / file-path resolution has already occurred.
#'
#' @return A ggplot object with \code{rclade_info} attribute.
#' @keywords internal
pt_single_tree <- function(
    tree, rank, clade, strict, groups, triangle_mode, space_mode, layout, angle,
    color_palette, color_mapping, line_width, show_tip_labels, tip_label_size,
    add_timescale, timescale_levels, unit, taxonomy_format, custom_patterns,
    taxonomy_file, taxonomy_file_sep, taxonomy_file_header, taxonomy_file_priority,
    taxonomy_source_priority, taxonomy_table_sep, taxonomy_delimiter_mode,
    legend_position, legend_nrow, legend_ncol, legend_title, show_clade_label,
    show_clade_count, clade_label_offset, clade_label_fontsize, show_support,
    support_threshold, show_hpd, hpd_color, geo_events, timescale_version,
    main_title, sub_title, highlight, highlight_alpha, theme_fun, output, overwrite,
    width, height, taxonomy_levels, low_memory, ignore_malformed, ignore_branch_length,
    color_rank = NULL, timescale_mode = "radial", timescale_position = "right",
    tree_start_position = "right"
) {
  # Resolve taxonomy source priority
  if (!is.null(taxonomy_source_priority)) {
    taxonomy_source_priority <- match.arg(taxonomy_source_priority, c("embedded", "table"))
    taxonomy_file_priority <- (taxonomy_source_priority == "table")
    log_keyvalue("Taxonomy source priority", taxonomy_source_priority)
  }

  # Step 1: Prepare inputs
  s1 <- pt_step1_prepare_inputs(
    tree = tree, tree_index = NULL, multi_tree_mode = "error",
    rank = rank, unit = unit, layout = layout,
    triangle_mode = triangle_mode, space_mode = space_mode,
    add_timescale = add_timescale, groups = groups, clade = clade,
    overwrite = overwrite, ignore_branch_length = ignore_branch_length,
    low_memory = low_memory
  )
  tree        <- s1$tree
  unit        <- s1$unit
  branch_length_mode <- s1$branch_length_mode
  add_timescale <- s1$add_timescale

  # Step 2: Resolve taxonomy
  s2 <- pt_step2_resolve_taxonomy(
    tree = tree, clade = clade, strict = strict, groups = groups,
    rank = rank, taxonomy_format = taxonomy_format,
    custom_patterns = custom_patterns, taxonomy_file = taxonomy_file,
    taxonomy_file_sep = taxonomy_file_sep,
    taxonomy_file_header = taxonomy_file_header,
    taxonomy_file_priority = taxonomy_file_priority,
    taxonomy_table_sep = taxonomy_table_sep,
    taxonomy_delimiter_mode = taxonomy_delimiter_mode,
    taxonomy_levels = taxonomy_levels, low_memory = low_memory
  )
  group_vec       <- s2$group_vec
  detected_format <- s2$detected_format

  # Step 2b: Resolve color taxonomy (decouple coloring from collapsing)
  color_group_vec <- NULL
  # T10 (H8): previously this guard also required !is.null(custom_patterns),
  # which prevented color_rank from working with taxonomy parsed from the
  # embedded tree labels (no custom_patterns supplied).  Drop that guard so
  # color_rank coloring applies to embedded-label parsing as well.
  if (!is.null(color_rank)) {
    color_rank_std <- normalize_rank(color_rank)
    if (color_rank_std != "none") {
      color_taxa_df <- parse_taxonomy_with_file(
        tree$tip.label, color_rank_std, taxonomy_format, custom_patterns,
        taxonomy_file, taxonomy_file_sep, taxonomy_file_header,
        taxonomy_file_priority, taxonomy_table_sep,
        taxonomy_delimiter_mode, taxonomy_levels
      )
      color_group_vec <- setNames(color_taxa_df$Group, color_taxa_df$label)
      log_info("Color rank '%s' parsed: %d groups",
               color_rank, length(unique(na.omit(color_group_vec))))
    }
  }

  # Step 3: Compute MRCA
  s3 <- pt_step3_compute_mrca(
    tree = tree, group_vec = group_vec, clade = clade,
    strict = strict, low_memory = low_memory
  )
  mrca_map       <- s3$mrca_map
  singleton_map  <- s3$singleton_map
  all_group_names <- s3$all_group_names

  # Step 4: Colors
  if (!is.null(color_group_vec)) {
    # Generate colors from color groups (e.g., phyla) instead of collapse groups
    color_group_names <- unique(na.omit(color_group_vec))
    colors <- pt_step4_generate_colors(
      all_group_names = color_group_names,
      color_palette = color_palette,
      color_mapping = color_mapping
    )
    # Extend colors: map collapse group names to their parent color group's color
    if (length(mrca_map) > 0 && !is.null(group_vec)) {
      for (g in names(mrca_map)) {
        tips_in_g <- names(group_vec)[which(group_vec == g)]
        cg <- unique(color_group_vec[tips_in_g])
        cg <- cg[!is.na(cg)]
        if (length(cg) >= 1 && cg[1] %in% names(colors)) {
          colors[g] <- colors[cg[1]]
        }
      }
    }
  } else {
    colors <- pt_step4_generate_colors(
      all_group_names = all_group_names,
      color_palette = color_palette,
      color_mapping = color_mapping
    )
  }

  # Step 5: Render & collapse
  s5 <- pt_step5_render_and_collapse(
    tree = tree, group_vec = group_vec, mrca_map = mrca_map,
    colors = colors, layout = layout, angle = angle,
    line_width = line_width, branch_length_mode = branch_length_mode,
    triangle_mode = triangle_mode, space_mode = space_mode,
    low_memory = low_memory,
    color_group_vec = color_group_vec
  )
  p <- s5$p
  actual_ntips <- s5$actual_ntips

  # Step 6: Annotations
  p <- pt_step6_add_annotations(
    p = p, tree = tree, layout = layout, add_timescale = add_timescale,
    timescale_levels = timescale_levels, actual_ntips = actual_ntips,
    timescale_version = timescale_version,
    show_tip_labels = show_tip_labels, tip_label_size = tip_label_size,
    show_support = show_support, support_threshold = support_threshold,
    show_hpd = show_hpd, hpd_color = hpd_color, geo_events = geo_events,
    show_clade_label = show_clade_label, show_clade_count = show_clade_count,
    clade_label_offset = clade_label_offset,
    clade_label_fontsize = clade_label_fontsize,
    mrca_map = mrca_map, singleton_map = singleton_map,
    highlight = highlight, highlight_alpha = highlight_alpha,
    rank = rank, taxonomy_format = taxonomy_format,
    custom_patterns = custom_patterns,
    taxonomy_delimiter_mode = taxonomy_delimiter_mode,
    taxonomy_levels = taxonomy_levels,
    ignore_branch_length = ignore_branch_length,
    colors = colors,
    timescale_mode = timescale_mode,
    timescale_position = timescale_position,
    angle = angle,
    tree_start_position = tree_start_position
  )

  # Step 7: Finalize
  p <- pt_step7_finalize_plot(
    p = p, colors = colors, groups = groups, rank = rank,
    legend_position = legend_position, legend_nrow = legend_nrow,
    legend_ncol = legend_ncol, legend_title = legend_title,
    theme_fun = theme_fun, add_timescale = add_timescale,
    layout = layout, main_title = main_title, sub_title = sub_title,
    output = output, width = width, height = height, overwrite = overwrite,
    tree = tree, mrca_map = mrca_map, all_group_names = all_group_names,
    actual_ntips = actual_ntips, detected_format = detected_format,
    color_palette = color_palette
  )

  # Log completion
  # v1.1.0 (reviewer issues 2/8): the completion log reports every group
  # status class so automated pipelines can audit partial collapses without
  # parsing intermediate warnings.
  nm_skipped <- attr(mrca_map, "non_monophyletic")
  other_skipped <- unique(c(attr(mrca_map, "skipped_root"),
                            attr(mrca_map, "skipped_zero_tip")))
  log_section("Pipeline Complete")
  log_stats(list(
    "Tips" = ape::Ntip(tree),
    "Groups parsed" = length(all_group_names) +
      length(nm_skipped) + length(other_skipped),
    "Groups collapsed" = length(mrca_map),
    "Singleton groups" = length(attr(mrca_map, "singleton_map")),
    "Skipped (non-monophyletic)" = length(nm_skipped),
    "Skipped (root/zero-tip)" = length(other_skipped),
    "Taxonomy format" = detected_format,
    "Layout" = layout,
    "Timescale" = if (add_timescale) "enabled" else "disabled"
  ))
  log_info("plot_timetree completed successfully")

  p
}
