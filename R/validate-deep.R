# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Deep input validation with detailed error localization

#' Validate Newick string syntax
#'
#' Performs deep syntax validation on a raw Newick string before parsing.
#' Checks bracket balance, negative branch lengths, empty node names,
#' duplicate node names, and self-loops.
#'
#' @section Heuristics & error contract (L-C3 / L-E3):
#' The syntax checks are \strong{regex heuristics} over the raw string and may
#' occasionally \strong{false-positive or false-negative} on exotic input (e.g.
#' unusual quoting, deeply nested labels).  They are a fast pre-filter; the
#' authoritative correctness check is the structural validation that runs after
#' the tree is parsed.  Do not treat a clean heuristic pass as a full guarantee.
#'
#' On failure these validators raise via \code{rlang::abort(message, class = "Rclade_validate_error")}
#' (or \code{"Rclade_read_error"} for I/O problems).  \strong{Callers must
#' branch on the condition \code{class}, never \code{grep} the message text} —
#' this is the supported contract and prevents brittle tests when wording changes.
#'
#' @param text Character. Raw Newick string.
#' @param filepath Character. File path for error messages.
#' @return Invisibly returns TRUE if valid. Stops on CRITICAL errors.
#' @keywords internal
validate_newick_syntax <- function(text, filepath = "<string>") {
  if (nchar(trimws(text)) == 0) {
    rlang::abort(paste0("Newick string is empty: ", filepath),
                 class = "Rclade_validate_error")
  }

  # --- Bracket balance ---
  # Vectorized parenthesis scan: utf8ToInt + cumulative sum is O(n) in C and
  # several orders of magnitude faster than a per-character substr() loop on
  # multi-MB Newick strings (e.g. 10k+ tip trees).
  chars <- utf8ToInt(text)
  if (length(chars) > 0) {
    depth <- cumsum((chars == 40L) - (chars == 41L))  # 40='(', 41=')'
    first_neg <- which(depth < 0)[1]
    if (!is.na(first_neg)) {
      rlang::abort(paste0("Newick syntax error in ", filepath, ": ",
           "unmatched ')' at position ", first_neg, "."),
           class = "Rclade_validate_error")
    }
    open_count <- depth[length(depth)]
  } else {
    open_count <- 0
  }
  if (open_count != 0) {
    rlang::abort(paste0("Newick syntax error in ", filepath, ": ",
         "unmatched '(' - ", open_count, " unclosed bracket(s)."),
         class = "Rclade_validate_error")
  }

  # --- Negative branch lengths ---
  neg_bl <- regmatches(text, gregexpr(":[-][0-9.eE+]+", text))[[1]]
  if (length(neg_bl) > 0) {
    log_critical("Negative branch lengths detected in %s: %s",
                 filepath, paste(head(neg_bl, 5), collapse = ", "))
    rlang::abort(paste0("CRITICAL: Negative branch lengths found in ", filepath,
         ". This is not allowed. Values: ",
         paste(head(neg_bl, 5), collapse = ", "),
         if (length(neg_bl) > 5) paste0(" ... and ", length(neg_bl) - 5, " more")),
         class = "Rclade_validate_error")
  }

  # --- Empty node names (consecutive delimiters) ---
  empty_name <- regmatches(text, gregexpr("\\(\\s*,|,\\s*,|,\\s*\\)|\\(\\s*\\)", text))[[1]]
  if (length(empty_name) > 0) {
    log_warning("Newick contains possible empty node names in %s: %s",
                filepath, paste(head(empty_name, 3), collapse = ", "),
                .module = "validate-deep/validate_newick")
  }

  # --- Extract tip names and check for duplicates ---
  # Simple extraction: text before ':' or ',' or ')' that is after ',' or '('
  tip_names <- regmatches(text, gregexpr("(?<=[,(])[^(),;:]+(?=[,:)])", text, perl = TRUE))[[1]]
  tip_names <- trimws(tip_names)
  tip_names <- tip_names[nchar(tip_names) > 0]

  if (length(tip_names) > 0) {
    dups <- tip_names[duplicated(tip_names)]
    if (length(dups) > 0) {
      log_warning("Newick contains duplicate node names in %s: %s",
                  filepath, paste(head(unique(dups), 5), collapse = ", "),
                  .module = "validate-deep/validate_newick")
    }
  }

  # --- Check for semicolon terminator ---
  if (!grepl(";\\s*$", text)) {
    log_warning("Newick string in %s does not end with ';'. This may cause parsing issues.",
                filepath, .module = "validate-deep/validate_newick")
  }

  # --- Malicious symbol injection detection ---
  check_malicious_chars(tip_names, filepath)

  invisible(TRUE)
}

