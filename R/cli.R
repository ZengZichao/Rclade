# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# CLI interface (Suggests: optparse)

#' Get package version with git hash if available
#' @keywords internal
get_version_string <- function() {
  pkg_version <- tryCatch(
    as.character(utils::packageVersion("Rclade")),
    error = function(e) "1.0.0"
  )

  # T07 / E-T1: use the shared get_git_hash() helper instead of the previous
  # inline duplicate implementation.
  git_hash <- get_git_hash()

  sprintf("Rclade %s (git: %s)", pkg_version, git_hash)
}

#' Get dependency versions
#' @keywords internal
get_dependency_versions <- function() {
  deps <- c("ape", "ggtree", "deeptime", "ggplot2", "rlang", "stringr", "tidytree")
  versions <- sapply(deps, function(pkg) {
    tryCatch(
      as.character(utils::packageVersion(pkg)),
      error = function(e) "not installed"
    )
  })
  versions
}

#' Build plot_timetree parameter list from CLI options
#' @keywords internal
build_plot_timetree_params <- function(opt, color_palette, color_mapping = NULL,
                                      taxonomy_levels = NULL) {
  # T08 / E-T1: route ALL "raw string -> structured param" conversions through
  # parse_plot_params() so the CLI and Shiny share one parsing implementation.
  # color_mapping / taxonomy_levels / highlight / taxonomy_file_sep are derived
  # here from the raw opt values (the correspondingly-named function arguments
  # are retained only for backward-compatible call signatures and are ignored).
  parsed <- parse_plot_params(
    color_mapping     = opt$color_mapping,
    taxonomy_levels   = opt$taxonomy_levels,
    highlight         = opt$highlight,
    taxonomy_file_sep = opt$taxonomy_file_sep
  )

  # T08 / H6: new visualization parameters for color-rank decoupling and
  # circular timescale placement are passed straight through.

  list(
    rank = opt$rank,
    clade = opt$clade,
    strict = opt$strict,
    triangle_mode = opt$triangle_mode,
    space_mode = opt$space_mode,
    layout = opt$layout,
    angle = opt$angle,
    # T08 / M-E3: "--unit auto" means "no explicit unit", which maps to NULL
    # so that convert_unit() leaves the tree's native units untouched. Since
    # v1.1.0 this is only valid with --no_timescale; the pipeline aborts when
    # a geological timescale is requested without an explicit unit (fail-safe
    # contract, reviewer issue 1; checked in validate_cli_params).
    unit = if (identical(opt$unit, "auto")) NULL else opt$unit,
    line_width = opt$line_width,
    ignore_branch_length = opt$ignore_branch_length,
    taxonomy_format = opt$taxonomy_format,
    taxonomy_file = opt$taxonomy_file,
    taxonomy_file_sep = parsed$taxonomy_file_sep,
    taxonomy_file_header = opt$taxonomy_file_header,
    taxonomy_source_priority = resolve_taxonomy_source_priority(
      no_taxonomy_file_priority = opt$no_taxonomy_file_priority,
      taxonomy_source_priority = opt$taxonomy_source_priority),
    taxonomy_table_sep = opt$taxonomy_table_sep,
    taxonomy_delimiter_mode = opt$taxonomy_delimiter_mode,
    color_palette = color_palette,
    color_mapping = parsed$color_mapping,
    color_rank = opt$color_rank,
    show_tip_labels = opt$show_tip_labels,
    tip_label_size = opt$tip_label_size,
    show_clade_label = opt$show_clade_label,
    show_clade_count = !opt$no_clade_count,
    clade_label_offset = opt$clade_label_offset,
    clade_label_fontsize = opt$clade_label_fontsize,
    show_support = opt$show_support,
    support_threshold = opt$support_threshold,
    show_hpd = opt$show_hpd,
    hpd_color = opt$hpd_color,
    add_timescale = !opt$no_timescale,
    timescale_levels = trimws(strsplit(opt$timescale_levels, ",")[[1]]),
    timescale_mode = opt$timescale_mode,
    timescale_position = opt$timescale_position,
    tree_start_position = opt$tree_start_position,
    geo_events = opt$geo_events,
    highlight = parsed$highlight,
    highlight_alpha = opt$highlight_alpha,
    legend_position = opt$legend_position,
    legend_nrow = opt$legend_nrow,
    legend_ncol = opt$legend_ncol,
    main_title = opt$main_title,
    sub_title = opt$sub_title,
    taxonomy_levels = parsed$taxonomy_levels,
    low_memory = opt$low_memory,
    ignore_malformed = opt$ignore_malformed
  )
}

#' Extract --config path from raw args (pre-parse)
#'
#' Scans the raw argument vector for `--config <path>` or `--config=<path>`
#' so the config can be loaded before optparse parsing fills in defaults.
#' @keywords internal
.rclade_extract_config <- function(args) {
  if (is.null(args) || length(args) == 0) return(NULL)
  for (i in seq_along(args)) {
    a <- args[i]
    if (a == "--config" && i < length(args)) {
      return(args[i + 1])
    }
    if (startsWith(a, "--config=")) {
      return(sub("^--config=", "", a))
    }
  }
  NULL
}

