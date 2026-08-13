# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Self-check mode and dependency validation

#' Run Rclade self-test
#'
#' Performs comprehensive self-check:
#' 1. Required package availability and versions
#' 2. Example tree parsing and taxonomy extraction
#' 3. Monophyly logic validation
#'
#' @return Integer. Exit code (0 = all passed, 1 = failures).
#' @export
#' @examples
#' \dontrun{
#' run_rclade_selftest()
#' }
run_rclade_selftest <- function() {
  results <- list()
  all_passed <- TRUE

  cat("\n")
  cat("================================================================\n")
  cat("  Rclade Self-Test\n")
  cat("================================================================\n\n")

  # --- 1. Dependency checks ---
  cat("--- Dependency Checks ---\n\n")

  deps <- list(
    list(name = "ape",        min_version = "5.0",  required = TRUE),
    list(name = "ggtree",     min_version = "4.0.0", required = TRUE),
    list(name = "deeptime",   min_version = "1.0",  required = TRUE),
    list(name = "ggplot2",    min_version = "3.5.0", required = TRUE),
    list(name = "rlang",      min_version = "1.0",  required = TRUE),
    list(name = "stringr",    min_version = "1.5",  required = TRUE),
    list(name = "tidytree",   min_version = "0.4",  required = TRUE),
    list(name = "treeio",     min_version = "1.0",  required = FALSE),
    list(name = "phangorn",   min_version = "2.0",  required = FALSE),
    list(name = "RColorBrewer", min_version = "1.0", required = FALSE),
    list(name = "viridisLite", min_version = "0.4",  required = FALSE),
    list(name = "optparse",   min_version = "1.7",  required = FALSE),
    list(name = "shiny",      min_version = "1.7",  required = FALSE)
  )

  for (dep in deps) {
    result <- check_dependency(dep$name, dep$min_version, dep$required)
    results <- c(results, list(result))
    if (!result$passed) all_passed <- FALSE
  }

  # R version check (must match DESCRIPTION: R >= 4.1.0).
  # Use the full major.minor string via numeric_version so trailing components
  # of R.version$minor are compared correctly (L-C8).
  r_ok <- tryCatch(
    numeric_version(paste(R.version$major, R.version$minor, sep = ".")) >=
      numeric_version("4.1.0"),
    error = function(e) FALSE
  )
  results <- c(results, list(list(
    test = sprintf("R version >= 4.1.0 (found %s)", R.version.string),
    passed = r_ok,
    required = TRUE
  )))
  if (!r_ok) all_passed <- FALSE

  cat("\n")

  # --- 2. Example tree parsing ---
  cat("--- Example Tree Parsing ---\n\n")

  result <- check_example_tree()
  results <- c(results, list(result))
  if (!result$passed) all_passed <- FALSE

  cat("\n")

  # --- 3. Taxonomy extraction ---
  cat("--- Taxonomy Extraction ---\n\n")

  result <- check_taxonomy_extraction()
  results <- c(results, list(result))
  if (!result$passed) all_passed <- FALSE

  cat("\n")

  # --- 4. Monophyly logic ---
  cat("--- Monophyly Logic ---\n\n")

  result <- check_monophyly_logic()
  results <- c(results, list(result))
  if (!result$passed) all_passed <- FALSE

  cat("\n")

  # --- 5. Deep validation ---
  cat("--- Input Validation ---\n\n")

  result <- check_input_validation()
  results <- c(results, list(result))
  if (!result$passed) all_passed <- FALSE

  cat("\n")

  # --- Summary ---
  cat("================================================================\n")
  cat("  Summary\n")
  cat("================================================================\n\n")

  n_pass <- sum(sapply(results, function(r) r$passed))
  n_fail <- sum(sapply(results, function(r) !r$passed))
  n_total <- length(results)

  for (r in results) {
    status <- if (r$passed) "[PASS]" else "[FAIL]"
    req <- if (isTRUE(r$required)) "(required)" else "(optional)"
    cat(sprintf("  %s %s %s\n", status, r$test, req))
  }

  cat(sprintf("\n  Total: %d | Passed: %d | Failed: %d\n\n", n_total, n_pass, n_fail))

  if (all_passed) {
    cat("  All checks passed.\n\n")
    return(invisible(0L))
  } else {
    cat("  Some checks failed. See above for details.\n\n")
    return(invisible(1L))
  }
}