#' Check for malicious characters in node names
#'
#' Detects control characters and Unicode bidirectional text markers
#' that could be used for display spoofing.
#'
#' @param names Character vector of node names to check.
#' @param filepath Character. Source file for error messages.
#' @return Invisibly returns TRUE if clean. Stops on detection.
#' @keywords internal
check_malicious_chars <- function(names, filepath = "<unknown>") {
  if (length(names) == 0) return(invisible(TRUE))

  # Check for control characters using raw byte matching
  # Control chars: 0x00-0x08, 0x0B, 0x0C, 0x0E-0x1F, 0x7F
  has_control <- vapply(names, function(n) {
    bytes <- charToRaw(n)
    any(bytes %in% as.raw(c(0x00:0x08, 0x0B, 0x0C, 0x0E:0x1F, 0x7F)))
  }, logical(1))

  if (any(has_control)) {
    bad_names <- names[has_control]
    log_error("Control characters detected in node names in %s", filepath,
              .module = "validate-deep/check_name_safety")
    rlang::abort(paste0("[validate-deep/check_name_safety] Node names in ", filepath,
         " contain control characters (possible injection attempt). Affected names: ",
         paste(head(bad_names, 3), collapse = ", ")),
         class = "Rclade_validate_error")
  }

  # Unicode bidirectional text markers (BiDi)
  # U+202A..U+202E, U+2066..U+2069, U+061C, U+200E, U+200F
  bidi_pattern <- "[\u202A-\u202E\u2066-\u2069\u061C\u200E\u200F]"
  bidi_hits <- grepl(bidi_pattern, names, perl = TRUE)

  if (any(bidi_hits)) {
    bad_names <- names[bidi_hits]
    log_error("Unicode BiDi markers detected in node names in %s", filepath,
              .module = "validate-deep/check_name_safety")
    rlang::abort(paste0("[validate-deep/check_name_safety] Node names in ", filepath,
         " contain Unicode bidirectional text markers (possible display spoofing). ",
         "Affected names: ",
         paste(head(bad_names, 3), collapse = ", ")),
         class = "Rclade_validate_error")
  }

  # Zero-width characters (could hide malicious content)
  # U+200B (ZWSP), U+200C (ZWNJ), U+200D (ZWJ), U+FEFF (BOM/ZWNBSP)
  zwc_pattern <- "[\u200B-\u200D\uFEFF]"
  zwc_hits <- grepl(zwc_pattern, names, perl = TRUE)

  if (any(zwc_hits)) {
    bad_names <- names[zwc_hits]
    log_warning("Zero-width characters detected in node names in %s. Affected names: %s",
                filepath, paste(head(bad_names, 3), collapse = ", "),
                .module = "validate-deep/check_name_safety")
  }

  invisible(TRUE)
}