#' Strip node annotations from a tree (§9.1.1 --strip_annotations)
#'
#' Removes bootstrap/support node labels and NHX comment metadata from a tree
#' so they are not carried into the rendered output. Works on both \code{phylo}
#' and \code{treedata} objects.  For \code{treedata} objects, data columns whose
#' names match common annotation patterns (support values, rates, heights,
#' HPD intervals, comments, NHX/taxid metadata) are dropped; the exact matched
#' column names are logged at INFO level.
#' @param tree A phylo or treedata object.
#' @return The same tree class with annotation fields cleared.
#' @keywords internal
strip_tree_annotations <- function(tree) {
  if (inherits(tree, "treedata")) {
    # treeio treedata: drop support/comment-like fields from node data by
    # pattern (covers BEAST2 rate/height/HPD columns as well as bootstrap,
    # posterior, NHX and taxid metadata produced by treeio readers).
    if (!is.null(tree@data) && ncol(tree@data) > 0) {
      anno_pattern <- paste0(
        "^(bootstrap|posterior|support|prob(ability)?|rate|height(_.*)?|",
        "length(_.*)?|hpd(_.*)?|comment|nhx|taxid)$|",
        "_hpd(_|$)|_HPD(_|$)|_median$|_upper$|_lower$|_95%"
      )
      drop_cols <- grep(anno_pattern, names(tree@data),
                        ignore.case = TRUE, value = TRUE)
      if (length(drop_cols) > 0) {
        log_info("strip_annotations: dropping treedata columns: %s",
                 paste(drop_cols, collapse = ", "), .module = "cli/strip_tree_annotations")
        keep <- setdiff(names(tree@data), drop_cols)
        tree@data <- tree@data[, keep, drop = FALSE]
      }
    }
    return(tree)
  }
  if (inherits(tree, "phylo")) {
    # phylo: node labels typically hold bootstrap/support values
    tree$node.label <- NULL
    # Remove any attached comment attribute (NHX)
    attr(tree, "comment") <- NULL
    return(tree)
  }
  tree
}

#' Print version information
#' @keywords internal
print_version <- function() {
  cat(get_version_string(), "\n\n")
  cat("Dependency versions:\n")
  deps <- get_dependency_versions()
  for (i in seq_along(deps)) {
    cat(sprintf("  %-12s %s\n", names(deps)[i], deps[i]))
  }
}

