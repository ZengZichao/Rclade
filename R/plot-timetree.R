# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Main plot_timetree function

#' Plot a phylogenetic tree with geological timescale and taxonomic collapsing
#'
#' The main entry point of Rclade. Takes a phylogenetic tree object or file path
#' and produces a publication-ready visualization with automatic taxonomic collapsing,
#' geological timescale integration, and smart legend layout.
#'
#' This function orchestrates the complete Rclade pipeline:
#' \enumerate{
#'   \item Input validation and reading (format detection, unit conversion)
#'   \item Taxonomy parsing (GTDB/Silva/NCBI/custom, clade/groups/rank modes)
#'   \item MRCA computation and monophyly check (with nesting conflict detection)
#'   \item Color generation (color-blind-safe palette)
#'   \item Tree rendering and batch clade collapsing (ggtree + depth-first collapse)
#'   \item Timescale integration and annotations (deeptime, support, HPD, labels, highlight)
#'   \item Plot finalization (legend, theme, title, save, metadata)
#' }
#'
#' @section Label length guard:
#' When \code{tree} is a file path, Newick labels longer than 500 characters
#' are truncated to 400 characters plus a `_RCLADE_TRUNC` suffix (with a
#' warning) before parsing, because ape's Newick parser aborts the whole R
#' process on labels longer than ~512 characters on Linux. Truncated labels
#' may no longer match external taxonomy files or sequence IDs; shorten
#' labels upstream if exact matching is required. See \code{\link[=read_tree_auto]{read_tree_auto()}}.
#'
#' @section Parameter grouping:
#' For complex configurations, consider organizing parameters by category:
#' \itemize{
#'   \item \strong{Tree input:} \code{tree}
#'   \item \strong{Collapsing:} \code{rank}, \code{triangle_mode}, \code{space_mode}
#'   \item \strong{Layout:} \code{layout}, \code{angle}, \code{line_width}
#'   \item \strong{Colors:} \code{color_palette}, \code{color_mapping}
#'   \item \strong{Labels:} \code{show_tip_labels}, \code{tip_label_size}, \code{show_clade_label}, \code{clade_label_offset}
#'   \item \strong{Timescale:} \code{add_timescale}, \code{timescale_levels}, \code{unit}
#'   \item \strong{Taxonomy:} \code{taxonomy_format}, \code{custom_patterns}
#'   \item \strong{Annotations:} \code{show_support}, \code{support_threshold}, \code{show_hpd}
#'   \item \strong{Legend:} \code{legend_position}, \code{legend_nrow}, \code{legend_ncol}
#'   \item \strong{Output:} \code{output}, \code{width}, \code{height}
#' }
#'
#' @param tree A \code{phylo} or \code{treedata} object, or a file path string
#'   pointing to a Newick (.nwk, .tre, .treefile) or Nexus (.nexus, .nex) file.
#' @param tree_index Integer. Index of tree to use from multiPhylo objects (e.g., BEAST posterior).
#'   Only used when \code{tree} is a file path. Default: NULL (uses multi_tree_mode).
#' @param multi_tree_mode Character. How to handle multiple trees in a file.
#'   Options: \code{"error"} (default), \code{"ask"} (interactive prompt; falls
#'   back to \code{"error"} in non-interactive sessions), \code{"first"},
#'   \code{"last"}, \code{"random"}, \code{"all"} (returns a list of plots in
#'   batch mode), \code{"split"} (same code path as \code{"all"} but signals
#'   per-tree numbered output for pipeline dispatching).
#'   When \code{"error"}, stops with informative message asking user to specify.
#' @param rank Taxonomic rank to collapse at. One of:
#'   \code{"none"}, \code{"kingdom"}, \code{"domain"}, \code{"phylum"}, \code{"class"},
#'   \code{"order"}, \code{"family"}, \code{"genus"}, \code{"species"}, \code{"subspecies"},
#'   or abbreviations \code{"k"}, \code{"d"}, \code{"p"}, \code{"c"}, \code{"o"},
#'   \code{"f"}, \code{"g"}, \code{"s"}, \code{"ss"}. Default: \code{"none"}.
#'   Mutually exclusive with \code{groups}.
#' @param clade Character. Specific clade name to collapse (e.g., "Cyanobacteriota").
#'   When provided, only this clade is checked for monophyly and collapsed if valid.
#'   Mutually exclusive with \code{rank} and \code{groups}. Default: \code{NULL}.
#' @param strict Logical. If \code{TRUE}, non-monophyletic clades cause termination
#'   with error. If \code{FALSE} (default), non-monophyletic clades trigger a warning
#'   and are skipped. The permissive default (\code{FALSE}) is intentional: in
#'   interactive exploration of large trees with potentially inaccurate taxonomy,
#'   halting on the first non-monophyletic group would prevent the user from
#'   seeing any result. Use \code{TRUE} in production pipelines where taxonomic
#'   integrity is critical. Default: \code{FALSE}.
#' @param groups Named list of custom tip groups for collapsing. Each element
#'   is a character vector of tip labels belonging to that group. Groups must be
#'   monophyletic; non-monophyletic groups will raise an error. When \code{groups}
#'   is provided, \code{rank} is ignored (set it to \code{"none"}).
#'   Example: \code{list("Group_A" = c("tip1", "tip2"), "Group_B" = c("tip3"))}.
#' @param triangle_mode Collapse triangle visualization mode.
#'   \code{"max"} shows the full clade range, \code{"min"} shows the minimal range,
#'   \code{"mixed"} uses adaptive selection, \code{"none"} disables triangles.
#'   Default: \code{"mixed"}.
#' @param space_mode Space allocation strategy for collapsed clades.
#'   \code{"equal"} assigns equal vertical space to each clade,
#'   \code{"proportional"} allocates space proportional to tip count.
#'   Default: \code{"proportional"}.
#' @param layout Tree layout. \code{"rectangular"} for standard rectangular layout,
#'   \code{"circular"} for fan/circular layout. Default: \code{"rectangular"}.
#' @param angle Fan angle in degrees for circular layout (0-360).
#'   Only used when \code{layout = "circular"}. Default: \code{360}.
#' @param color_palette Color palette specification. Can be:
#'   \itemize{
#'     \item A palette name: \code{"viridis"} (default), \code{"rainbow"}, or any
#'       RColorBrewer palette name (e.g., \code{"Set1"}, \code{"Paired"})
#'     \item A character vector of hex color codes (recycled if shorter than needed)
#'   }
#' @param color_mapping Named character vector of specific color assignments.
#'   Takes highest priority over \code{color_palette}. Names should match group names.
#'   Example: \code{c("Proteobacteria" = "#E41A1C", "Firmicutes" = "#377EB8")}.
#' @param line_width Branch line width (passed to ggtree). Default: \code{1}.
#' @param show_tip_labels Logical. Whether to display tip labels.
#'   Default: \code{FALSE} (recommended for trees with >100 tips).
#' @param tip_label_size Numeric. Tip label font size. Default: \code{2}.
#' @param add_timescale Logical. Whether to add a geological timescale to the x-axis.
#'   Requires rectangular layout and valid edge lengths. Default: \code{TRUE}.
#' @param timescale_levels Character vector of timescale levels to display.
#'   Options: \code{"eras"}, \code{"eons"}, \code{"periods"}.
#'   Default: \code{c("eras", "eons")}.
#' @param unit Time unit of input tree edge lengths. \code{"Ga"} (giga-annum) or
#'   \code{"Ma"} (mega-annum). If \code{"Ga"}, edge lengths are automatically
#'   converted to Ma (multiplied by 1000). If \code{NULL} (default), the tree's
#'   native units are left untouched; when \code{add_timescale = TRUE} the
#'   pipeline assumes Ma and issues a unit-sanity warning if the median branch
#'   length looks inconsistent (there is no automatic unit detection — specify
#'   the unit explicitly for a correct time axis). Default: \code{NULL}.
#' @param taxonomy_format Taxonomy label format. \code{"auto"} enables automatic
#'   detection via prefix-matching heuristic. Manual options: \code{"GTDB"},
#'   \code{"Silva"}, \code{"NCBI"}, \code{"custom_rank"}, \code{"custom_regex"}.
#'   Default: \code{"auto"}.
#' @param custom_patterns Named list of regex patterns for custom format parsing.
#'   Required when \code{taxonomy_format = "custom_regex"}.
#'   Example: \code{list(domain = "Domain:([^|]+)", phylum = "Phylum:([^|]+)")}.
#' @param taxonomy_file Character. Path to an external taxonomy file. The file
#'   should have two columns: (1) tip labels and (2) taxonomy strings in GTDB
#'   format (e.g., \code{d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria}).
#'   Supports tab-delimited or comma-delimited files. When provided, this file
#'   supplements or overrides label-based taxonomy parsing. Default: \code{NULL}.
#' @param taxonomy_file_sep Character. Column separator for taxonomy file.
#'   \code{"auto"} auto-detects tab or comma. Default: \code{"auto"}.
#' @param taxonomy_file_header Logical. Whether taxonomy file has a header row.
#'   Default: \code{FALSE}.
#' @param taxonomy_file_priority Logical. If \code{TRUE} (default), file taxonomy
#'   takes priority over label-based parsing. If \code{FALSE}, file is used only
#'   for labels that cannot be parsed from the tree. Default: \code{TRUE}.
#'   Superseded by \code{taxonomy_source_priority} if provided.
#' @param taxonomy_source_priority Character. Which taxonomy source takes priority
#'   when both embedded (label-based) and table (file-based) taxonomy are available:
#'   \code{"embedded"} or \code{"table"}. Default: \code{NULL} (use
#'   \code{taxonomy_file_priority}).
#' @param taxonomy_table_sep Character. Separator between taxonomy ranks in the
#'   second column of an external taxonomy file. Default: \code{";"}.
#' @param taxonomy_delimiter_mode Character. Embedded (Format A) parsing strategy:
#'   \code{"reverse"} (right-to-left, default), \code{"greedy"} (left-to-right),
#'   or \code{"segment"} (delimiter-to-delimiter extraction).
#' @param legend_position Legend placement. Can be a cardinal direction
#'   (\code{"bottom"}, \code{"top"}, \code{"right"}, \code{"left"}, \code{"none"})
#'   or a length-2 numeric vector \code{c(x, y)} for inside placement (ggplot2 >= 3.5).
#'   Default: \code{"bottom"} (horizontal layout).
#' @param legend_title Character. Custom legend title. If \code{NULL}, the rank name
#'   (e.g., "Phylum", "Class") is used automatically. Default: \code{NULL}.
#' @param legend_nrow Integer. Number of rows in legend grid. Auto-computed if NULL.
#' @param legend_ncol Integer. Number of columns in legend grid. Auto-computed if NULL.
#' @param show_clade_label Logical. Whether to add clade labels next to collapsed
#'   triangles showing group name and species count. Default: \code{FALSE}.
#' @param show_clade_count Logical. Whether to show species count in clade labels
#'   (e.g., "Proteobacteria (n=42)"). Only used when \code{show_clade_label = TRUE}.
#'   Default: \code{TRUE}.
#' @param clade_label_offset Numeric. Horizontal offset for clade labels from the
#'   right edge of the collapsed triangle in Ma units (0-5000). Default: \code{50}.
#' @param clade_label_fontsize Numeric. Font size for clade labels (1-20).
#'   Default: \code{3}.
#' @param show_support Logical. Whether to display node support values.
#'   Requires treedata input with posterior/bootstrap annotations.
#'   Default: \code{FALSE}.
#' @param support_threshold Numeric. Minimum support value to display (0-1).
#'   Default: \code{0.95}.
#' @param show_hpd Logical. Whether to display HPD (Highest Posterior Density)
#'   intervals. Requires node data with HPD annotations. Default: \code{FALSE}.
#' @param hpd_color Color for HPD bars. Default: \code{"firebrick"}.
#' @param geo_events Data frame of geological events to annotate, with columns
#'   \code{name}, \code{age_min}, \code{age_max} (Ma), \code{color}. If \code{TRUE},
#'   default events (GOE=2400–2000 Ma, NOE=800–550 Ma) are shown. Default: \code{FALSE}.
#' @param timescale_version Geological timescale version string. Currently only
#'   \code{"ICS 2023/02"} is supported. Default: \code{"ICS 2023/02"}.
#' @param main_title Character. Main title for the plot. Default: \code{NULL} (no title).
#' @param sub_title Character. Subtitle for the plot. Default: \code{NULL} (no subtitle).
#' @param highlight Character vector of group names to highlight with colored
#'   backgrounds. Only monophyletic groups are highlighted; non-monophyletic
#'   groups trigger a warning. Supports special identifiers:
#'   \code{"LUCA"} (Last Universal Common Ancestor),
#'   \code{"LACA"} (Last Archaeal Common Ancestor),
#'   \code{"LBCA"} (Last Bacterial Common Ancestor).
#'   Default: \code{NULL} (no highlighting).
#' @param highlight_alpha Numeric. Transparency of highlight color (0-1).
#'   Default: \code{0.2}.
#' @param theme_fun Theme function or NULL. Default: \code{theme_timetree}.
#'   Set to NULL to use default ggplot2 theme.
#' @param output Optional output file path. If provided, the plot is saved
#'   immediately (backward compatibility). Default: \code{NULL}.
#' @param overwrite Character. Overwrite mode when \code{output} file exists:
#'   \code{"ask"} (default; prompts interactively, and in non-interactive
#'   sessions downgrades to skip-saving with a warning), \code{"force"}
#'   (overwrite), or \code{"no-clobber"} (skip saving). Passed to
#'   \code{save_timetree()}.
#' @param taxonomy_levels Optional list for custom taxonomy rank codes and
#'   names, e.g. \code{list(codes = c("k", "ss"), names = c("kingdom", "subspecies"))}.
#'   \code{codes} are the abbreviation letters used in labels (e.g., \code{"k"}, \code{"ss"});
#'   \code{names} are human-readable rank names used as column names in the result data frame.
#'   Used to extend or override default rank handling. Default: \code{NULL}.
#' @param low_memory Logical. If \code{TRUE}, enable best-effort low-memory mode
#'   by triggering garbage collection between major pipeline steps.
#'   Default: \code{FALSE}.
#' @param ignore_malformed Logical. If \code{TRUE}, malformed inputs are skipped
#'   with a warning instead of terminating. In batch mode, failed trees are
#'   returned as \code{NULL}. Default: \code{FALSE}.
#' @param ignore_branch_length Logical. If \code{TRUE}, the tree is drawn as a
#'   cladogram with all tips aligned at the same x position, ignoring the
#'   original branch lengths (equivalent to ggtree's \code{branch.length = "none"}).
#'   This automatically disables the geological timescale. Default: \code{FALSE}.
#' @param color_rank Character. Taxonomic rank for coloring, independent of
#'   \code{rank} (which controls collapsing). When set (e.g., \code{"phylum"}),
#'   branches and tips are colored by this rank, while collapsing uses \code{rank}.
#'   \code{NULL} (default) uses \code{rank} for both coloring and collapsing.
#' @param timescale_mode Character. Timescale display mode for circular layout:
#'   \code{"radial"} (default) draws full-circle geological background bands;
#'   \code{"linear"} draws a rectangular geological timescale axis (via
#'   \code{deeptime::guide_geo()}) at the position specified by
#'   \code{timescale_position}, without background bands.
#'   Ignored for rectangular layout.
#' @param timescale_position Character. Clock position of the timescale axis
#'   when \code{timescale_mode = "linear"}. One of \code{"right"} (3 o'clock,
#'   default), \code{"top"} (12 o'clock), \code{"bottom"} (6 o'clock),
#'   \code{"left"} (9 o'clock). Should match \code{tree_start_position}.
#'   Ignored when \code{timescale_mode = "radial"} or for rectangular layout.
#' @param tree_start_position Character. Clock position where the tree starts
#'   expanding (the gap between the last and first tip). One of \code{"right"}
#'   (3 o'clock, default), \code{"top"} (12 o'clock), \code{"bottom"}
#'   (6 o'clock), \code{"left"} (9 o'clock). Should match
#'   \code{timescale_position} when \code{timescale_mode = "linear"}; a warning
#'   is issued if they differ. Ignored for rectangular layout.
#' @param width Output width in inches. Default: \code{14}.
#' @param height Output height in inches. Default: \code{10}.
#' @param opts A \code{rclade_options} object (see \code{\link{rclade_options}})
#'   or a plain named list of parameter defaults.  When supplied, values in
#'   \code{opts} serve as defaults for parameters the caller did not explicitly
#'   set; explicit arguments always take precedence.  This is the recommended way
#'   to reuse a consistent parameter set across multiple calls.
#' @return A \code{ggplot} object with an \code{rclade_info} attribute containing
#'   metadata (tip count, group count, taxonomy format, etc.).
#'   Can be further customized with \code{+} layers.
#' @examples
#' \dontrun{
#' # From a file with phylum-level collapsing
#' p <- plot_timetree("my_tree.tre", rank = "phylum", unit = "Ma")
#'
#' # From a phylo object with GTDB labels
#' data(example_tree)
#' p <- plot_timetree(example_tree, rank = "phylum",
#'                    taxonomy_format = "GTDB", add_timescale = FALSE)
#'
#' # With external taxonomy file
#' p <- plot_timetree("my_tree.tre", rank = "phylum",
#'                    taxonomy_file = "taxonomy.tsv")
#'
#' # Handle multi-tree file: use first tree
#' p <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "first")
#'
#' # Handle multi-tree file: analyze all trees
#' plots <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "all")
#'
#' # Save directly
#' plot_timetree(tree, rank = "phylum", output = "output.pdf")
#' }
#' @importFrom ggtree %<+%
#' @importFrom stats setNames
#' @references
#' Yu G, Smith DK, Zhu H, Guan Y, Lam TT-Y (2017). "ggtree: an R package for
#' visualization and annotation of phylogenetic trees with their covariates and
#' other associated data." \emph{Methods in Ecology and Evolution}, 8(1),
#' 28-36. doi:10.1111/2041-210X.12628
#'
#' Gearty W (2025). "deeptime: an R package that facilitates highly
#' customizable and reproducible visualizations of data over geological time
#' intervals." \emph{Big Earth Data}. doi:10.1080/20964471.2025.2537516
#'
#' Paradis E, Schliep K (2019). "ape 5.0: an environment for modern
#' phylogenetics and evolutionary analyses in R." \emph{Bioinformatics},
#' 35(3), 526-528. doi:10.1093/bioinformatics/bty633
#' @export
plot_timetree <- function(
    tree,
    tree_index = NULL,
    multi_tree_mode = "error",
    rank = "none",
    triangle_mode = "mixed",
    space_mode = "proportional",
    layout = "rectangular",
    angle = 360,
    color_palette = "viridis",
    color_mapping = NULL,
    line_width = 1,
    show_tip_labels = FALSE,
    tip_label_size = 2,
    add_timescale = TRUE,
    timescale_levels = c("eras", "eons"),
    unit = NULL,
    taxonomy_format = "auto",
    custom_patterns = NULL,
    taxonomy_file = NULL,
    taxonomy_file_sep = "auto",
    taxonomy_file_header = FALSE,
    taxonomy_file_priority = TRUE,
    taxonomy_source_priority = NULL,
    taxonomy_table_sep = ";",
    taxonomy_delimiter_mode = "reverse",
    legend_position = "bottom",
    legend_nrow = NULL,
    legend_ncol = NULL,
    legend_title = NULL,
    clade = NULL,
    strict = FALSE,
    groups = NULL,
    show_clade_label = FALSE,
    show_clade_count = TRUE,
    clade_label_offset = 50,
    clade_label_fontsize = 3,
    show_support = FALSE,
    support_threshold = 0.95,
    show_hpd = FALSE,
    hpd_color = "firebrick",
    geo_events = FALSE,
    timescale_version = "ICS 2023/02",
    main_title = NULL,
    sub_title = NULL,
    highlight = NULL,
    highlight_alpha = 0.2,
    theme_fun = theme_timetree,
    output = NULL,
    overwrite = "ask",
    width = 14, height = 10,
    taxonomy_levels = NULL,
    low_memory = FALSE,
    ignore_malformed = FALSE,
    ignore_branch_length = FALSE,
    color_rank = NULL,
    timescale_mode = "radial",
    timescale_position = "right",
    tree_start_position = "right",
    opts = NULL
) {
  # --- Resolve opts (rclade_options) ---
  # Explicit arguments always take precedence over opts values.
  # opts provides defaults for parameters the caller did not explicitly set.
  if (!is.null(opts)) {
    if (!inherits(opts, "rclade_options") && !is.list(opts)) {
      stop("'opts' must be a list or a rclade_options object (see ?rclade_options)",
           call. = FALSE)
    }
    # Map of formal argument defaults (used to detect "caller left at default")
    .defaults <- list(
      rank = "none", layout = "rectangular", color_palette = "viridis",
      taxonomy_format = "auto", add_timescale = TRUE, timescale_mode = "radial",
      unit = NULL, legend_position = "bottom", line_width = 1,
      show_tip_labels = FALSE, width = 14, height = 10
    )
    # For each key in opts, override the local variable only if the caller
    # left it at its default (i.e., did not explicitly supply a value).
    .env <- environment()
    for (nm in names(opts)) {
      if (nm %in% names(.defaults)) {
        current_val <- get(nm, envir = .env)
        default_val <- .defaults[[nm]]
        # If current value equals the default, apply opts value
        if (identical(current_val, default_val)) {
          assign(nm, opts[[nm]], envir = .env)
        }
      }
    }
  }
  # Initialize logging
  init_steps(7)
  log_section("Rclade: Phylogenetic Tree Visualization")
  log_info("Starting plot_timetree pipeline")
  log_keyvalue("Tree input", if (is.character(tree)) tree else "phylo object")
  log_keyvalue("Rank", rank)
  log_keyvalue("Layout", layout)
  log_keyvalue("Unit", if (is.null(unit)) "auto" else unit)

  # Resolve taxonomy source priority: new parameter supersedes legacy flag
  if (!is.null(taxonomy_source_priority)) {
    taxonomy_source_priority <- match.arg(taxonomy_source_priority,
                                           c("embedded", "table"))
    taxonomy_file_priority <- (taxonomy_source_priority == "table")
    log_keyvalue("Taxonomy source priority", taxonomy_source_priority)
  }

  # Handle file paths and multi-tree inputs
  if (is.character(tree)) {
    tree <- read_tree_auto(tree, tree_index, multi_tree_mode)
  } else {
    if (!is.null(tree_index)) {
      log_warning("tree_index is ignored when 'tree' is a phylo object (not a file path).",
                  .module = "plot-timetree")
    }
  }

  # Build a single parameter list for the single-tree worker.  Per the
  # architecture decision (②), plot_timetree forwards ALL plotting parameters
  # to pt_single_tree through one `args` list + do.call, so the two call
  # sites (single-tree and multiPhylo batch) cannot drift apart.  `tree`,
  # `tree_index`, and `multi_tree_mode` are intentionally excluded: `tree` is
  # injected per call, and the other two are consumed by plot_timetree itself
  # (file-path reading) and are not accepted by pt_single_tree.
  args <- list(
    rank = rank, clade = clade, strict = strict, groups = groups,
    triangle_mode = triangle_mode, space_mode = space_mode,
    layout = layout, angle = angle, color_palette = color_palette,
    color_mapping = color_mapping, line_width = line_width,
    show_tip_labels = show_tip_labels, tip_label_size = tip_label_size,
    add_timescale = add_timescale, timescale_levels = timescale_levels,
    unit = unit, taxonomy_format = taxonomy_format,
    custom_patterns = custom_patterns, taxonomy_file = taxonomy_file,
    taxonomy_file_sep = taxonomy_file_sep,
    taxonomy_file_header = taxonomy_file_header,
    taxonomy_file_priority = taxonomy_file_priority,
    taxonomy_source_priority = taxonomy_source_priority,
    taxonomy_table_sep = taxonomy_table_sep,
    taxonomy_delimiter_mode = taxonomy_delimiter_mode,
    legend_position = legend_position, legend_nrow = legend_nrow,
    legend_ncol = legend_ncol, legend_title = legend_title,
    show_clade_label = show_clade_label,
    show_clade_count = show_clade_count,
    clade_label_offset = clade_label_offset,
    clade_label_fontsize = clade_label_fontsize,
    show_support = show_support, support_threshold = support_threshold,
    show_hpd = show_hpd, hpd_color = hpd_color, geo_events = geo_events,
    timescale_version = timescale_version, main_title = main_title,
    sub_title = sub_title, highlight = highlight,
    highlight_alpha = highlight_alpha, theme_fun = theme_fun,
    output = output, overwrite = overwrite, width = width, height = height,
    taxonomy_levels = taxonomy_levels, low_memory = low_memory,
    ignore_malformed = ignore_malformed,
    ignore_branch_length = ignore_branch_length, color_rank = color_rank,
    timescale_mode = timescale_mode, timescale_position = timescale_position,
    tree_start_position = tree_start_position
  )

  # Batch mode (multiPhylo)
  if (inherits(tree, "multiPhylo")) {
    log_info("Batch mode: processing %d trees", length(tree))
    plots <- vector("list", length(tree))
    for (i in seq_along(tree)) {
      log_info("Processing tree %d/%d", i, length(tree))
      # ignore_malformed contract (documented in ?plot_timetree): in batch
      # mode a failed tree is returned as a NULL placeholder instead of
      # aborting the whole batch.  Single-bracket assignment keeps the NULL
      # placeholder in the list (plots[[i]] <- NULL would delete the slot).
      plots[i] <- list(tryCatch(
        do.call(pt_single_tree, c(list(tree = tree[[i]]), args)),
        error = function(e) {
          if (isTRUE(ignore_malformed)) {
            log_warning("Skipping malformed tree %d/%d: %s", i, length(tree),
                        e$message, .module = "plot-timetree")
            NULL
          } else {
            stop(e)
          }
        }
      ))
    }
    class(plots) <- c("rclade_plot_list", "list")
    return(plots)
  }

  # Single tree mode
  do.call(pt_single_tree, c(list(tree = tree), args))
}