#' Deep tree validation after parsing
#'
#' Validates a parsed phylo object for structural integrity including
#' self-loops, multi-root, negative branch lengths, and node consistency.
#'
#' @param tree phylo object.
#' @param filepath Character. Source file path for messages.
#' @return Invisibly returns TRUE if valid.
#' @keywords internal
validate_tree_deep <- function(tree, filepath = "<object>") {
  if (!inherits(tree, "phylo")) {
    rlang::abort("'tree' must be a phylo object.", class = "Rclade_validate_error")
  }

  n_tips <- length(tree$tip.label)
  n_nodes <- tree$Nnode
  edge <- tree$edge

  # --- Self-loop detection ---
  self_loops <- which(edge[, 1] == edge[, 2])
  if (length(self_loops) > 0) {
    rlang::abort(paste0("Tree in ", filepath, " contains self-loop edges at rows: ",
         paste(head(self_loops, 5), collapse = ", ")),
         class = "Rclade_validate_error")
  }

  # --- Negative branch lengths (CRITICAL) ---
  if (!is.null(tree$edge.length)) {
    neg_idx <- which(tree$edge.length < 0)
    if (length(neg_idx) > 0) {
      log_critical("Negative branch lengths in %s: %d edges, min = %.6f",
                   filepath, length(neg_idx), min(tree$edge.length))
      rlang::abort(paste0("CRITICAL: Negative branch lengths in ", filepath,
           ". Found ", length(neg_idx), " negative edge(s), ",
           "minimum value = ", round(min(tree$edge.length), 6),
           ". Rclade does not support negative branch lengths."),
           class = "Rclade_validate_error")
    }
  }

  # --- Multi-root detection ---
  # In a rooted tree, exactly one node has no parent (the root)
  all_children <- edge[, 2]
  all_parents <- edge[, 1]
  internal_nodes <- (n_tips + 1):(n_tips + n_nodes)
  nodes_without_parent <- setdiff(internal_nodes, all_children)

  if (length(nodes_without_parent) > 1) {
    rlang::abort(paste0("Tree in ", filepath, " has multiple root nodes: ",
         paste(nodes_without_parent, collapse = ", "),
         ". This indicates an unrooted or malformed tree."),
         class = "Rclade_validate_error")
  }

  # --- Empty tip labels ---
  empty_tips <- which(nchar(trimws(tree$tip.label)) == 0)
  if (length(empty_tips) > 0) {
    rlang::abort(paste0("Tree in ", filepath, " contains ", length(empty_tips),
         " empty tip label(s) at positions: ",
         paste(head(empty_tips, 5), collapse = ", ")),
         class = "Rclade_validate_error")
  }

  # --- Duplicate tip labels (WARNING - common in taxonomy-collapsed input) ---
  # Regression fix: demoted from rlang::abort to log_warning. Multiple tips
  # sharing the same taxonomic path are normal input for Rclade's automatic
  # clade collapsing (e.g. the bundled example_tree, where many tips collapse
  # onto the same taxonomic prefix), so a hard abort would wrongly reject valid
  # trees. The intended behaviour is to *detect* and warn on the condition
  # (it is a low-severity data-quality issue), not to crash on it. The other
  # structural aborts (multi-root,
  # empty tip, malicious chars, edge-matrix out of range) are intentionally
  # kept as hard errors.
  dup_tips <- tree$tip.label[duplicated(tree$tip.label)]
  if (length(dup_tips) > 0) {
    log_warning(
      "Tree in %s contains %d duplicate tip label(s): %s. Duplicate tip labels may cause taxonomy mapping ambiguity.",
      filepath, length(dup_tips),
      paste(head(unique(dup_tips), 5), collapse = ", ")
    )
  }

  # --- Malicious character injection in tip labels ---
  check_malicious_chars(tree$tip.label, filepath)

  # --- Edge matrix consistency ---
  max_node <- n_tips + n_nodes
  invalid_nodes <- edge[edge < 1 | edge > max_node]
  if (length(invalid_nodes) > 0) {
    rlang::abort(paste0("Tree in ", filepath, " edge matrix contains invalid node indices.",
         " Valid range: [1, ", max_node, "]."),
         class = "Rclade_validate_error")
  }

  # --- Expected edge count ---
  expected_edges <- n_tips + n_nodes - 1
  if (nrow(edge) != expected_edges) {
    log_warning("Tree in %s edge count mismatch: %d edges, expected %d.",
                filepath, nrow(edge), expected_edges,
                .module = "validate-deep/validate_tree_structure")
  }

  invisible(TRUE)
}

#' Summarize multiple trees in a file
#'
#' Prints a summary of each tree in a multiPhylo object before
#' raising the multi-tree error.
#'
#' @param trees multiPhylo object.
#' @param filepath Character. Source file path.
#' @keywords internal
summarize_multi_trees <- function(trees, filepath) {
  if (!inherits(trees, "multiPhylo")) return(invisible(NULL))

  n_trees <- length(trees)
  log_warning("Multiple trees detected in %s: %d trees", filepath, n_trees,
              .module = "validate-deep/summarize_multi_tree")

  summary_lines <- character(n_trees)
  for (i in seq_len(min(n_trees, 20))) {
    t <- trees[[i]]
    if (inherits(t, "phylo")) {
      summary_lines[i] <- sprintf("  Tree %4d: %5d tips, %5d internal nodes",
                                   i, ape::Ntip(t), ape::Nnode(t))
    } else if (inherits(t, "treedata")) {
      summary_lines[i] <- sprintf("  Tree %4d: %5d tips (treedata)", i, length(t@phylo$tip.label))
    }
  }
  if (n_trees > 20) {
    summary_lines[20] <- paste0(summary_lines[20],
                                 sprintf("\n  ... and %d more trees", n_trees - 20))
  }

  cat("Tree summary for:", filepath, "\n")
  cat(paste(summary_lines[1:min(n_trees, 20)], collapse = "\n"), "\n")

  invisible(NULL)
}