#' Validate input parameters
#' @keywords internal
validate_cli_params <- function(opt) {
  errors <- character(0)

  # Validate input file
  if (is.null(opt$file)) {
    errors <- c(errors, "Input file (-f/--file) is required.")
  } else if (!file.exists(opt$file)) {
    errors <- c(errors, sprintf("Input file does not exist: %s", opt$file))
  }

  # Validate tree_index
  if (!is.null(opt$tree_index) && opt$tree_index < 1) {
    errors <- c(errors, "tree_index must be a positive integer (>= 1).")
  }

  # Validate rank
  valid_ranks <- c("none", "kingdom", "domain", "phylum", "class", "order", "family", "genus", "species", "subspecies",
                    "k", "d", "p", "c", "o", "f", "g", "s", "ss")
  if (!opt$rank %in% valid_ranks) {
    errors <- c(errors, sprintf("Invalid rank: '%s'. Valid: %s",
                                 opt$rank, paste(valid_ranks, collapse = ", ")))
  }

  # Validate triangle_mode
  valid_triangle_modes <- c("max", "min", "mixed", "none")
  if (!opt$triangle_mode %in% valid_triangle_modes) {
    errors <- c(errors, sprintf("Invalid triangle_mode: '%s'. Valid: %s",
                                 opt$triangle_mode, paste(valid_triangle_modes, collapse = ", ")))
  }

  # Validate space_mode
  valid_space_modes <- c("equal", "proportional")
  if (!opt$space_mode %in% valid_space_modes) {
    errors <- c(errors, sprintf("Invalid space_mode: '%s'. Valid: %s",
                                 opt$space_mode, paste(valid_space_modes, collapse = ", ")))
  }

  # Validate layout
  valid_layouts <- c("rectangular", "circular")
  if (!opt$layout %in% valid_layouts) {
    errors <- c(errors, sprintf("Invalid layout: '%s'. Valid: %s",
                                 opt$layout, paste(valid_layouts, collapse = ", ")))
  }

  # Validate unit
  valid_units <- c("auto", "Ga", "Ma")
  if (!opt$unit %in% valid_units) {
    errors <- c(errors, sprintf("Invalid unit: '%s'. Valid: %s",
                                 opt$unit, paste(valid_units, collapse = ", ")))
  }

  # Fail-safe unit contract (v1.1.0, reviewer issue 1): a geological
  # timescale requires an explicit unit. Rclade never infers branch-length
  # units. Report this as a parameter error (exit code 2) rather than a
  # runtime failure.
  if (identical(opt$unit, "auto") && !isTRUE(opt$no_timescale)) {
    errors <- c(errors, paste0(
      "--unit must be 'Ma' or 'Ga' when the geological timescale is ",
      "enabled (default). Rclade does not infer branch-length units. ",
      "Pass --unit Ma / --unit Ga for a time-calibrated tree, or add ",
      "--no_timescale for trees without time-calibrated branch lengths."))
  }

  # Validate color_rank (same vocabulary as rank) — T08 / H6
  if (!is.null(opt$color_rank) && !opt$color_rank %in% valid_ranks) {
    errors <- c(errors, sprintf("Invalid color_rank: '%s'. Valid: %s",
                                 opt$color_rank, paste(valid_ranks, collapse = ", ")))
  }

  # Validate timescale_mode — T08 / H6
  valid_timescale_modes <- c("radial", "linear")
  if (!opt$timescale_mode %in% valid_timescale_modes) {
    errors <- c(errors, sprintf("Invalid timescale_mode: '%s'. Valid: %s",
                                 opt$timescale_mode, paste(valid_timescale_modes, collapse = ", ")))
  }

  # Validate timescale_position / tree_start_position — T08 / H6
  valid_positions <- c("right", "left", "top", "bottom")
  if (!opt$timescale_position %in% valid_positions) {
    errors <- c(errors, sprintf("Invalid timescale_position: '%s'. Valid: %s",
                                 opt$timescale_position, paste(valid_positions, collapse = ", ")))
  }
  if (!opt$tree_start_position %in% valid_positions) {
    errors <- c(errors, sprintf("Invalid tree_start_position: '%s'. Valid: %s",
                                 opt$tree_start_position, paste(valid_positions, collapse = ", ")))
  }
  # For linear timescale, the axis position should match the tree start gap.
  if (opt$timescale_mode == "linear" &&
      !identical(opt$timescale_position, opt$tree_start_position)) {
    log_warning("timescale_position ('%s') differs from tree_start_position ('%s'); the linear timescale axis may not align with the tree gap.",
                opt$timescale_position, opt$tree_start_position,
                .module = "cli/validate_cli_params")
  }

  # Validate taxonomy_format
  valid_taxonomy_formats <- c("auto", "GTDB", "Silva", "NCBI", "custom_rank", "custom_regex")
  if (!opt$taxonomy_format %in% valid_taxonomy_formats) {
    errors <- c(errors, sprintf("Invalid taxonomy_format: '%s'. Valid: %s",
                                 opt$taxonomy_format, paste(valid_taxonomy_formats, collapse = ", ")))
  }

  # Validate taxonomy_file
  if (!is.null(opt$taxonomy_file) && !file.exists(opt$taxonomy_file)) {
    errors <- c(errors, sprintf("Taxonomy file does not exist: %s", opt$taxonomy_file))
  }

  # Validate taxonomy_file_sep
  valid_seps <- c("auto", "tab", "comma")
  if (!opt$taxonomy_file_sep %in% valid_seps) {
    errors <- c(errors, sprintf("Invalid taxonomy_file_sep: '%s'. Valid: %s",
                                 opt$taxonomy_file_sep, paste(valid_seps, collapse = ", ")))
  }

  # Validate taxonomy_delimiter_mode
  valid_delim_modes <- c("reverse", "greedy", "segment")
  if (!opt$taxonomy_delimiter_mode %in% valid_delim_modes) {
    errors <- c(errors, sprintf("Invalid taxonomy_delimiter_mode: '%s'. Valid: %s",
                                 opt$taxonomy_delimiter_mode, paste(valid_delim_modes, collapse = ", ")))
  }

  # Validate taxonomy_source_priority
  valid_priorities <- c("embedded", "table")
  if (!opt$taxonomy_source_priority %in% valid_priorities) {
    errors <- c(errors, sprintf("Invalid taxonomy_source_priority: '%s'. Valid: %s",
                                 opt$taxonomy_source_priority, paste(valid_priorities, collapse = ", ")))
  }

  # Validate mol_type
  valid_mol_types <- c("auto", "DNA", "RNA", "protein")
  if (!toupper(opt$mol_type) %in% toupper(valid_mol_types)) {
    errors <- c(errors, sprintf("Invalid mol_type: '%s'. Valid: %s",
                                 opt$mol_type, paste(valid_mol_types, collapse = ", ")))
  }

  # Validate force/no_clobber conflict
  if (opt$force && opt$no_clobber) {
    errors <- c(errors, "--force and --no_clobber cannot be used together.")
  }

  # Validate multi_tree_mode
  valid_multi_modes <- c("error", "ask", "first", "last", "random", "all", "split")
  if (!opt$multi_tree_mode %in% valid_multi_modes) {
    errors <- c(errors, sprintf("Invalid multi_tree_mode: '%s'. Valid: %s",
                                 opt$multi_tree_mode, paste(valid_multi_modes, collapse = ", ")))
  }

  # Validate sequence_file
  if (!is.null(opt$sequence_file) && !file.exists(opt$sequence_file)) {
    errors <- c(errors, sprintf("Sequence file does not exist: %s", opt$sequence_file))
  }

  # Validate log_level
  valid_log_levels <- c("DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL")
  if (!toupper(opt$log_level) %in% valid_log_levels) {
    errors <- c(errors, sprintf("Invalid log_level: '%s'. Valid: %s",
                                 opt$log_level, paste(valid_log_levels, collapse = ", ")))
  }

  # Validate dimensions
  if (opt$width <= 0 || opt$width > 100) {
    errors <- c(errors, "Width must be between 0 and 100 inches.")
  }
  if (opt$height <= 0 || opt$height > 100) {
    errors <- c(errors, "Height must be between 0 and 100 inches.")
  }

  # Validate output directory exists
  out_dir <- dirname(opt$out)
  if (out_dir != "." && !dir.exists(out_dir)) {
    errors <- c(errors, sprintf("Output directory does not exist: %s", out_dir))
  }

  # Validate new visualization parameters
  if (opt$angle < 10 || opt$angle > 360) {
    errors <- c(errors, "angle must be between 10 and 360 degrees.")
  }
  if (opt$line_width <= 0) {
    errors <- c(errors, "line_width must be positive.")
  }
  if (opt$tip_label_size <= 0) {
    errors <- c(errors, "tip_label_size must be positive.")
  }
  if (opt$support_threshold < 0 || opt$support_threshold > 1) {
    errors <- c(errors, "support_threshold must be between 0 and 1.")
  }
  if (opt$highlight_alpha < 0 || opt$highlight_alpha > 1) {
    errors <- c(errors, "highlight_alpha must be between 0 and 1.")
  }
  valid_legend_positions <- c("bottom", "right", "left", "top", "none")
  if (!opt$legend_position %in% valid_legend_positions) {
    errors <- c(errors, sprintf("Invalid legend_position: '%s'. Valid: %s",
                                 opt$legend_position, paste(valid_legend_positions, collapse = ", ")))
  }
  valid_timescale_levels <- c("eons", "eras", "periods")
  parsed_levels <- trimws(strsplit(opt$timescale_levels, ",")[[1]])
  invalid_levels <- setdiff(parsed_levels, valid_timescale_levels)
  if (length(invalid_levels) > 0) {
    errors <- c(errors, sprintf("Invalid timescale_levels: '%s'. Valid: %s",
                                 paste(invalid_levels, collapse = ", "),
                                 paste(valid_timescale_levels, collapse = ", ")))
  }

  return(errors)
}

