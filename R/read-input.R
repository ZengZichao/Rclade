# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Input reading and validation functions

#' Supported tree file extensions
#' @keywords internal
SUPPORTED_TREE_EXTENSIONS <- c(
  "nwk", "newick", "tre", "tree", "treefile",  # Newick formats
  "nex", "nexus",                                # Nexus formats
  "nhx",                                           # New Hampshire Extended
  "xml", "beast",                                # BEAST XML
  "con", "confile",                              # Consensus tree
  "fasta", "fa", "fna", "fas"                    # Sequence files (for reference)
)

#' Validate file existence and readability
#'
#' @param filepath Character. Path to file.
#' @param file_type Character. Description of file type for error messages.
#' @param must_exist Logical. Whether file must exist. Default: TRUE.
#' @return Logical. TRUE if valid.
#' @keywords internal
validate_file_exists <- function(filepath, file_type = "input", must_exist = TRUE) {
  if (is.null(filepath) || !is.character(filepath) || nchar(filepath) == 0) {
    rlang::abort(sprintf("Invalid %s file path: path is NULL or empty.", file_type),
                 class = "Rclade_read_error")
  }

  # Check for common issues (E-T3: route to logger rather than bare warning)
  if (grepl("~", filepath) && !grepl("^~/", filepath)) {
    log_warning("File path contains '~' that may not expand correctly: %s",
                filepath, .module = "read-input/validate_file_exists")
  }

  if (must_exist && !file.exists(filepath)) {
    rlang::abort(sprintf("%s file does not exist: %s", file_type, filepath),
                 class = "Rclade_read_error")
  }

  if (must_exist) {
    # Exclude directories: a directory is not a readable data file.
    finfo <- tryCatch(file.info(filepath), error = function(e) NULL)
    if (!is.null(finfo) && !is.na(finfo$isdir) && finfo$isdir) {
      rlang::abort(sprintf("%s path is a directory, not a file: %s", file_type, filepath),
                   class = "Rclade_read_error")
    }
    # file.access returns -1 when status is *undetermined* (common on some
    # network/distributed filesystems). Treat -1 as "cannot decide" and rely on
    # file.exists above; only an explicit non-zero (denied) result means
    # unreadable (M-C4).
    access_code <- tryCatch(file.access(filepath, mode = 4), error = function(e) -1)
    if (is.na(access_code) || access_code == -1L) {
      log_debug("Read permission for %s could not be determined; proceeding.",
                filepath)
    } else if (access_code != 0L) {
      rlang::abort(sprintf("%s file is not readable (permission denied): %s",
                           file_type, filepath), class = "Rclade_read_error")
    }
  }

  return(TRUE)
}

#' Detect and validate tree file format
#'
#' @param filepath Character. Path to tree file.
#' @return Character. Detected format: "newick", "nexus", "beast", "unknown".
#' @keywords internal
detect_tree_format <- function(filepath) {
  validate_file_exists(filepath, "Tree")

  file_ext <- tolower(tools::file_ext(filepath))
  file_size <- file.size(filepath)

  # Check for empty file
  if (file_size == 0) {
    rlang::abort(paste0("Tree file is empty: ", filepath), class = "Rclade_read_error")
  }

  # Check for extremely large file (> 1GB)
  if (file_size > 1e9) {
    log_warning("Tree file is very large (%s MB). Reading may be slow.",
                round(file_size / 1e6, 1), .module = "read-input")
  }

  # Detect by extension
  if (file_ext %in% c("nex", "nexus")) {
    return("nexus")
  } else if (file_ext %in% c("nwk", "newick", "tre", "tree", "treefile")) {
    return("newick")
  } else if (file_ext %in% c("xml", "beast")) {
    return("beast")
  } else if (file_ext %in% c("nhx")) {
    return("newick")  # NHX is extended Newick
  }

  # Try content-based detection
  first_line <- tryCatch(
    readLines(filepath, n = 1, warn = FALSE),
    error = function(e) ""
  )

  # Nexus files start with "#NEXUS"
  if (grepl("^#NEXUS", first_line, ignore.case = TRUE)) {
    return("nexus")
  }

  # BEAST XML files contain beast/phylogeny tags
  if (grepl("<beast|<phylogeny", first_line, ignore.case = TRUE)) {
    return("beast")
  }

  # Default: try Newick
  return("newick")
}