#' Deep validation of sequence files
#'
#' Validates FASTA/FASTQ files: format detection, duplicate IDs,
#' alphabet detection, and alignment length consistency.
#'
#' @param filepath Character. Path to sequence file.
#' @param expected_alphabet Character or NULL. Expected alphabet: "DNA", "RNA",
#'   "protein", or NULL for auto-detect.
#' @param check_alignment Logical. If TRUE, check all sequences have equal length.
#' @return List with validation results.
#' @export
#' @examples
#' \dontrun{
#' result <- validate_sequence_deep("sequences.fasta", expected_alphabet = "DNA")
#' }
validate_sequence_deep <- function(filepath, expected_alphabet = NULL,
                                    check_alignment = FALSE) {
  validate_file_exists(filepath, "Sequence")
  validate_file_not_empty(filepath, "Sequence")

  file_ext <- tolower(tools::file_ext(filepath))

  # Check for unsupported alignment formats (PHYLIP, Stockholm).
  # Read the file exactly once and reuse the content throughout (M-C2).
  lines <- readLines(filepath, warn = FALSE)
  first_lines <- head(lines, 10)
  for (ln in first_lines) {
    ln_trim <- trimws(ln)
    if (grepl("^# STOCKHOLM", ln_trim, ignore.case = TRUE)) {
      rlang::abort(
        paste0("Stockholm format detected in ", filepath,
               ". This format is not supported. Please convert to FASTA first."),
        class = "Rclade_validate_error")
    }
  }
  # PHYLIP: first line has two integers (taxa count, sequence length)
  if (grepl("^\\s*\\d+\\s+\\d+\\s*$", first_lines[1])) {
    rlang::abort(
      paste0("Possible PHYLIP format detected in ", filepath,
             ". This format is not supported. Please convert to FASTA first."),
      class = "Rclade_validate_error")
  }

  # Detect format
  format <- detect_sequence_format(filepath)
  log_info("Sequence file format detected: %s", format)

  if (format == "unknown") {
    rlang::abort(
      paste0("Cannot determine sequence file format: ", filepath,
             "\nExpected FASTA (starts with '>') or FASTQ (starts with '@')."),
      class = "Rclade_validate_error")
  }

  result <- list(
    filepath = filepath,
    format = format,
    n_sequences = 0,
    ids = character(0),
    duplicate_ids = character(0),
    alphabet = "unknown",
    invalid_chars = data.frame(line = integer(0), char = character(0),
                                stringsAsFactors = FALSE),
    alignment_ok = NA
  )

  if (format == "fasta") {
    result <- validate_fasta_content(lines, filepath, result, check_alignment)
  } else if (format == "fastq") {
    result <- validate_fastq_content(lines, filepath, result)
  }

  # Alphabet check
  if (!is.null(expected_alphabet) && result$alphabet != "unknown") {
    if (toupper(expected_alphabet) != toupper(result$alphabet)) {
      log_warning("Sequence alphabet mismatch in %s: expected %s, detected %s.",
                  filepath, expected_alphabet, result$alphabet,
                  .module = "validate-deep/validate_sequence_deep")
    }
  }

  return(result)
}

#' Detect sequence file format
#' @keywords internal
detect_sequence_format <- function(filepath) {
  first_lines <- readLines(filepath, n = 5, warn = FALSE)
  if (length(first_lines) == 0) return("unknown")

  for (ln in first_lines) {
    ln <- trimws(ln)
    if (nchar(ln) == 0) next
    if (grepl("^>", ln)) return("fasta")
    if (grepl("^@", ln)) return("fastq")
  }
  return("unknown")
}