#' Run Rclade from the command line
#'
#' Provides a command-line interface for Rclade. Requires the optparse package.
#'
#' @section Config-file override trap (L-E3 — READ BEFORE USING \code{--config}):
#' A \code{--config} YAML file supplies \strong{defaults} for any option, with
#' precedence \code{CLI explicit argument > config file > built-in default}.
#' Because \code{optparse} does not expose "was this flag passed?", the override
#' is applied by comparing each option against its \strong{built-in default}:
#' \strong{any option the user left at its default value is eligible to be
#' overridden by the config file} — \emph{even if the user explicitly typed a
#' value identical to the default}.  Concretely:
#' \itemize{
#'   \item \code{plot_timetree --rank phylum} (where \code{"phylum"} is the
#'     default) \strong{will be overridden} by \code{rank: class} in the config.
#'   \item \code{plot_timetree --rank species} (non-default) is preserved.
#' }
#' This is an \code{optparse} limitation, not a bug, and is \strong{intentional
#' but surprising}.  To make an option immune to config, pass a non-default value,
#' or avoid relying on config for options you care about.  Unknown config keys are
#' warned and ignored.
#'
#' @param args Character vector of command-line arguments
#'   (default: commandArgs(trailingOnly = TRUE))
#'
#' @return An invisible integer exit code following standard Unix conventions:
#'   \code{0L} (success), \code{1L} (runtime error), \code{2L} (parameter error),
#'   \code{3L} (input-data error), \code{130L} (user interrupt / SIGINT).
#'   \strong{The caller MUST pass this value to \code{q(status = ...)} or
#'   \code{quit(status = ...)} for the exit code to propagate to the operating
#'   system}; simply calling \code{run_rclade_cli()} without forwarding the
#'   return value will always exit with code 0 regardless of errors.
#'
#' @examples
#' # Correct usage in an Rscript entry point:
#' \dontrun{
#'   q(status = Rclade::run_rclade_cli(commandArgs(trailingOnly = TRUE)))
#' }
#'
#' # The Dockerfile ENTRYPOINT uses the same pattern:
#' # Rscript -e 'q(status = Rclade::run_rclade_cli(commandArgs(TRUE)))'
#'
#' @export
run_rclade_cli <- function(args = commandArgs(trailingOnly = TRUE)) {
  if (!requireNamespace("optparse", quietly = TRUE)) {
    stop("CLI interface requires the optparse package: install.packages('optparse')",
         call. = FALSE)
  }

  # --- Configuration file pre-pass (§8.1) ---
  # A YAML config file may supply defaults for any option. Precedence:
  #   CLI explicit > config file > built-in default.
  # optparse does not expose "was this flag passed", so config values are
  # applied to options that are still at their built-in default. This means
  # a user who explicitly passes a value equal to the default would see it
  # overridden by the config; this is a documented optparse limitation.
  config_path <- .rclade_extract_config(args)
  config_list <- NULL
  if (!is.null(config_path)) {
    if (!file.exists(config_path)) {
      message("Error: config file does not exist: ", config_path)
      return(invisible(2L))  # Exit code 2: parameter error
    }
    if (!requireNamespace("yaml", quietly = TRUE)) {
      message("Error: --config requires the yaml package: install.packages('yaml')")
      return(invisible(2L))
    }
    config_list <- tryCatch(
      yaml::read_yaml(config_path),
      error = function(e) {
        message("Error: failed to parse config file: ", e$message)
        return(invisible(2L))
      }
    )
    if (is.numeric(config_list) && length(config_list) == 1) {
      # read_yaml returned an exit code from the error handler above
      return(invisible(2L))
    }
    if (!is.list(config_list)) {
      message("Error: config file must contain a YAML mapping at the top level.")
      return(invisible(2L))
    }
  }

  # Define options with detailed help
  option_list <- list(
    # Input/Output
    optparse::make_option(c("-f", "--file"), type = "character", default = NULL,
                help = "Input tree file. Supported formats: Newick (.nwk, .tre, .treefile), Nexus (.nexus, .nex), BEAST XML (.xml). [REQUIRED]",
                metavar = "FILE"),
    optparse::make_option(c("-o", "--out"), type = "character", default = "timetree_plot.pdf",
                help = "Output file path. Format determined by extension: PDF, PNG, SVG, TIFF, EPS. [default: %default]",
                metavar = "OUTPUT"),
    optparse::make_option(c("-W", "--width"), type = "numeric", default = 14,
                help = "Output width in inches (1-100). [default: %default]",
                metavar = "WIDTH"),
    optparse::make_option(c("-H", "--height"), type = "numeric", default = 10,
                help = "Output height in inches (1-100). [default: %default]",
                metavar = "HEIGHT"),

    # Multi-tree handling
    optparse::make_option(c("--tree_index"), type = "integer", default = NULL,
                help = "Index of tree to use from multi-tree file (1-based). Overrides --multi_tree_mode.",
                metavar = "N"),
    optparse::make_option(c("--multi_tree_mode"), type = "character", default = "error",
                help = "Multi-tree handling strategy: error (stop), ask (interactive), first, last, random, all (batch, R API), split (batch, numbered output). 'split' is identical to 'all' internally but signals numbered file output. [default: %default]",
                metavar = "MODE"),

    # Taxonomy
    optparse::make_option(c("-r", "--rank"), type = "character", default = "none",
                help = "Taxonomic rank to collapse: none/domain/phylum/class/order/family/genus/species (or d/p/c/o/f/g/s). [default: %default]",
                metavar = "RANK"),
    optparse::make_option(c("--clade"), type = "character", default = NULL,
                help = "Specific clade name to collapse (e.g., 'Cyanobacteriota'). Checks monophyly first. Mutually exclusive with --rank.",
                metavar = "NAME"),
    optparse::make_option(c("--strict"), action = "store_true", default = FALSE,
                help = "Terminate with error if specified clade is not monophyletic (default: warn and skip)."),
    optparse::make_option(c("--taxonomy_format"), type = "character", default = "auto",
                help = "Taxonomy label format: auto (detect), GTDB, Silva, NCBI, custom_rank, custom_regex. [default: %default]",
                metavar = "FORMAT"),
    optparse::make_option(c("--taxonomy_file"), type = "character", default = NULL,
                help = "External taxonomy file (TSV or CSV). Column 1: tip labels, Column 2: GTDB-format taxonomy strings.",
                metavar = "FILE"),
    optparse::make_option(c("--taxonomy_file_sep"), type = "character", default = "auto",
                help = "Taxonomy file separator: auto (detect), tab, comma. [default: %default]",
                metavar = "SEP"),
    optparse::make_option(c("--taxonomy_file_header"), action = "store_true", default = FALSE,
                help = "Taxonomy file has a header row. [default: %default]"),
    optparse::make_option(c("--no_taxonomy_file_priority"), action = "store_true", default = FALSE,
                help = "Use file taxonomy only when label parsing fails (lower priority)."),

    # Visualization
    optparse::make_option(c("-t", "--triangle_mode"), type = "character", default = "mixed",
                help = "Triangle visualization mode: max (full range), min (minimal), mixed (adaptive), none. [default: %default]",
                metavar = "MODE"),
    optparse::make_option(c("-s", "--space_mode"), type = "character", default = "proportional",
                help = "Space allocation: equal (same space per clade), proportional (by tip count). [default: %default]",
                metavar = "MODE"),
    optparse::make_option(c("-l", "--layout"), type = "character", default = "rectangular",
                help = "Tree layout: rectangular, circular (fan). [default: %default]",
                metavar = "LAYOUT"),
    optparse::make_option(c("-u", "--unit"), type = "character", default = "auto",
                help = "Time unit of edge lengths: Ga (giga-annum; edge lengths are multiplied by 1000) or Ma (mega-annum). Required when the geological timescale is enabled. 'auto' leaves tree units untouched and is only valid together with --no_timescale (Rclade does not infer units). [default: %default]",
                metavar = "UNIT"),
    optparse::make_option(c("--angle"), type = "numeric", default = 360,
                help = "Fan angle for circular layout (10-360 degrees). [default: %default]",
                metavar = "DEGREES"),
    optparse::make_option(c("--line_width"), type = "numeric", default = 1,
                help = "Branch line width. [default: %default]",
                metavar = "WIDTH"),
    optparse::make_option(c("--ignore_branch_length"), action = "store_true", default = FALSE,
                help = "Use cladogram mode (ignore branch lengths, equal branch display)."),

    # Color-by-rank (decoupled from collapsing rank) — T08 / H6
    optparse::make_option(c("--color_rank"), type = "character", default = NULL,
                help = "Taxonomic rank to COLOR branches by, independent of --rank (which controls collapsing). e.g. phylum. [default: none]",
                metavar = "RANK"),

    # Timescale mode / position (circular layout) — T08 / H6
    optparse::make_option(c("--timescale_mode"), type = "character", default = "radial",
                help = "Circular-layout timescale mode: radial (full-circle geological background bands) or linear (rectangular geological axis). [default: %default]",
                metavar = "MODE"),
    optparse::make_option(c("--timescale_position"), type = "character", default = "right",
                help = "Clock position of the linear timescale axis: right, left, top, bottom (circular layout only). [default: %default]",
                metavar = "POS"),
    optparse::make_option(c("--tree_start_position"), type = "character", default = "right",
                help = "Clock position where the tree starts expanding (gap between last/first tip): right, left, top, bottom (circular layout only). [default: %default]",
                metavar = "POS"),

    # Colors
    optparse::make_option(c("--color_palette"), type = "character", default = "viridis",
                help = "Color palette: viridis, rainbow, or RColorBrewer name (e.g., Set1, Paired). Hex colors: #FF0000,#00FF00. [default: %default]",
                metavar = "PALETTE"),
    optparse::make_option(c("--color_mapping"), type = "character", default = NULL,
                help = "Specific color assignments: 'Group1:#FF0000,Group2:#00FF00'.",
                metavar = "MAPPING"),

    # Labels
    optparse::make_option(c("--show_tip_labels"), action = "store_true", default = FALSE,
                help = "Display tip labels on the tree."),
    optparse::make_option(c("--tip_label_size"), type = "numeric", default = 2,
                help = "Tip label font size. [default: %default]",
                metavar = "SIZE"),
    optparse::make_option(c("--show_clade_label"), action = "store_true", default = FALSE,
                help = "Display clade labels next to collapsed triangles."),
    optparse::make_option(c("--no_clade_count"), action = "store_true", default = FALSE,
                help = "Hide tip count in clade labels (default: show count)."),
    optparse::make_option(c("--clade_label_offset"), type = "numeric", default = 50,
                help = "Clade label offset from triangle edge. [default: %default]",
                metavar = "OFFSET"),
    optparse::make_option(c("--clade_label_fontsize"), type = "numeric", default = 3,
                help = "Clade label font size. [default: %default]",
                metavar = "SIZE"),
    optparse::make_option(c("--show_support"), action = "store_true", default = FALSE,
                help = "Display node support values (requires treedata input)."),
    optparse::make_option(c("--support_threshold"), type = "numeric", default = 0.95,
                help = "Minimum support value to display (0-1). [default: %default]",
                metavar = "THRESHOLD"),
    optparse::make_option(c("--show_hpd"), action = "store_true", default = FALSE,
                help = "Display HPD intervals (requires treedata input with HPD data)."),
    optparse::make_option(c("--hpd_color"), type = "character", default = "firebrick",
                help = "HPD interval bar color. [default: %default]",
                metavar = "COLOR"),

    # Legend
    optparse::make_option(c("--legend_position"), type = "character", default = "bottom",
                help = "Legend position: bottom, right, left, top, none. [default: %default]",
                metavar = "POS"),
    optparse::make_option(c("--legend_nrow"), type = "integer", default = NULL,
                help = "Number of legend rows (auto if not set).",
                metavar = "N"),
    optparse::make_option(c("--legend_ncol"), type = "integer", default = NULL,
                help = "Number of legend columns (auto if not set).",
                metavar = "N"),

    # Timescale
    optparse::make_option(c("--no_timescale"), action = "store_true", default = FALSE,
                help = "Disable geological timescale on x-axis."),
    optparse::make_option(c("--timescale_levels"), type = "character", default = "eras,eons",
                help = "Timescale levels to display (comma-separated): eons,eras,periods. [default: %default]",
                metavar = "LEVELS"),
    optparse::make_option(c("--geo_events"), action = "store_true", default = FALSE,
                help = "Show built-in geological event bands (GOE, NOE)."),

    # Highlight
    optparse::make_option(c("--highlight"), type = "character", default = NULL,
                help = "Comma-separated clade names to highlight (e.g., 'Proteobacteria,Cyanobacteriota').",
                metavar = "CLADES"),
    optparse::make_option(c("--highlight_alpha"), type = "numeric", default = 0.2,
                help = "Highlight transparency (0-1). [default: %default]",
                metavar = "ALPHA"),

    # Titles
    optparse::make_option(c("--main_title"), type = "character", default = NULL,
                help = "Plot main title.",
                metavar = "TITLE"),
    optparse::make_option(c("--sub_title"), type = "character", default = NULL,
                help = "Plot subtitle.",
                metavar = "SUBTITLE"),

    # Logging
    optparse::make_option(c("--log_level"), type = "character", default = "INFO",
                help = "Logging verbosity: DEBUG, INFO, WARNING, ERROR, CRITICAL. [default: %default]",
                metavar = "LEVEL"),
    optparse::make_option(c("--log_file"), type = "character", default = NULL,
                help = "Write log to file (UTF-8, real-time flush).",
                metavar = "FILE"),

    # Taxonomy parsing
    optparse::make_option(c("--taxonomy_delimiter_mode"), type = "character", default = "reverse",
                help = "Embedded format parsing strategy: reverse (right-to-left), greedy (left-to-right), segment. [default: %default]",
                metavar = "MODE"),
    optparse::make_option(c("--taxonomy_source_priority"), type = "character", default = "table",
                help = "When both embedded and table taxonomy exist: embedded, table. [default: %default]",
                metavar = "PRIORITY"),
    optparse::make_option(c("--taxonomy_table_sep"), type = "character", default = ";",
                help = "Separator for taxonomy table values. [default: %default]",
                metavar = "SEP"),
    optparse::make_option(c("--taxonomy_levels"), type = "character", default = NULL,
                help = "Custom taxonomy level prefixes, e.g. 'k:_k_,ss:_ss_'.",
                metavar = "LEVELS"),

    # Sequence options
    optparse::make_option(c("--mol_type"), type = "character", default = "auto",
                help = "Molecule type for sequence validation: DNA, RNA, protein, auto. [default: %default]",
                metavar = "TYPE"),
    optparse::make_option(c("--skip_length_check"), action = "store_true", default = FALSE,
                help = "Skip alignment length consistency check for sequences."),
    optparse::make_option(c("--no_cross_check"), action = "store_true", default = FALSE,
                help = "Disable tree-sequence label cross-validation."),
    optparse::make_option(c("--sequence_file"), type = "character", default = NULL,
                help = "Sequence file for cross-validation with tree (FASTA/FASTQ).",
                metavar = "FILE"),

    # Output control
    optparse::make_option(c("--force"), action = "store_true", default = FALSE,
                help = "Overwrite existing output files."),
    optparse::make_option(c("--no_clobber"), action = "store_true", default = FALSE,
                help = "Skip if output file already exists (no overwrite)."),
    optparse::make_option(c("--ignore_malformed"), action = "store_true", default = FALSE,
                help = "Skip malformed inputs instead of terminating."),
    optparse::make_option(c("--low_memory"), action = "store_true", default = FALSE,
                help = "Use low-memory mode for large datasets."),

    # Self-test
    optparse::make_option(c("--check"), action = "store_true", default = FALSE,
                help = "Run self-test and exit."),

    # Annotations (§9.1.1)
    optparse::make_option(c("--strip_annotations"), action = "store_true", default = FALSE,
                help = "Discard tree node annotations (bootstrap/NHX) to reduce output size."),

    # Configuration file (§8.1)
    optparse::make_option(c("--config"), type = "character", default = NULL,
                help = "Path to YAML config file. CLI args override config; config overrides defaults. [default: none]",
                metavar = "FILE"),

    # Version
    optparse::make_option(c("-v", "--version"), action = "store_true", default = FALSE,
                help = "Show version information and exit.")
  )

  # Create parser with detailed description
  opt_parser <- optparse::OptionParser(
    option_list = option_list,
    usage = "Usage: %prog -f <tree_file> [options]\n\n       %prog -f tree.tre -r phylum -o output.pdf\n       %prog -f beast.trees --multi_tree_mode all -r phylum",
    description = paste(
      "Rclade: Automated Deep-Time Phylogenetic Tree Collapsing and Visualization",
      "",
      "Rclade provides a single-function pipeline for automated collapsing and",
      "visualization of large phylogenetic trees with geological timescales.",
      "It supports multiple taxonomy formats (GTDB, Silva, NCBI), automatic",
      "monophyly checking, and batch processing of multi-tree files.",
      "",
      "Third-party dependencies and licenses:",
      "  ape (>= 5.0, GPL-2+), ggtree (>= 4.0, Artistic-2.0),",
      "  deeptime (>= 1.0, GPL-3, Gearty 2025), ggplot2 (>= 3.5, MIT),",
      "  rlang (>= 1.0, MIT), stringr (>= 1.5, MIT),",
      "  tidytree (>= 0.4, Artistic-2.0)",
      "",
      "Optional: treeio (Artistic-2.0), phangorn (GPL-2+)",
      "          RColorBrewer (Apache-2.0), viridisLite (MIT)",
      sep = "\n"
    ),
    epilogue = paste(
      "EXAMPLES:",
      "",
      "  # Basic usage with phylum-level collapsing",
      "  Rclade -f tree.tre -r phylum -o output.pdf",
      "",
      "  # With GTDB format and Ma time units",
      "  Rclade -f tree.tre -r phylum --taxonomy_format GTDB -u Ma -o output.pdf",
      "",
      "  # With external taxonomy file",
      "  Rclade -f tree.tre -r phylum --taxonomy_file taxonomy.tsv -o output.pdf",
      "",
      "  # Process all trees in a BEAST posterior file",
      "  Rclade -f beast.trees --multi_tree_mode all -r phylum -o output.pdf",
      "",
      "  # Use specific tree from multi-tree file",
      "  Rclade -f beast.trees --tree_index 42 -r phylum -o output.pdf",
      "",
      "  # Circular layout with class-level collapsing",
      "  Rclade -f tree.tre -r class -l circular -o output.png",
      "",
      "  # Debug logging",
      "  Rclade -f tree.tre -r phylum --log_level DEBUG -o output.pdf",
      "",
      "  # Show version",
      "  Rclade --version",
      sep = "\n"
    )
  )

  # Parse arguments
  opt <- tryCatch(
    optparse::parse_args(opt_parser, args = args, positional_arguments = FALSE,
                         print_help_and_exit = FALSE),
    error = function(e) {
      message("Error: ", e$message)
      return(NULL)
    }
  )

  if (is.null(opt)) {
    optparse::print_help(opt_parser)
    return(invisible(2L))  # Exit code 2: parameter/parse error
  }

  # Work around an optparse (>= 1.8) prefix-collision: when one long option
  # name is a strict prefix of another (e.g. --highlight vs --highlight_alpha,
  # --clade vs --clade_label_offset, --taxonomy_file vs --taxonomy_file_sep),
  # the sibling's default leaks into the shorter option's slot whenever the
  # shorter option was not explicitly passed (verified on optparse 1.8.2:
  # opt$highlight == 0.2 with no --highlight flag, which then reached
  # highlight_clades() as a bogus empty group and aborted the run).
  # Restore the declared defaults unless the flag was supplied explicitly.
  .fix_prefix_leaks <- function(opt, args) {
    flags <- args[startsWith(args, "--")]
    passed <- unique(sub("=.*$", "", flags))
    sibling_defaults <- list(
      highlight = NULL,
      clade = NULL,
      taxonomy_file = NULL
    )
    for (nm in names(sibling_defaults)) {
      # Single-bracket assignment keeps the named element present (with a NULL
      # value); `opt[[nm]] <- NULL` would DELETE it, after which opt$nm would
      # partial-match the sibling option (e.g. highlight -> highlight_alpha)
      # and reintroduce the leak.
      if (!paste0("--", nm) %in% passed) opt[nm] <- list(sibling_defaults[[nm]])
    }
    opt
  }
  opt <- .fix_prefix_leaks(opt, args)

  # Handle help flag
  if (isTRUE(opt$help)) {
    optparse::print_help(opt_parser)
    return(invisible(0L))
  }

  # Handle version flag
  if (opt$version) {
    print_version()
    return(invisible(0L))
  }

  # Handle self-test flag
  if (opt$check) {
    exit_code <- run_rclade_selftest()
    return(invisible(exit_code))
  }

  # Apply config-file overrides (§8.1): config fills options left at default.
  if (!is.null(config_list)) {
    # Parse empty args to obtain the built-in defaults; any option the user
    # left at default is eligible for a config override.
    baseline <- optparse::parse_args(opt_parser, args = character(0),
                                     positional_arguments = FALSE,
                                     print_help_and_exit = FALSE)
    baseline <- .fix_prefix_leaks(baseline, character(0))
    for (key in names(config_list)) {
      if (!key %in% names(opt)) {
        log_warning("Config file contains unknown key '%s'; ignored.", key,
                    .module = "cli/run_rclade_cli")
        next
      }
      if (identical(opt[[key]], baseline[[key]])) {
        opt[[key]] <- config_list[[key]]
      }
    }
    log_info("Applied config file overrides from: %s", config_path)
  }

  # Validate parameters
  errors <- validate_cli_params(opt)
  if (length(errors) > 0) {
    message("\n[cli/validate_cli_params] Parameter validation errors:")
    for (err in errors) {
      message("  - ", err)
    }
    message("\nUse --help for usage information.")
    return(invisible(2L))  # Exit code 2: parameter error
  }

  # Set log level
  set_log_level(toupper(opt$log_level))

  # Set log file if specified
  if (!is.null(opt$log_file)) {
    set_log_file(opt$log_file)
  }

  # Display logo and input info
  rclade_logo()
  log_info("Starting Rclade CLI")
  log_keyvalue("Input file", opt$file)
  log_keyvalue("Output file", opt$out)
  log_keyvalue("Rank", opt$rank)
  log_keyvalue("Layout", opt$layout)
  log_keyvalue("Unit", opt$unit)

  # Parse color palette (handle comma-separated hex colors)
  color_palette <- opt$color_palette
  if (grepl("^#[0-9A-Fa-f]{6}", color_palette)) {
    color_palette <- strsplit(color_palette, ",")[[1]]
  }

  # Parse color mapping
  color_mapping <- NULL
  if (!is.null(opt$color_mapping)) {
    pairs <- strsplit(opt$color_mapping, ",")[[1]]
    color_mapping <- setNames(
      sub("^[^:]+:", "", pairs),
      sub(":.*$", "", pairs)
    )
  }

  # Tree-sequence cross-validation
  if (!is.null(opt$sequence_file) && !opt$no_cross_check) {
    log_info("Running tree-sequence cross-validation...")
    cross_ok <- tryCatch(
      {
        validate_tree_sequence_match(
          opt$file,
          opt$sequence_file,
          mol_type = if (tolower(opt$mol_type) == "auto") NULL else opt$mol_type,
          skip_length_check = opt$skip_length_check,
          multi_tree_mode = opt$multi_tree_mode
        )
        TRUE
      },
      error = function(e) {
        log_error("Cross-validation failed: %s", e$message,
                  .module = "cli/run_rclade_cli")
        FALSE
      }
    )
    if (!isTRUE(cross_ok)) {
      return(invisible(3L))  # Exit code 3: input data error
    }
  }

  # Log CLI-only mode flags
  if (opt$low_memory) {
    log_info("Low-memory mode enabled")
  }
  if (opt$ignore_malformed) {
    log_info("Ignore-malformed mode enabled (will skip malformed inputs)")
  }
  if (opt$skip_length_check) {
    log_info("Skipping sequence alignment length check")
  }
  if (opt$strip_annotations) {
    log_info("Annotation stripping enabled (bootstrap/NHX annotations will be dropped)")
  }

  # Parse taxonomy_levels if provided
  taxonomy_levels <- NULL
  if (!is.null(opt$taxonomy_levels)) {
    # Parse format: "k:_k_,ss:_ss_"
    pairs <- strsplit(opt$taxonomy_levels, ",")[[1]]
    codes <- sub(":.*$", "", pairs)
    prefixes <- sub("^[^:]+:", "", pairs)
    taxonomy_levels <- list(codes = codes, names = prefixes)
  }

  # Determine overwrite mode
  overwrite_mode <- if (opt$force) "force" else if (opt$no_clobber) "no-clobber" else "ask"

  # Reset interrupt state for this run
  .interrupt_env$interrupted <- FALSE

  # Wrap main processing with graceful interrupt handling
  main_result <- with_graceful_interrupt({

  # Handle multi-tree mode
  if (opt$multi_tree_mode %in% c("all", "split")) {
    # Batch mode: analyze all trees separately
    log_info("Batch mode: analyzing all trees separately")

    # Read all trees
    trees <- read_tree_auto(opt$file, tree_index = NULL, multi_tree_mode = opt$multi_tree_mode)

    # Strip annotations if requested (§9.1.1)
    if (opt$strip_annotations) {
      if (inherits(trees, "multiPhylo")) {
        for (i in seq_along(trees)) trees[[i]] <- strip_tree_annotations(trees[[i]])
      } else {
        trees <- strip_tree_annotations(trees)
      }
    }

    if (!inherits(trees, "multiPhylo")) {
      # Only one tree, just run normally
      log_info("Only one tree found, running single analysis")
      p <- tryCatch(
        do.call(plot_timetree, c(list(tree = trees), build_plot_timetree_params(opt, color_palette, color_mapping, taxonomy_levels))),
        error = function(e) {
          if (opt$ignore_malformed) {
            log_warning("Skipping malformed input: %s", e$message, .module = "cli/run_rclade_cli")
            NULL
          } else {
            stop(e)
          }
        }
      )
      if (!is.null(p)) {
        tryCatch({
          save_timetree(p, opt$out, opt$width, opt$height, overwrite = overwrite_mode)
          log_info("Output saved: %s", opt$out)
        }, error = function(e) {
          if (opt$ignore_malformed) {
            log_warning("Skipping save due to error: %s", e$message, .module = "cli/run_rclade_cli")
          } else {
            stop(e)
          }
        })
      }
    } else {
      # Multiple trees - generate output filenames with suffix
      n_trees <- length(trees)
      log_info("Processing %d trees...", n_trees)

      # Generate base output name
      out_ext <- tools::file_ext(opt$out)
      out_base <- sub(paste0("\\.", out_ext, "$"), "", opt$out)

      # Use batch_with_interrupt for graceful Ctrl+C handling
      batch_with_interrupt(
        items = seq_len(n_trees),
        fun = function(i, idx) {
          log_section(sprintf("Tree %d of %d", i, n_trees))
          out_file <- sprintf("%s_%d.%s", out_base, i, out_ext)

          result <- tryCatch({
            p <- do.call(plot_timetree, c(list(tree = trees[[i]]), build_plot_timetree_params(opt, color_palette, color_mapping, taxonomy_levels)))
            if (!is.null(p)) {
              save_timetree(p, out_file, opt$width, opt$height, overwrite = overwrite_mode)
              log_info("Output saved: %s", out_file)
              out_file
            } else {
              log_warning("Tree %d skipped due to malformed input", i,
                          .module = "cli/run_rclade_cli")
              NULL
            }
          }, error = function(e) {
            if (opt$ignore_malformed) {
              log_warning("Skipping tree %d: %s", i, e$message,
                          .module = "cli/run_rclade_cli")
              NULL
            } else {
              stop(e)
            }
          })
          return(result)
        },
        label_fun = function(i, idx) sprintf("Tree %d", i)
      )
      log_section("Batch Complete")
      log_info("All trees processed")
    }
  } else {
    # Single tree mode
    # When --strip_annotations is set, pre-read the tree so annotations can be
    # removed before plot_timetree processes it. Otherwise, pass the file path
    # directly and let plot_timetree handle reading (preserves tree_index /
    # multi_tree_mode behavior).
    if (opt$strip_annotations) {
      tree_obj <- tryCatch(
        read_tree_auto(opt$file, tree_index = opt$tree_index,
                       multi_tree_mode = opt$multi_tree_mode),
        error = function(e) {
          if (opt$ignore_malformed) {
            log_warning("Skipping malformed input: %s", e$message, .module = "cli/run_rclade_cli")
            return(NULL)
          } else {
            stop(e)
          }
        }
      )
      if (is.null(tree_obj)) {
        p <- NULL
      } else {
        tree_obj <- strip_tree_annotations(tree_obj)
        p <- tryCatch(
          do.call(plot_timetree, c(list(tree = tree_obj),
                                   build_plot_timetree_params(opt, color_palette, color_mapping, taxonomy_levels))),
          error = function(e) {
            if (opt$ignore_malformed) {
              log_warning("Skipping malformed input: %s", e$message, .module = "cli/run_rclade_cli")
              NULL
            } else {
              stop(e)
            }
          }
        )
      }
    } else {
      p <- tryCatch(
        do.call(plot_timetree, c(list(tree = opt$file, tree_index = opt$tree_index, multi_tree_mode = opt$multi_tree_mode), build_plot_timetree_params(opt, color_palette, color_mapping, taxonomy_levels))),
        error = function(e) {
          if (opt$ignore_malformed) {
            log_warning("Skipping malformed input: %s", e$message, .module = "cli/run_rclade_cli")
            NULL
          } else {
            stop(e)
          }
        }
      )
    }

    if (!is.null(p)) {
      tryCatch({
        save_timetree(p, opt$out, opt$width, opt$height, overwrite = overwrite_mode)
        log_info("Output saved: %s", opt$out)
      }, error = function(e) {
        if (opt$ignore_malformed) {
          log_warning("Skipping save due to error: %s", e$message, .module = "cli/run_rclade_cli")
        } else {
          stop(e)
        }
      })
    }
  }

  "ok"  # success marker for with_graceful_interrupt
  # Progress granularity inside batch mode is handled by batch_with_interrupt
  # (per-tree counters); the outer wrapper tracks a single overall unit.
  }, total = 1L)

  # Close log file if open
  if (!is.null(.logger_env$log_con) && isOpen(.logger_env$log_con)) {
    tryCatch(close(.logger_env$log_con), error = function(e) NULL)
  }

  if (isTRUE(.interrupt_env$interrupted)) {
    log_warning("Operation interrupted by user", .module = "cli/run_rclade_cli")
    return(invisible(130L))  # Standard Unix SIGINT exit code
  }

  log_info("Done!")
  return(invisible(0L))  # Exit code 0: success
}