#' Validate tree object structure
#'
#' @param tree phylo object to validate.
#' @return Logical. TRUE if valid.
#' @keywords internal
validate_tree_structure <- function(tree) {
  if (!inherits(tree, "phylo")) {
    rlang::abort("'tree' must be a phylo object.", class = "Rclade_validate_error")
  }

  # Check required components
  if (is.null(tree$edge) || !is.matrix(tree$edge)) {
    rlang::abort("Tree is missing 'edge' matrix.", class = "Rclade_validate_error")
  }

  if (is.null(tree$tip.label) || !is.character(tree$tip.label)) {
    rlang::abort("Tree is missing 'tip.label'.", class = "Rclade_validate_error")
  }

  if (is.null(tree$Nnode) || !is.numeric(tree$Nnode)) {
    rlang::abort("Tree is missing 'Nnode'.", class = "Rclade_validate_error")
  }

  # Check edge matrix dimensions
  n_tips <- length(tree$tip.label)
  n_nodes <- tree$Nnode
  expected_edges <- n_tips + n_nodes - 1

  if (nrow(tree$edge) != expected_edges) {
    log_warning("Edge matrix has %d rows, expected %d. Tree may be malformed.",
                nrow(tree$edge), expected_edges, .module = "read-input")
  }

  # Check for valid node indices
  max_node <- n_tips + n_nodes
  if (any(tree$edge < 1) || any(tree$edge > max_node)) {
    rlang::abort("Edge matrix contains invalid node indices.", class = "Rclade_validate_error")
  }

  # Check for duplicate tip labels
  if (any(duplicated(tree$tip.label))) {
    rlang::abort(paste0("Tree contains duplicate tip labels: ",
         paste(unique(tree$tip.label[duplicated(tree$tip.label)]), collapse = ", "),
         ". Duplicate tips break MRCA computation and group assignment."),
         class = "Rclade_validate_error")
  }

  # Check for empty tip labels
  if (any(nchar(trimws(tree$tip.label)) == 0)) {
    rlang::abort("Tree contains empty tip labels.", class = "Rclade_validate_error")
  }

  return(TRUE)
}

# ape's Newick parser overflows a fixed-size token buffer when a label
# exceeds ~512 characters, aborting the whole R process with glibc
# "stack smashing detected" on Linux (ape 5.8.1). Truncate overlong
# labels before parsing so the pipeline degrades gracefully instead.
.max_newick_label <- 500L

truncate_long_newick_labels <- function(text, filepath = "<unknown>",
                                        max_label = .max_newick_label) {
  token_re <- "[^(),:;[:space:]\\[\\]]+"
  token_matches <- gregexpr(token_re, text, perl = TRUE)
  tokens <- regmatches(text, token_matches)[[1]]
  long_idx <- which(nchar(tokens) > max_label)
  if (length(long_idx) == 0) return(text)
  log_warning(
    "%d tree label(s) exceed %d characters and will be truncated to avoid a crash in ape's Newick parser (file: %s)",
    length(long_idx), max_label, filepath,
    .module = "read-input/truncate_long_labels")
  tokens[long_idx] <- paste0(substr(tokens[long_idx], 1L, 400L), "_RCLADE_TRUNC")
  regmatches(text, token_matches) <- list(tokens)
  text
}