#' Validate FASTA content
#' @param lines Character vector of file lines.
#' @param filepath Character. File path for messages.
#' @param result List to populate.
#' @param check_alignment Logical. Whether to check sequence length consistency.
#' @keywords internal
validate_fasta_content <- function(lines, filepath, result, check_alignment = FALSE) {
  ids <- character(0)
  seq_chars <- character(0)
  current_id <- NULL
  current_seq <- character(0)
  line_num <- 0
  # Collect invalid characters in flat vectors, build the data.frame once at the
  # end (avoids O(n^2) rbind inside the loop, M-C2).
  inv_lines <- integer(0)
  inv_chars <- character(0)
  seq_lengths <- integer(0)

  for (i in seq_along(lines)) {
    line <- trimws(lines[i])
    line_num <- i

    if (nchar(line) == 0) next

    if (grepl("^>", line)) {
      # Save previous sequence
      if (!is.null(current_id)) {
        ids <- c(ids, current_id)
        full_seq <- paste(current_seq, collapse = "")
        seq_lengths <- c(seq_lengths, nchar(full_seq))
        seq_chars <- c(seq_chars, strsplit(full_seq, "")[[1]])
      }

      # Parse ID (first word after >)
      current_id <- sub("^>\\s*([^ \t]+).*", "\\1", line)
      current_seq <- character(0)
    } else {
      # Sequence line
      current_seq <- c(current_seq, toupper(line))

      # Check for invalid characters
      chars <- strsplit(toupper(line), "")[[1]]
      valid_dna <- c("A", "C", "G", "T", "U", "N", "-", "R", "Y", "S", "W",
                      "K", "M", "B", "D", "H", "V")
      invalid <- chars[!chars %in% valid_dna]
      if (length(invalid) > 0) {
        uniq_inv <- unique(invalid)
        inv_lines <- c(inv_lines, rep(i, length(uniq_inv)))
        inv_chars <- c(inv_chars, uniq_inv)
      }
    }
  }

  # Save last sequence
  if (!is.null(current_id)) {
    ids <- c(ids, current_id)
    full_seq <- paste(current_seq, collapse = "")
    seq_lengths <- c(seq_lengths, nchar(full_seq))
    seq_chars <- c(seq_chars, strsplit(full_seq, "")[[1]])
  }

  result$n_sequences <- length(ids)
  result$ids <- ids

  # Duplicate ID check
  dup_ids <- ids[duplicated(ids)]
  if (length(dup_ids) > 0) {
    result$duplicate_ids <- unique(dup_ids)
    rlang::abort(paste0("ERROR: Duplicate sequence IDs found in ", filepath, ": ",
         paste(head(unique(dup_ids), 5), collapse = ", "),
         ". Each sequence must have a unique ID."),
         class = "Rclade_validate_error")
  }

  # Invalid characters: build the data.frame once from collected vectors (M-C2).
  invalid_chars <- if (length(inv_chars) > 0) {
    data.frame(line = inv_lines, char = inv_chars, stringsAsFactors = FALSE)
  } else {
    data.frame(line = integer(0), char = character(0), stringsAsFactors = FALSE)
  }
  if (nrow(invalid_chars) > 0) {
    unique_invalid <- unique(invalid_chars$char)
    log_warning("Invalid sequence characters in %s: %s (found at %d position(s)).",
                filepath, paste(unique_invalid, collapse = ", "),
                nrow(invalid_chars),
                .module = "validate-deep/validate_sequence_deep")
    result$invalid_chars <- invalid_chars
  }

  # Alphabet detection
  result$alphabet <- detect_alphabet(seq_chars)

  # Alignment length check
  if (check_alignment && length(seq_lengths) > 1) {
    if (length(unique(seq_lengths)) > 1) {
      log_warning("Sequences in %s have unequal lengths: min=%s, max=%s. Alignment may be required before tree building.",
                  filepath, min(seq_lengths), max(seq_lengths),
                  .module = "validate-deep/validate_sequence_deep")
      result$alignment_ok <- FALSE
    } else {
      result$alignment_ok <- TRUE
    }
  }

  log_info("FASTA validation: %d sequences, alphabet=%s",
           result$n_sequences, result$alphabet)

  return(result)
}