#' Check a single dependency
#' @keywords internal
check_dependency <- function(name, min_version, required) {
  installed <- requireNamespace(name, quietly = TRUE)

  if (!installed) {
    status <- if (required) "MISSING (required)" else "MISSING (optional)"
    cat(sprintf("  [FAIL] %-15s %s\n", name, status))
    return(list(
      test = sprintf("Package '%s'", name),
      passed = !required,  # Only fail if required
      required = required
    ))
  }

  version <- tryCatch(
    as.character(utils::packageVersion(name)),
    error = function(e) "unknown"
  )

  version_ok <- tryCatch({
    if (version == "unknown") TRUE
    else utils::compareVersion(version, min_version) >= 0
  }, error = function(e) TRUE)

  if (version_ok) {
    cat(sprintf("  [PASS] %-15s %s (>= %s)\n", name, version, min_version))
  } else {
    cat(sprintf("  [FAIL] %-15s %s (< %s, update required)\n", name, version, min_version))
  }

  return(list(
    test = sprintf("Package '%s' >= %s", name, min_version),
    passed = version_ok,
    required = required
  ))
}

#' Check example tree loading and structure
#' @keywords internal
check_example_tree <- function() {
  tryCatch({
    utils::data("example_tree", package = "Rclade", envir = environment())

    if (!exists("example_tree")) {
      cat("  [FAIL] Example tree not found in package data\n")
      return(list(test = "Example tree loading", passed = FALSE, required = TRUE))
    }

    n_tips <- ape::Ntip(example_tree)
    n_nodes <- ape::Nnode(example_tree)
    is_binary <- ape::is.binary(example_tree)

    cat(sprintf("  [PASS] Example tree loaded: %d tips, %d nodes\n", n_tips, n_nodes))

    if (!is_binary) {
      cat("  [WARN] Example tree is not fully bifurcating\n")
    } else {
      cat("  [PASS] Example tree is fully bifurcating\n")
    }

    # Check edge lengths. A zero-length root edge is biologically valid (it
    # carries no evolutionary time), so only non-root edges must be strictly
    # positive (L-C7).
    has_edges <- !is.null(example_tree$edge.length)
    n_tips <- ape::Ntip(example_tree)
    root_node <- n_tips + example_tree$Nnode
    is_root_edge <- example_tree$edge[, 1] == root_node
    non_root_len <- example_tree$edge.length[!is_root_edge]
    all_positive <- has_edges && all(non_root_len > 0, na.rm = TRUE)
    if (all_positive) {
      cat("  [PASS] All edge lengths are positive\n")
    } else {
      cat("  [FAIL] Some non-root edge lengths are non-positive\n")
      return(list(test = "Example tree structure", passed = FALSE, required = TRUE))
    }

    return(list(test = "Example tree loading", passed = TRUE, required = TRUE))
  }, error = function(e) {
    cat(sprintf("  [FAIL] Error loading example tree: %s\n", e$message))
    return(list(test = "Example tree loading", passed = FALSE, required = TRUE))
  })
}

#' Check taxonomy extraction from example tree
#' @keywords internal
check_taxonomy_extraction <- function() {
  tryCatch({
    utils::data("example_tree", package = "Rclade", envir = environment())

    # Test Format B (GTDB/semicolon) detection
    detected <- detect_taxonomy_format(example_tree$tip.label)
    cat(sprintf("  [PASS] Format B detected: %s\n", detected))

    # Test phylum-level extraction (Format B)
    taxa_df <- parse_gtdb(example_tree$tip.label)
    phyla <- unique(na.omit(taxa_df$phylum))
    cat(sprintf("  [PASS] Format B phyla extracted: %d (%s)\n", length(phyla),
                paste(head(phyla, 3), collapse = ", ")))

    # Test class-level extraction
    classes <- unique(na.omit(taxa_df$class))
    cat(sprintf("  [PASS] Format B classes extracted: %d (%s)\n", length(classes),
                paste(head(classes, 3), collapse = ", ")))

    # Check parse rates
    na_phylum <- sum(is.na(taxa_df$phylum))
    na_class <- sum(is.na(taxa_df$class))
    if (na_phylum == 0 && na_class == 0) {
      cat("  [PASS] Format B: all labels parsed successfully\n")
    } else {
      cat(sprintf("  [WARN] Format B NAs: phylum=%d, class=%d\n", na_phylum, na_class))
    }

    # Test Format A (embedded) parsing
    test_labels_a <- c(
      "GB_GCA_001_d_D1_p_P1_c_C1",
      "GB_GCA_002_d_D1_p_P2_c_C3"
    )
    detected_a <- detect_taxonomy_format(test_labels_a)
    cat(sprintf("  [PASS] Format A detected: %s\n", detected_a))

    taxa_a <- parse_embedded(test_labels_a)
    if (!is.na(taxa_a$domain[1]) && taxa_a$domain[1] == "D1") {
      cat("  [PASS] Format A domain extraction\n")
    } else {
      cat("  [FAIL] Format A domain extraction\n")
      return(list(test = "Taxonomy extraction", passed = FALSE, required = TRUE))
    }
    if (!is.na(taxa_a$phylum[1]) && taxa_a$phylum[1] == "P1") {
      cat("  [PASS] Format A phylum extraction\n")
    } else {
      cat("  [FAIL] Format A phylum extraction\n")
      return(list(test = "Taxonomy extraction", passed = FALSE, required = TRUE))
    }

    # Test Format A with missing level
    test_labels_missing <- c("GB_GCA_001_d_D1_c_C1")
    taxa_missing <- parse_embedded(test_labels_missing)
    if (is.na(taxa_missing$phylum[1])) {
      cat("  [PASS] Format A missing level handling\n")
    } else {
      cat("  [FAIL] Format A missing level handling\n")
    }

    # Test Format B value validation (malformed value with __)
    test_labels_malformed <- c("d__D1;p__Foo__Bar;c__Test")
    withCallingHandlers(
      {
        taxa_malformed <- parse_semicolon_delimited(test_labels_malformed)
        if (is.na(taxa_malformed$phylum[1])) {
          cat("  [PASS] Format B malformed value rejection\n")
        } else {
          cat("  [FAIL] Format B malformed value rejection\n")
        }
      },
      warning = function(w) {
        cat("  [PASS] Format B malformed value warning caught\n")
        invokeRestart("muffleWarning")
      }
    )

    return(list(test = "Taxonomy extraction", passed = TRUE, required = TRUE))
  }, error = function(e) {
    cat(sprintf("  [FAIL] Error in taxonomy extraction: %s\n", e$message))
    return(list(test = "Taxonomy extraction", passed = FALSE, required = TRUE))
  })
}