#' Read tree from file with automatic format detection
#'
#' Intended for use as a stable library API by external workflows
#' (e.g., Snakemake/Nextflow).
#'
#' @details
#' Newick labels longer than 500 characters are automatically truncated to
#' 400 characters plus a `_RCLADE_TRUNC` suffix (with a warning), because
#' ape's Newick parser aborts the whole R process on labels longer than
#' ~512 characters on Linux. Truncated labels may no longer match external
#' taxonomy files or sequence IDs; shorten labels upstream if exact matching
#' is required.
#'
#' @param filepath Path to tree file (.tre, .nwk, .newick, .nexus, .nex, .treefile, .xml)
#' @param tree_index Integer. Index of tree to use from multiPhylo objects (e.g., BEAST posterior).
#'   Default: NULL (will use multi_tree_mode to determine behavior).
#' @param multi_tree_mode Character. How to handle multiple trees in a file.
#'   Options:
#'   \itemize{
#'     \item \code{"error"} (default): Stop with error and ask user to specify
#'     \item \code{"ask"}: Interactively prompt the user to choose a tree
#'       or handling mode. Falls back to \code{"error"} in non-interactive sessions.
#'     \item \code{"first"}: Use the first tree
#'     \item \code{"last"}: Use the last tree
#'     \item \code{"random"}: Use a randomly selected tree
#'     \item \code{"all"}: Return all trees (as multiPhylo)
#'     \item \code{"split"}: Return all trees (as multiPhylo); callers write
#'       per-tree outputs with numeric suffixes (e.g. \code{output_1.pdf})
#'   }
#' @return phylo object (or multiPhylo if multi_tree_mode = "all" or "split")
#' @export
read_tree_auto <- function(filepath, tree_index = NULL, multi_tree_mode = "error") {
  log_info("Reading tree file: %s", filepath)

  # Validate file exists and is not empty
  validate_file_exists(filepath, "Tree")
  validate_file_not_empty(filepath, "Tree")

  # Detect format
  format <- detect_tree_format(filepath)
  log_debug("Detected tree format: %s", format)

  # Deep syntax validation for Newick files (before parsing).
  # raw_text is hoisted so the parser can reuse the already-validated text (M-C5)
  # instead of re-reading the file from disk.
  raw_text <- NULL
  if (format == "newick" || format == "unknown") {
    raw_text <- paste(read_file_utf8(filepath), collapse = "\n")
    validate_newick_syntax(raw_text, filepath)
    raw_text <- truncate_long_newick_labels(raw_text, filepath)
    log_debug("Newick syntax validation passed")
  }

  # Read based on format
  tree <- tryCatch({
    switch(format,
      "nexus" = {
        log_debug("Reading Nexus format...")
        ape::read.nexus(filepath)
      },
      "newick" = {
        log_debug("Reading Newick format...")
        ape::read.tree(text = raw_text)
      },
      "beast" = {
        log_debug("Reading BEAST XML format...")
        if (requireNamespace("treeio", quietly = TRUE)) {
          treeio::read.beast(filepath)
        } else {
          rlang::abort(
            paste0("Reading BEAST XML files requires the treeio package: ",
                   "BiocManager::install('treeio')"),
            class = "Rclade_read_error")
        }
      },
      {
        # Unknown: try Newick first (reusing validated text), then Nexus
        log_debug("Unknown format, trying Newick...")
        tryCatch(
          ape::read.tree(text = raw_text),
          error = function(e) {
            log_debug("Newick failed, trying Nexus...")
            ape::read.nexus(filepath)
          }
        )
      }
    )
  }, error = function(e) {
    rlang::abort(
      paste0("Cannot read tree file: ", filepath,
             "\nFormat: ", format,
             "\nError: ", e$message),
      class = "Rclade_read_error")
  })

  # Handle multiPhylo
  if (inherits(tree, "multiPhylo")) {
    n_trees <- length(tree)
    # Print tree summaries before raising error
    summarize_multi_trees(tree, filepath)

    # If tree_index is explicitly provided, use it
    if (!is.null(tree_index)) {
      if (tree_index < 1 || tree_index > n_trees) {
        rlang::abort(paste0("tree_index ", tree_index, " is out of range [1, ", n_trees, "]."),
                     class = "Rclade_read_error")
      }
      tree <- tree[[tree_index]]
      log_info("Using tree %d (as specified by tree_index)", tree_index)
    } else {
      # Use multi_tree_mode to determine behavior
      multi_tree_mode <- match.arg(multi_tree_mode, c("error", "ask", "first", "last", "random", "all", "split"))

      switch(multi_tree_mode,
        "error" = {
          rlang::abort(paste0("\n",
               "================================================================\n",
               "              MULTIPLE TREES DETECTED\n",
               "================================================================\n",
               "\n",
               "The input file contains ", n_trees, " trees.\n",
               "Please specify how to handle multiple trees using one of:\n",
               "\n",
               "  --tree_index <N>      Use the N-th tree (1 to ", n_trees, ")\n",
               "  --multi_tree_mode     Choose from: ask, first, last, random, all\n",
               "\n",
               "Examples:\n",
               "  --tree_index 1        Use the first tree\n",
               "  --multi_tree_mode last    Use the last tree\n",
               "  --multi_tree_mode random  Use a randomly selected tree\n",
               "  --multi_tree_mode all     Analyze all trees separately\n"),
               class = "Rclade_read_error")
        },
        "ask" = {
          if (!interactive()) {
            rlang::abort(paste0("\n",
                 "================================================================\n",
                 "              MULTIPLE TREES DETECTED\n",
                 "================================================================\n",
                 "\n",
                 "The input file contains ", n_trees, " trees.\n",
                 "--multi_tree_mode 'ask' requires an interactive session.\n",
                 "Please specify how to handle multiple trees using one of:\n",
                 "\n",
                 "  --tree_index <N>      Use the N-th tree (1 to ", n_trees, ")\n",
                 "  --multi_tree_mode     Choose from: first, last, random, all\n",
                 ), class = "Rclade_read_error")
          }
          message("\nMultiple trees detected in ", filepath, ": ", n_trees, " trees.")
          message("Options: first, last, random, all, or a tree index (1-", n_trees, ")")
          choice <- trimws(readline("Choice: "))
          if (choice == "first") {
            tree <- tree[[1]]
            log_info("Using first tree (multi_tree_mode = 'ask')")
          } else if (choice == "last") {
            tree <- tree[[n_trees]]
            log_info("Using last tree (multi_tree_mode = 'ask')")
          } else if (choice == "random") {
            rand_idx <- sample(n_trees, 1)
            tree <- tree[[rand_idx]]
            log_info("Using random tree %d (multi_tree_mode = 'ask')", rand_idx)
          } else if (choice == "all") {
            log_info("Returning all %d trees for batch processing", n_trees)
            return(tree)  # Return multiPhylo as-is
          } else {
            idx <- suppressWarnings(as.integer(choice))
            if (is.na(idx) || idx < 1 || idx > n_trees) {
              rlang::abort(paste0("Invalid choice: '", choice, "'. Expected: first, last, random, all, or an integer between 1 and ", n_trees, "."),
                   class = "Rclade_read_error")
            }
            tree <- tree[[idx]]
            log_info("Using tree %d (multi_tree_mode = 'ask')", idx)
          }
        },
        "first" = {
          tree <- tree[[1]]
          log_info("Using first tree (multi_tree_mode = 'first')")
        },
        "last" = {
          tree <- tree[[n_trees]]
          log_info("Using last tree (multi_tree_mode = 'last')")
        },
        "random" = {
          rand_idx <- sample(n_trees, 1)
          tree <- tree[[rand_idx]]
          log_info("Using random tree %d (multi_tree_mode = 'random')", rand_idx)
        },
        "all" = {
          log_info("Returning all %d trees for batch processing", n_trees)
          return(tree)  # Return multiPhylo as-is
        },
        "split" = {
          log_info("Returning all %d trees for split-output processing", n_trees)
          return(tree)  # Return multiPhylo as-is; caller writes numbered outputs
        }
      )
    }
  }

  # Convert treedata to phylo if needed
  if (inherits(tree, "treedata")) {
    log_debug("Converting treedata to phylo...")
    if (requireNamespace("treeio", quietly = TRUE)) {
      node_data <- suppressWarnings(tidytree::as_tibble(tree))
      tree_phylo <- treeio::as.phylo(tree)
      tree_phylo$node.data <- node_data
      tree <- tree_phylo
    } else {
      rlang::abort(
        "Processing treedata objects requires the treeio package: BiocManager::install('treeio')",
        class = "Rclade_read_error")
    }
  }

  # Deep tree structure validation
  validate_tree_deep(tree, filepath)

  log_info("Tree loaded successfully: %d tips, %d internal nodes",
           ape::Ntip(tree), ape::Nnode(tree))

  return(tree)
}