#' Validate FASTQ content
#' @keywords internal
validate_fastq_content <- function(lines, filepath, result) {
  ids <- character(0)
  seq_chars <- character(0)
  # Collect invalid characters in flat vectors, build the data.frame once at the
  # end (avoids O(n^2) rbind inside the loop, M-C2).
  inv_lines <- integer(0)
  inv_chars <- character(0)
  seq_lengths <- integer(0)

  # FASTQ: 4 lines per record (@ID, sequence, +, quality)
  n_lines <- length(lines)
  if (n_lines %% 4 != 0) {
    log_warning("FASTQ file %s has %d lines (not a multiple of 4). File may be truncated.",
                filepath, n_lines, .module = "validate-deep/validate_fastq")
  }

  n_records <- floor(n_lines / 4)
  for (i in seq_len(n_records)) {
    base <- (i - 1) * 4
    id_line <- trimws(lines[base + 1])
    seq_line <- toupper(trimws(lines[base + 2]))

    # Parse ID
    id <- sub("^@\\s*([^ \t]+).*", "\\1", id_line)
    ids <- c(ids, id)
    seq_lengths <- c(seq_lengths, nchar(seq_line))
    seq_chars <- c(seq_chars, strsplit(seq_line, "")[[1]])

    # Check for invalid characters
    chars <- strsplit(seq_line, "")[[1]]
    valid_dna <- c("A", "C", "G", "T", "U", "N", "-", "R", "Y", "S", "W",
                    "K", "M", "B", "D", "H", "V")
    invalid <- chars[!chars %in% valid_dna]
    if (length(invalid) > 0) {
      uniq_inv <- unique(invalid)
      inv_lines <- c(inv_lines, rep(base + 2, length(uniq_inv)))
      inv_chars <- c(inv_chars, uniq_inv)
    }
  }

  result$n_sequences <- length(ids)
  result$ids <- ids

  # Duplicate ID check
  dup_ids <- ids[duplicated(ids)]
  if (length(dup_ids) > 0) {
    result$duplicate_ids <- unique(dup_ids)
    rlang::abort(paste0("ERROR: Duplicate sequence IDs found in ", filepath, ": ",
         paste(head(unique(dup_ids), 5), collapse = ", "),
         ". Each sequence must have a unique ID."),
         class = "Rclade_validate_error")
  }

  # Invalid characters: build the data.frame once from collected vectors (M-C2).
  invalid_chars <- if (length(inv_chars) > 0) {
    data.frame(line = inv_lines, char = inv_chars, stringsAsFactors = FALSE)
  } else {
    data.frame(line = integer(0), char = character(0), stringsAsFactors = FALSE)
  }
  if (nrow(invalid_chars) > 0) {
    unique_invalid <- unique(invalid_chars$char)
    log_warning("Invalid sequence characters in %s: %s (found at %d position(s)).",
                filepath, paste(unique_invalid, collapse = ", "),
                nrow(invalid_chars),
                .module = "validate-deep/validate_sequence_deep")
    result$invalid_chars <- invalid_chars
  }

  # Alphabet detection
  result$alphabet <- detect_alphabet(seq_chars)

  log_info("FASTQ validation: %d sequences, alphabet=%s",
           result$n_sequences, result$alphabet)

  return(result)
}

#' Detect sequence alphabet from characters
#'
#' @param chars Character vector of individual sequence characters.
#' @return Character. One of "DNA", "RNA", "protein", "unknown".
#' @keywords internal
detect_alphabet <- function(chars) {
  if (length(chars) == 0) return("unknown")

  chars <- toupper(unique(chars))
  chars <- chars[chars != "-" & chars != " "]  # ignore gaps and spaces

  dna_chars <- c("A", "C", "G", "T")
  rna_chars <- c("A", "C", "G", "U")

  # If all chars are in DNA set
  if (all(chars %in% dna_chars)) return("DNA")

  # If all chars are in RNA set (contains U but not T)
  if (all(chars %in% rna_chars) && "U" %in% chars) return("RNA")

  # Extended IUPAC codes for nucleotides
  iupac_nuc <- c(dna_chars, rna_chars, "N", "R", "Y", "S", "W",
                  "K", "M", "B", "D", "H", "V")
  if (all(chars %in% iupac_nuc)) {
    if ("U" %in% chars && !"T" %in% chars) return("RNA")
    return("DNA")
  }

  # Otherwise protein
  return("protein")
}

# --- Empty file validation ---