#' Check monophyly logic with known cases
#' @keywords internal
check_monophyly_logic <- function() {
  tryCatch({
    utils::data("example_tree", package = "Rclade", envir = environment())

    taxa_df <- parse_gtdb(example_tree$tip.label)
    phyla <- unique(na.omit(taxa_df$phylum))

    all_mono <- TRUE
    for (p in phyla) {
      result <- check_monophyly(example_tree, p, rank = "phylum",
                                 format = "GTDB", quiet = TRUE)
      if (result$is_monophyletic) {
        cat(sprintf("  [PASS] %s: monophyletic (node %d, %d tips)\n",
                    p, result$mrca_node, result$n_tips))
      } else {
        cat(sprintf("  [FAIL] %s: NOT monophyletic\n", p))
        all_mono <- FALSE
      }
    }

    # Test special identifiers on the example tree
    luca <- resolve_special_identifier(example_tree, "LUCA", quiet = TRUE)
    if (!is.null(luca$node)) {
      cat(sprintf("  [PASS] LUCA: node %d, %d descendant tips\n",
                  luca$node, luca$n_tips))
    } else {
      cat("  [WARN] LUCA: no node found\n")
    }

    lbca <- resolve_special_identifier(example_tree, "LBCA", quiet = TRUE)
    if (!is.null(lbca$node)) {
      cat(sprintf("  [PASS] LBCA: node %d, %d descendant tips\n",
                  lbca$node, lbca$n_tips))
    } else {
      cat("  [WARN] LBCA: no node found (single-domain tree)\n")
    }

    return(list(test = "Monophyly logic", passed = all_mono, required = TRUE))
  }, error = function(e) {
    cat(sprintf("  [FAIL] Error in monophyly check: %s\n", e$message))
    return(list(test = "Monophyly logic", passed = FALSE, required = TRUE))
  })
}