#' Validate and preprocess tree input
#'
#' Checks tree object validity, converts treedata to phylo,
#' validates parameters, and performs unit sanity checks.
#'
#' @param tree phylo or treedata object
#' @param rank Taxonomic rank
#' @param unit Time unit
#' @param layout Layout type
#' @param triangle_mode Triangle mode
#' @param space_mode Space mode
#' @return Validated phylo object (with node.data attribute if treedata input)
#' @keywords internal
validate_inputs <- function(tree, rank, unit, layout, triangle_mode, space_mode, add_timescale = TRUE, groups = NULL, clade = NULL, overwrite = "ask") {
  log_subsection("Input Validation")

  # Check tree class
  if (!inherits(tree, c("phylo", "treedata"))) {
    rlang::abort("'tree' must be a phylo or treedata object, or a file path string.",
                 class = "Rclade_validate_error")
  }

  # Convert treedata to phylo (preserving node annotations)
  if (inherits(tree, "treedata")) {
    log_info("Converting treedata object to phylo...")
    if (requireNamespace("treeio", quietly = TRUE)) {
      node_data <- suppressWarnings(tidytree::as_tibble(tree))
      tree_phylo <- treeio::as.phylo(tree)
      tree_phylo$node.data <- node_data
      tree <- tree_phylo
      log_debug("treedata conversion complete")
    } else {
      rlang::abort(
        "Processing treedata objects requires the treeio package: BiocManager::install('treeio')",
        class = "Rclade_read_error")
    }
  }

  # Check edge lengths
  if (is.null(tree$edge.length)) {
    rlang::abort("Tree object lacks edge lengths (edge.length). Cannot build timetree.",
                 class = "Rclade_validate_error")
  }
  if (any(!is.finite(tree$edge.length))) {
    rlang::abort("Tree contains non-finite edge lengths (NA/NaN/Inf). Cannot build timetree.",
                 class = "Rclade_validate_error")
  }
  if (any(tree$edge.length < 0)) {
    log_critical("Negative branch lengths detected: min = %.6f",
                 min(tree$edge.length))
    rlang::abort(paste0("CRITICAL: Tree contains negative branch lengths (min = ",
         round(min(tree$edge.length), 6), "). ",
         "Rclade does not support negative branch lengths. ",
         "Please remove or fix negative branches before proceeding."),
         class = "Rclade_validate_error")
  }

  # Check minimum tip count (ggtree requires at least 2 tips)
  if (ape::Ntip(tree) < 2) {
    rlang::abort(paste0("Tree must have at least 2 tips. Got ", ape::Ntip(tree), " tip(s). ",
         "ggtree cannot visualize single-tip trees."),
         class = "Rclade_validate_error")
  }

  log_keyvalue("Tips", ape::Ntip(tree))
  log_keyvalue("Internal nodes", ape::Nnode(tree))
  log_keyvalue("Edge lengths range",
               sprintf("%.4f to %.4f", min(tree$edge.length), max(tree$edge.length)))

  # Check ggplot2 version for legend.position = "inside"
  ggplot2_version <- utils::packageVersion("ggplot2")
  if (ggplot2_version < "3.5.0") {
    log_warning("ggplot2 version %s < 3.5. legend.position = 'inside' is not available, legend will use default 'right' position.",
                ggplot2_version, .module = "read-input/validate_inputs")
  }

  # Handle unit parameter.
  #
  # FAIL-SAFE CONTRACT (v1.1.0, reviewer issue 1): Rclade never infers
  # divergence times or branch-length units.  When a geological timescale is
  # requested, the unit MUST be supplied explicitly; previously unit = NULL
  # silently defaulted to 'Ga' (multiplying edge lengths by 1000), which
  # could label a non-time-calibrated tree with a plausible-looking but
  # wrong geological axis.  We now abort instead.
  if (is.null(unit)) {
    if (add_timescale) {
      rlang::abort(paste0(
        "'unit' must be specified explicitly when add_timescale = TRUE. ",
        "Rclade does not infer branch-length units or verify that the input ",
        "tree is time-calibrated. Pass unit = 'Ma' or unit = 'Ga' for a ",
        "time-calibrated tree whose units are known, or set ",
        "add_timescale = FALSE for trees without time-calibrated branch lengths."),
        class = "Rclade_validate_error")
    }
  }

  # Unit sanity checks (only when unit is specified)
  if (!is.null(unit)) {
    median_bl <- stats::median(tree$edge.length)
    log_keyvalue("Median branch length", sprintf("%.4f %s", median_bl, unit))

    if (unit == "Ga" && median_bl < 0.001) {
      log_warning("Median branch length is %s Ga (%s Ma). Please verify the unit is correct. If the tree is in Ma, set unit = 'Ma'.",
                  median_bl, median_bl * 1e6, .module = "read-input/validate_inputs")
    }
    if (unit == "Ma" && median_bl > 1000) {
      log_warning("Median branch length is %s Ma (%s Ga). Please verify the unit is correct. If the tree is in Ga, set unit = 'Ga'.",
                  median_bl, round(median_bl / 1000, 2), .module = "read-input/validate_inputs")
    }

    # Auditable chronogram sanity warning (v1.1.0): for a strictly
    # contemporaneous ultrametric tree all root-to-tip distances are equal.
    # Large dispersion suggests the tree may be non-ultrametric (e.g.
    # substitution distances) or heterochronous; Rclade does not resolve
    # this ambiguity and surfaces it for the user to audit.
    rtt <- ape::dist.nodes(tree)[ape::Ntip(tree) + 1, seq_len(ape::Ntip(tree))]
    if (all(is.finite(rtt)) && length(rtt) >= 2) {
      rtt_cv <- stats::sd(rtt) / mean(rtt)
      if (rtt_cv > 0.1) {
        log_warning(paste0(
          "Root-to-tip distances vary substantially (CV = ",
          sprintf("%.3f", rtt_cv),
          "). The tree may not be ultrametric/time-calibrated, or tips may ",
          "be heterochronous. Rclade does not infer or verify time ",
          "calibration; please confirm the tree is a chronogram before ",
          "interpreting the geological timescale."),
          .module = "read-input/validate_inputs")
      }
    }
  }

  # Parameter enum validation
  if (!is.null(groups) && rank != "none") {
    rlang::abort(paste0("'rank' and 'groups' cannot be used together. ",
         "Set rank = 'none' when providing custom groups, or omit 'groups' to use rank-based collapsing."),
         class = "Rclade_validate_error")
  }
  if (!is.null(clade) && rank != "none") {
    rlang::abort(paste0("'rank' and 'clade' cannot be used together. ",
         "Use 'rank' to collapse all groups at a rank, or 'clade' to collapse a specific clade."),
         class = "Rclade_validate_error")
  }
  if (!is.null(clade) && !is.null(groups)) {
    rlang::abort("'groups' and 'clade' cannot be used together.",
                  class = "Rclade_validate_error")
  }

  # Derived from normalize_rank's rank_map to avoid two drifting definitions
  rank_map <- c("k"="kingdom","d"="domain","p"="phylum","c"="class",
                "o"="order","f"="family","g"="genus","s"="species",
                "ss"="subspecies","none"="none")
  valid_ranks <- c(names(rank_map), unique(unname(rank_map)))
  if (!rank %in% valid_ranks) {
    rlang::abort(paste0("Invalid rank: '", rank, "'. Valid values: ", paste(valid_ranks, collapse = ", ")),
         class = "Rclade_validate_error")
  }

  valid_layouts <- c("rectangular", "circular")
  if (!layout %in% valid_layouts) {
    rlang::abort(paste0("Invalid layout: '", layout, "'. Valid values: ", paste(valid_layouts, collapse = ", ")),
         class = "Rclade_validate_error")
  }

  valid_modes <- c("max", "min", "mixed", "none")
  if (!triangle_mode %in% valid_modes) {
    rlang::abort(paste0("Invalid triangle_mode: '", triangle_mode, "'. Valid values: ",
         paste(valid_modes, collapse = ", ")), class = "Rclade_validate_error")
  }

  valid_space <- c("equal", "proportional")
  if (!space_mode %in% valid_space) {
    rlang::abort(paste0("Invalid space_mode: '", space_mode, "'. Valid values: ",
         paste(valid_space, collapse = ", ")), class = "Rclade_validate_error")
  }

  valid_units <- c("Ga", "Ma")
  if (!is.null(unit) && !unit %in% valid_units) {
    rlang::abort(paste0("Invalid unit: '", unit, "'. Valid values: ", paste(valid_units, collapse = ", ")),
         class = "Rclade_validate_error")
  }

  valid_overwrite <- c("ask", "force", "no-clobber")
  if (!overwrite %in% valid_overwrite) {
    rlang::abort(paste0("Invalid overwrite: '", overwrite, "'. Valid values: ",
         paste(valid_overwrite, collapse = ", ")), class = "Rclade_validate_error")
  }

  log_info("Input validation passed")
  return(list(tree = tree, unit = unit))
}