#' Validate file is not empty
#'
#' Checks file size and raises CRITICAL if empty.
#'
#' @param filepath Character. Path to file.
#' @param file_type Character. Description for error messages.
#' @return Invisibly returns TRUE if not empty. Stops on empty file.
#' @keywords internal
validate_file_not_empty <- function(filepath, file_type = "input") {
  if (!file.exists(filepath)) {
    rlang::abort(paste0(file_type, " file does not exist: ", filepath),
                 class = "Rclade_read_error")
  }

  file_size <- file.size(filepath)
  if (file_size == 0 || is.na(file_size)) {
    log_critical("Empty %s file detected: %s (size = %d bytes)",
                 file_type, filepath, file_size)
    rlang::abort(paste0("CRITICAL: ", file_type, " file is empty (0 bytes): ", filepath,
         "\nThis may indicate a corrupted or truncated file."),
         class = "Rclade_read_error")
  }

  invisible(TRUE)
}

# --- Circular dependency detection in taxonomy ---

#' Detect circular dependencies in taxonomy table
#'
#' Validates full taxonomy consistency by checking for cyclical relationships
#' between \strong{every pair of adjacent ranks} (coarsest to finest), not just
#' the canonical domain/phylum/class/order chain. For example:
#' \itemize{
#'   \item domain <-> phylum, phylum <-> class, class <-> order,
#'   \item order <-> family, family <-> genus, genus <-> species
#' }
#' A circular dependency means a value appears as both a high-rank and a
#' low-rank member forming a loop (e.g. Row 1: \code{d__A;p__B},
#' Row 2: \code{d__B;p__A}).
#'
#' @param taxa_df data.frame with taxonomy columns (domain, phylum, class, etc.).
#' @param filepath Character. Source file for error messages.
#' @return Invisibly returns TRUE if no cycles. Aborts on detection
#'   (class \code{Rclade_validate_error}).
#' @keywords internal
#' @examples
#' \dontrun{
#' taxa <- read_taxonomy_file("taxonomy.tsv")
#' validate_taxonomy_no_cycles(taxa, "taxonomy.tsv")
#' }
validate_taxonomy_no_cycles <- function(taxa_df, filepath = "<taxonomy>") {
  # Full adjacency check across ALL rank levels (coarsest -> finest). Any
  # cyclical relationship between two adjacent ranks is reported. Internally
  # reuses find_rank_cycles for each adjacent pair.
  rank_order <- c("domain", "phylum", "class", "order",
                  "family", "genus", "species")
  present_ranks <- intersect(rank_order, names(taxa_df))

  for (k in seq_len(max(length(present_ranks) - 1L, 0L))) {
    rank_high <- present_ranks[k]
    rank_low <- present_ranks[k + 1L]
    cycles <- find_rank_cycles(taxa_df, rank_high, rank_low)
    if (length(cycles) > 0) {
      rlang::abort(
        sprintf(
          "Circular dependency detected in %s (%s <-> %s): %s",
          filepath, rank_high, rank_low,
          paste(head(cycles, 3), collapse = "; ")),
        class = "Rclade_validate_error")
    }
  }

  invisible(TRUE)
}

#' Find circular dependencies between two rank columns
#'
#' @param taxa_df data.frame with taxonomy columns.
#' @param rank_high Character. Higher rank column name.
#' @param rank_low Character. Lower rank column name.
#' @return Character vector of cycle descriptions (empty if none).
#' @keywords internal
find_rank_cycles <- function(taxa_df, rank_high, rank_low) {
  cycles <- character(0)

  if (!rank_high %in% names(taxa_df) || !rank_low %in% names(taxa_df)) {
    return(cycles)
  }

  # Build unique pairs of (high, low)
  pairs <- taxa_df[, c(rank_high, rank_low)]
  pairs <- pairs[complete.cases(pairs), ]
  pairs <- unique(pairs)

  if (nrow(pairs) == 0) return(cycles)

  # Check: is any value in rank_low also a value in rank_high?
  low_vals <- unique(pairs[[rank_low]])
  high_vals <- unique(pairs[[rank_high]])

  # Find values that appear in both columns
  shared <- intersect(low_vals, high_vals)

  if (length(shared) == 0) return(cycles)

  # For each shared value, check if it forms a cycle
  for (val in shared) {
    # Find rows where rank_low == val
    as_low <- pairs[pairs[[rank_low]] == val, rank_high]
    # Find rows where rank_high == val
    as_high <- pairs[pairs[[rank_high]] == val, rank_low]

    # Check if any value appears in both (excluding self-loops, which are
    # unresolved placeholders rather than true taxonomic cycles)
    cycle_partners <- setdiff(intersect(as_low, as_high), val)
    if (length(cycle_partners) > 0) {
      for (partner in cycle_partners) {
        cycles <- c(cycles, sprintf("%s<->%s (%s=%s, %s=%s)",
                                     rank_high, rank_low,
                                     rank_high, val, rank_low, partner))
      }
    }
  }

  return(cycles)
}