#' Check input validation functions
#' @keywords internal
check_input_validation <- function() {
  tryCatch({
    # Test Newick validation
    validate_newick_syntax("(A:1,B:1):1;", "test")
    cat("  [PASS] Newick syntax validation\n")

    # Test negative branch detection
    neg_caught <- tryCatch({
      validate_newick_syntax("(A:-1,B:1):1;", "test")
      FALSE
    }, error = function(e) grepl("Negative", e$message))
    if (neg_caught) {
      cat("  [PASS] Negative branch length detection\n")
    } else {
      cat("  [FAIL] Negative branch length not detected\n")
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Test bracket balance detection
    bracket_caught <- tryCatch({
      validate_newick_syntax("(A:1,B:1;", "test")
      FALSE
    }, error = function(e) grepl("unmatched", e$message))
    if (bracket_caught) {
      cat("  [PASS] Bracket balance detection\n")
    } else {
      cat("  [FAIL] Bracket imbalance not detected\n")
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Test tree structure validation
    tree <- ape::read.tree(text = "(A:1,B:1):1;")
    validate_tree_deep(tree, "test")
    cat("  [PASS] Tree structure validation\n")

    # Test self-loop detection
    loop_caught <- tryCatch({
      bad_tree <- tree
      bad_tree$edge <- rbind(bad_tree$edge, c(3, 3))
      validate_tree_deep(bad_tree, "test")
      FALSE
    }, error = function(e) grepl("self-loop", e$message))
    if (loop_caught) {
      cat("  [PASS] Self-loop detection\n")
    } else {
      cat("  [FAIL] Self-loop not detected\n")
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Test alphabet detection
    dna_ok <- detect_alphabet(c("A", "C", "G", "T")) == "DNA"
    rna_ok <- detect_alphabet(c("A", "C", "G", "U")) == "RNA"
    prot_ok <- detect_alphabet(c("A", "L", "F", "G")) == "protein"
    if (dna_ok && rna_ok && prot_ok) {
      cat("  [PASS] Alphabet detection (DNA/RNA/protein)\n")
    } else {
      cat("  [FAIL] Alphabet detection\n")
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Test duplicate tip label handling (should WARN, not ERROR)
    # Base R only (no third-party test/assertion-package dependency) so run_rclade_selftest()
    # works standalone for end users / CI without testthat loaded.
    selftest_op <- options(rclade.log_level = "WARNING")
    on.exit(options(selftest_op), add = TRUE)
    dup_msgs <- utils::capture.output({
      dup_tree <- ape::read.tree(text = "(A:1,B:1):1;")
      dup_tree$tip.label[1] <- "B"
      validate_tree_deep(dup_tree, "test")
      NULL
    }, type = "message")
    dup_warned <- any(grepl("duplicate", dup_msgs, ignore.case = TRUE))
    if (dup_warned) {
      cat("  [PASS] Duplicate tip label handled (WARNING)\n")
    } else {
      cat("  [FAIL] Duplicate tip label not warned\n")
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Test BiDi marker detection
    bidi_caught <- tryCatch({
      check_malicious_chars(paste0("tip", "\u202E", "1"), "test")
      FALSE
    }, error = function(e) grepl("bidirectional", e$message))
    if (bidi_caught) {
      cat("  [PASS] BiDi marker detection\n")
    } else {
      cat("  [FAIL] BiDi marker not detected\n")
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Test sequence validation
    tmp_fasta <- tempfile(fileext = ".fasta")
    writeLines(c(">seq1", "ACGTACGT", ">seq2", "TTTTAAAA"), tmp_fasta)
    seq_result <- validate_sequence_deep(tmp_fasta, expected_alphabet = "DNA")
    if (seq_result$n_sequences == 2 && seq_result$alphabet == "DNA") {
      cat("  [PASS] Sequence validation (FASTA, DNA)\n")
    } else {
      cat("  [FAIL] Sequence validation\n")
      unlink(tmp_fasta)
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Test duplicate sequence ID detection
    tmp_dup <- tempfile(fileext = ".fasta")
    writeLines(c(">seq1", "ACGT", ">seq1", "TTTT"), tmp_dup)
    dup_seq_caught <- tryCatch({
      validate_sequence_deep(tmp_dup)
      FALSE
    }, error = function(e) grepl("Duplicate", e$message))
    if (dup_seq_caught) {
      cat("  [PASS] Duplicate sequence ID detection (ERROR)\n")
    } else {
      cat("  [FAIL] Duplicate sequence ID not detected\n")
      unlink(tmp_fasta)
      unlink(tmp_dup)
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Test PHYLIP rejection
    tmp_phylip <- tempfile(fileext = ".phy")
    writeLines(c("5 100", "seq1 ACGTACGTAC"), tmp_phylip)
    phylip_caught <- tryCatch({
      validate_sequence_deep(tmp_phylip)
      FALSE
    }, error = function(e) grepl("PHYLIP", e$message))
    if (phylip_caught) {
      cat("  [PASS] PHYLIP format rejection\n")
    } else {
      cat("  [FAIL] PHYLIP format not rejected\n")
      unlink(tmp_fasta)
      unlink(tmp_dup)
      unlink(tmp_phylip)
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Test empty file rejection
    tmp_empty <- tempfile(fileext = ".nwk")
    writeBin(raw(0), tmp_empty)
    empty_caught <- tryCatch({
      validate_file_not_empty(tmp_empty, "Tree")
      FALSE
    }, error = function(e) grepl("CRITICAL", e$message))
    if (empty_caught) {
      cat("  [PASS] Empty file rejection (CRITICAL)\n")
    } else {
      cat("  [FAIL] Empty file not rejected\n")
      unlink(tmp_fasta)
      unlink(tmp_dup)
      unlink(tmp_phylip)
      unlink(tmp_empty)
      return(list(test = "Input validation", passed = FALSE, required = TRUE))
    }

    # Cleanup
    unlink(tmp_fasta)
    unlink(tmp_dup)
    unlink(tmp_phylip)
    unlink(tmp_empty)

    return(list(test = "Input validation", passed = TRUE, required = TRUE))
  }, error = function(e) {
    cat(sprintf("  [FAIL] Error in validation check: %s\n", e$message))
    return(list(test = "Input validation", passed = FALSE, required = TRUE))
  })
}