#' Validate sequence file format
#'
#' @param filepath Character. Path to sequence file.
#' @return Character. Detected format: "fasta", "fastq", "unknown".
#' @export
#' @examples
#' \dontrun{
#' format <- validate_sequence_file("sequences.fasta")
#' }
validate_sequence_file <- function(filepath) {
  validate_file_exists(filepath, "Sequence")

  file_ext <- tolower(tools::file_ext(filepath))
  file_size <- file.size(filepath)

  if (file_size == 0) {
    rlang::abort(paste0("Sequence file is empty: ", filepath),
                 class = "Rclade_validate_error")
  }

  # Detect by extension
  if (file_ext %in% c("fasta", "fa", "fna", "fas", "faa")) {
    return("fasta")
  } else if (file_ext %in% c("fastq", "fq")) {
    return("fastq")
  }

  # Try content-based detection
  first_line <- tryCatch(
    readLines(filepath, n = 1, warn = FALSE),
    error = function(e) ""
  )

  if (grepl("^>", first_line)) {
    return("fasta")
  } else if (grepl("^@", first_line)) {
    return("fastq")
  }

  return("unknown")
}

#' Get supported file extensions
#'
#' @return Named list of supported extensions by category.
#' @export
get_supported_extensions <- function() {
  list(
    tree = c("nwk", "newick", "tre", "tree", "treefile", "nex", "nexus", "nhx", "xml", "beast"),
    sequence = c("fasta", "fa", "fna", "fas", "faa", "fastq", "fq"),
    taxonomy = c("tsv", "csv", "txt")
  )
}