# --- Tree-Sequence Cross-Validation ---

#' Cross-validate tree tip labels against sequence IDs
#'
#' Checks that all tree tips have corresponding sequences and vice versa.
#'
#' @param tree phylo object or path to tree file.
#' @param sequence_file Character. Path to sequence file (FASTA/FASTQ).
#' @param quiet Logical. If TRUE, suppress messages.
#' @param mol_type Character. Molecule type for sequence validation: "DNA",
#'   "RNA", "protein", or "auto" (NULL). Default: \code{NULL}.
#' @param skip_length_check Logical. If TRUE, skip alignment length consistency
#'   check. Default: \code{FALSE}.
#' @param multi_tree_mode Character. How to handle multiple trees in a file when
#'   \code{tree} is a path. Default: \code{"error"}.
#' @return List with match status and differences.
#' @export
#' @examples
#' \dontrun{
#' result <- validate_tree_sequence_match("tree.nwk", "sequences.fasta")
#' }
validate_tree_sequence_match <- function(tree, sequence_file, quiet = FALSE,
                                          mol_type = NULL,
                                          skip_length_check = FALSE,
                                          multi_tree_mode = "error") {
  # Get tree tip labels
  if (is.character(tree)) {
    tree <- read_tree_auto(tree, multi_tree_mode = multi_tree_mode)
  }
  if (inherits(tree, "multiPhylo")) {
    log_warning("Cross-validation with multiple trees: validating against the first tree only.",
                .module = "validate-deep/cross_validate_tree_and_sequences")
    tree <- tree[[1]]
  }
  if (!inherits(tree, "phylo")) {
    rlang::abort("'tree' must be a phylo object or file path.",
                 class = "Rclade_validate_error")
  }
  tree_labels <- tree$tip.label

  # Resolve mol_type: "auto" means no expected alphabet
  expected_alphabet <- if (!is.null(mol_type) && tolower(mol_type) != "auto") {
    toupper(mol_type)
  } else {
    NULL
  }

  # Get sequence IDs
  seq_result <- validate_sequence_deep(
    sequence_file,
    expected_alphabet = expected_alphabet,
    check_alignment = !skip_length_check
  )
  seq_ids <- seq_result$ids

  # Set comparison
  tree_set <- sort(unique(tree_labels))
  seq_set <- sort(unique(seq_ids))

  only_in_tree <- setdiff(tree_set, seq_set)
  only_in_seq <- setdiff(seq_set, tree_set)
  in_both <- intersect(tree_set, seq_set)

  result <- list(
    is_match = (length(only_in_tree) == 0 && length(only_in_seq) == 0),
    n_tree_tips = length(tree_labels),
    n_seq_ids = length(seq_ids),
    n_common = length(in_both),
    only_in_tree = only_in_tree,
    only_in_seq = only_in_seq
  )

  if (!quiet) {
    if (result$is_match) {
      log_info("Tree-sequence cross-check PASSED: %d labels match", length(in_both))
    } else {
      log_error("Tree-sequence cross-check FAILED",
                .module = "validate-deep/cross_validate_tree_and_sequences")
      if (length(only_in_tree) > 0) {
        log_error("  Only in tree (%d): %s",
                  length(only_in_tree),
                  paste(head(only_in_tree, 5), collapse = ", "),
                  .module = "validate-deep/cross_validate_tree_and_sequences")
      }
      if (length(only_in_seq) > 0) {
        log_error("  Only in sequences (%d): %s",
                  length(only_in_seq),
                  paste(head(only_in_seq, 5), collapse = ", "),
                  .module = "validate-deep/cross_validate_tree_and_sequences")
      }
    }
  }

  if (!result$is_match) {
    rlang::abort(
      paste0("Tree tip labels and sequence IDs do not match.\n",
             "  Tree tips: ", length(tree_labels), "\n",
             "  Sequence IDs: ", length(seq_ids), "\n",
             "  Only in tree: ", length(only_in_tree), "\n",
             "  Only in sequences: ", length(only_in_seq)),
      class = "Rclade_validate_error")
  }

  return(invisible(result))
}

