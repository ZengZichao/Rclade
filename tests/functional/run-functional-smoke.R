#!/usr/bin/env Rscript
#
# Rclade Functional Smoke Test
# Covers P0 / P1 core use cases from the test plan; fast execution, CI-suitable.
#

suppressPackageStartupMessages({
  library(testthat)
  library(Rclade)
})

# Reduce log noise; keep ERROR and above only
set_log_level("ERROR")

# Path setup
base_dir <- file.path(getwd(), "tests/functional")
input_dir <- file.path(base_dir, "input")
output_dir <- file.path(base_dir, "output")
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# Load example tree once globally
data(example_tree)

# Helper: build a small tree with unique tip labels (for file-write / CLI tests)
make_unique_tree <- function(n = 10) {
  set.seed(42)
  tree <- ape::rtree(n)
  tree$tip.label <- paste0("tip_", seq_len(n))
  tree
}

# Helper: safe output path; removes existing file first
output_path <- function(name) {
  f <- file.path(output_dir, name)
  if (file.exists(f)) unlink(f)
  f
}

# Summary counters
total <- 0L
pass <- 0L
fail <- 0L
skip <- 0L
results <- list()

run <- function(id, expr, blocked_by = NULL) {
  total <<- total + 1L
  name <- id
  if (!is.null(blocked_by)) {
    skip <<- skip + 1L
    results[[name]] <<- "SKIP"
    return(invisible(NULL))
  }
  ok <- tryCatch({
    eval(expr)
    TRUE
  }, error = function(e) {
    message("FAIL: ", name, " -- ", conditionMessage(e))
    FALSE
  })
  if (isTRUE(ok)) {
    pass <<- pass + 1L
    results[[name]] <<- "PASS"
  } else {
    fail <<- fail + 1L
    results[[name]] <<- "FAIL"
  }
  invisible(NULL)
}

# ==============================================================================
# 1. Main pipeline tests (plot_timetree)
# ==============================================================================
run("P-001: phylo object input", {
  p <- plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  expect_true(!is.null(attr(p, "rclade_info")))
})

run("P-002: file path input", {
  p <- plot_timetree(file.path(input_dir, "test_tree_simple.nwk"), add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-004: NULL input errors", {
  expect_error(plot_timetree(NULL), "tree")
})

run("P-005: nonexistent file errors", {
  expect_error(plot_timetree("nonexistent.tre"), "does not exist|file")
})

run("P-006: triangle_mode = mixed", {
  p <- plot_timetree(example_tree, rank = "phylum", triangle_mode = "mixed", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-007: triangle_mode = max", {
  p <- plot_timetree(example_tree, rank = "phylum", triangle_mode = "max", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-008: triangle_mode = min", {
  p <- plot_timetree(example_tree, rank = "phylum", triangle_mode = "min", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-009: triangle_mode = none", {
  p <- plot_timetree(example_tree, rank = "phylum", triangle_mode = "none", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-014: rectangular layout", {
  p <- plot_timetree(example_tree, rank = "phylum", layout = "rectangular", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-015: circular layout", {
  p <- plot_timetree(example_tree, rank = "phylum", layout = "circular", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-040: GTDB format", {
  p <- plot_timetree(example_tree, rank = "phylum", taxonomy_format = "GTDB", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-050: return value type", {
  p <- plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-051: rclade_info attribute", {
  p <- plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE)
  info <- attr(p, "rclade_info")
  expect_true(!is.null(info))
  expect_true(all(c("n_tips", "n_groups", "taxonomy_format") %in% names(info)))
})

run("P-120: valid custom groups", {
  tree <- ape::read.tree(text = "((A:0.1,B:0.15):0.1,(C:0.2,D:0.25):0.1):0.05;")
  groups <- list(Group1 = c("A", "B"), Group2 = c("C", "D"))
  p <- plot_timetree(tree, groups = groups, add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

# ==============================================================================
# 2. Taxonomy parsing tests
# ==============================================================================
run("T-001: GTDB auto-detection", {
  expect_equal(detect_taxonomy_format("d__D1;p__P1;c__C1"), "GTDB")
})

run("T-002: embedded auto-detection", {
  expect_equal(detect_taxonomy_format("GB_GCA_001_d_D1_p_P1_c_C1"), "embedded")
})

run("T-003: Silva auto-detection", {
  # Real Silva-style labels (domain prefix) should detect as Silva;
  # uninformative coded labels (e.g. D1;P1;C1) should conservatively fall back to "unknown"
  expect_equal(detect_taxonomy_format("Bacteria;P1;C1"), "Silva")
  suppressMessages(expect_equal(detect_taxonomy_format("D1;P1;C1"), "unknown"))
})

run("T-020: standard GTDB parsing", {
  r <- Rclade:::parse_gtdb("d__D1;p__P1;c__C1")
  expect_equal(r$domain[1], "D1")
  expect_equal(r$phylum[1], "P1")
})

run("T-021: empty value parsing", {
  r <- Rclade:::parse_gtdb("d__D1;p__;c__")
  expect_equal(r$domain[1], "D1")
  expect_true(is.na(r$phylum[1]))
})

run("T-030: standard Silva parsing", {
  r <- Rclade:::parse_silva("D1;P1;C1")
  expect_equal(r$domain[1], "D1")
  expect_equal(r$phylum[1], "P1")
})

run("T-040: standard NCBI parsing", {
  r <- Rclade:::parse_ncbi("cellular organisms;D1;P1", quiet = TRUE)
  expect_equal(r$domain[1], "D1")
})

run("T-060: normal report", {
  r <- summarize_taxonomy_quality(example_tree$tip.label, format = "GTDB")
  expect_true(!is.null(r))
  expect_true(all(c("format", "total") %in% names(r)))
})

# ==============================================================================
# 3. Monophyly checking tests
# ==============================================================================
run("MO-001: monophyletic group", {
  r <- check_monophyly(example_tree, "P5", rank = "phylum", format = "GTDB", quiet = TRUE)
  expect_true(r$is_monophyletic)
})

run("MO-002: non-monophyletic group", {
  r <- check_monophyly(example_tree, "NonExistent", rank = "phylum", format = "GTDB", quiet = TRUE)
  expect_false(r$is_monophyletic)
})

run("MO-006: case-insensitive matching", {
  r1 <- check_monophyly(example_tree, "P5", rank = "phylum", format = "GTDB", quiet = TRUE)
  r2 <- check_monophyly(example_tree, "p5", rank = "phylum", format = "GTDB", quiet = TRUE)
  expect_equal(r1$is_monophyletic, r2$is_monophyletic)
})

# ==============================================================================
# 4. Special identifier tests
# ==============================================================================
run("S-001: ROOT identifier", {
  r <- Rclade:::resolve_special_identifier(example_tree, "ROOT", quiet = TRUE)
  expect_equal(r$node, ape::Ntip(example_tree) + 1)
})

run("S-010: LUCA", {
  r <- Rclade:::resolve_special_identifier(example_tree, "LUCA", quiet = TRUE)
  expect_true(!is.null(r$node))
})

run("S-030: LBCA", {
  r <- Rclade:::resolve_special_identifier(example_tree, "LBCA", quiet = TRUE)
  expect_true(!is.null(r$node))
})

run("S-040: invalid identifier errors", {
  expect_error(Rclade:::resolve_special_identifier(example_tree, "FOOBAR", quiet = TRUE))
})

run("S-041: case insensitive", {
  r1 <- Rclade:::resolve_special_identifier(example_tree, "LUCA", quiet = TRUE)
  r2 <- Rclade:::resolve_special_identifier(example_tree, "luca", quiet = TRUE)
  expect_equal(r1$node, r2$node)
})

run("S-050/051: resolve_group", {
  r_special <- Rclade:::resolve_group(example_tree, "LUCA", quiet = TRUE)
  expect_true(r_special$is_special)
  r_normal <- Rclade:::resolve_group(example_tree, "P5", rank = "phylum", format = "GTDB", quiet = TRUE)
  expect_false(r_normal$is_special)
})

# ==============================================================================
# 5. Input validation tests
# ==============================================================================
run("V-001: empty string errors", {
  expect_error(Rclade:::validate_newick_syntax("", "test"), "empty")
})

run("V-002/003: unmatched parentheses errors", {
  expect_error(Rclade:::validate_newick_syntax("((A:1,B:1):1;", "test"), "unmatched")
  expect_error(Rclade:::validate_newick_syntax("(A:1,B:1)):1;", "test"), "unmatched")
})

run("V-004: negative branch length errors", {
  expect_error(Rclade:::validate_newick_syntax("(A:-1,B:1):1;", "test"), "Negative")
})

run("V-011: non-phylo object errors", {
  expect_error(Rclade:::validate_tree_deep(data.frame(), "test"), "phylo")
})

run("V-070: duplicate tip labels warning", {
  # Duplicate tip labels are downgraded to a warning (log message) by design,
  # not a hard error -- duplicate labels along the same taxonomic path are valid
  # input in the auto-collapse workflow (see validate-deep.R comments).
  # The smoke script sets log level to ERROR globally; here we locally raise to
  # WARNING to capture the message.
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$tip.label[1] <- "B"
  withr::with_options(list(rclade.log_level = "WARNING"), {
    expect_message(Rclade:::validate_tree_deep(tree, "test"), "duplicate")
  })
})

run("V-071: empty tip label errors", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$tip.label[1] <- ""
  expect_error(Rclade:::validate_tree_deep(tree, "test"), "empty")
})

# ==============================================================================
# 6. Logger system tests
# ==============================================================================
run("L-001/002/003: log level setting", {
  expect_silent(set_log_level("DEBUG"))
  expect_error(set_log_level("INVALID"), "Invalid")
  expect_silent(set_log_level("info"))
})

run("L-004: disable logging", {
  expect_silent(set_log_enabled(FALSE))
  expect_silent(set_log_enabled(TRUE))
})

# ==============================================================================
# 7. CLI tests
# ==============================================================================
run("C-001: show help", {
  expect_equal(run_rclade_cli(c("--help")), 0L)
})

run("C-002/003: show version", {
  expect_equal(run_rclade_cli(c("--version")), 0L)
})

run("C-010: missing -f errors", {
  expect_equal(run_rclade_cli(c("-r", "phylum")), 2L)
})

run("C-011: nonexistent input file errors", {
  expect_equal(run_rclade_cli(c("-f", "nonexistent.tre")), 2L)
})

run("C-070: CLI normal completion exit code", {
  tree <- make_unique_tree(10)
  tree_file <- tempfile(fileext = ".tre")
  on.exit(unlink(tree_file), add = TRUE)
  ape::write.tree(tree, tree_file)

  tmp <- tempfile(fileext = ".pdf")
  on.exit(unlink(tmp), add = TRUE)
  # v1.1.0 fail-safe unit contract: the default timescale requires an
  # explicit unit, so the no-timescale path is exercised here.
  result <- run_rclade_cli(c("-f", tree_file, "-r", "none", "-o", tmp,
                             "--no_timescale"))
  expect_equal(result, 0L)
  expect_true(file.exists(tmp))
})

run("C-071: CLI fail-safe unit contract (v1.1.0)", {
  tree <- make_unique_tree(10)
  tree_file <- tempfile(fileext = ".tre")
  on.exit(unlink(tree_file), add = TRUE)
  ape::write.tree(tree, tree_file)

  tmp <- tempfile(fileext = ".pdf")
  on.exit(unlink(tmp), add = TRUE)
  # Timescale enabled (default) without an explicit unit must fail as a
  # parameter error (exit code 2): Rclade does not infer branch-length units.
  expect_equal(run_rclade_cli(c("-f", tree_file, "-r", "none", "-o", tmp)), 2L)
  # An explicit unit completes successfully.
  expect_equal(run_rclade_cli(c("-f", tree_file, "-r", "none", "-o", tmp,
                                "-u", "Ma", "--force")), 0L)
})

# ==============================================================================
# 8. End-to-end integration tests
# ==============================================================================
run("E2E-001: basic pipeline", {
  f <- output_path("e2e_smoke_basic.pdf")
  p <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "force")
  expect_s3_class(p, "ggplot")
  expect_true(file.exists(f))
})

run("E2E-003: special identifier highlight", {
  f <- output_path("e2e_smoke_highlight.pdf")
  p <- plot_timetree(example_tree, highlight = "LUCA", output = f, add_timescale = FALSE, overwrite = "force")
  expect_s3_class(p, "ggplot")
  expect_true(file.exists(f))
})

run("E2E-004: specified clade collapse", {
  f <- output_path("e2e_smoke_clade.pdf")
  p <- plot_timetree(example_tree, clade = "P5", taxonomy_format = "GTDB",
                     output = f, add_timescale = FALSE, overwrite = "force")
  expect_s3_class(p, "ggplot")
  expect_true(file.exists(f))
})

run("E2E-002: external taxonomy file", {
  f <- output_path("e2e_smoke_taxonomy.pdf")
  p <- plot_timetree(file.path(input_dir, "test_tree.nwk"), rank = "class",
                     taxonomy_file = file.path(input_dir, "test_taxonomy.tsv"),
                     taxonomy_file_header = TRUE,
                     output = f, add_timescale = FALSE, overwrite = "force")
  expect_s3_class(p, "ggplot")
  expect_true(file.exists(f))
})

# ==============================================================================
# 9. Output saving tests
# ==============================================================================
run("O-001: PDF output", {
  f <- output_path("smoke_output.pdf")
  p <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "force")
  expect_true(file.exists(f))
})

run("O-002: PNG output", {
  f <- output_path("smoke_output.png")
  p <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "force")
  expect_true(file.exists(f))
})

run("O-003: SVG output", {
  f <- output_path("smoke_output.svg")
  p <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "force")
  expect_true(file.exists(f))
})

run("O-007/008/009: overwrite modes", {
  f <- output_path("smoke_overwrite.pdf")
  p <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "force")
  expect_true(file.exists(f))
  # no-clobber should skip without error
  p2 <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "no-clobber")
  expect_s3_class(p2, "ggplot")
  # ask in non-interactive session degrades to skip-save (no error, no overwrite; see save-timetree.R M-D5)
  before <- file.info(f)$mtime
  p3 <- suppressMessages(
    plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "ask")
  )
  expect_s3_class(p3, "ggplot")
  expect_equal(file.info(f)$mtime, before)
})

# ==============================================================================
# 10. Visualization component tests
# ==============================================================================
run("CL-001/002/003: color generation", {
  expect_equal(length(Rclade:::generate_colors(character(0))), 0)
  expect_equal(length(Rclade:::generate_colors(letters[1:5], palette = "viridis")), 5)
  expect_equal(length(Rclade:::generate_colors(letters[1:5], palette = "rainbow")), 5)
})

run("TS-001/002: time units", {
  p1 <- plot_timetree(example_tree, rank = "phylum", add_timescale = TRUE, unit = "Ga")
  expect_s3_class(p1, "ggplot")
  p2 <- plot_timetree(example_tree, rank = "phylum", add_timescale = TRUE, unit = "Ma")
  expect_s3_class(p2, "ggplot")
})

run("GE-001: default geo events", {
  p <- plot_timetree(example_tree, rank = "phylum", geo_events = TRUE, add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("LG-001/003: legend position", {
  p1 <- plot_timetree(example_tree, rank = "phylum", legend_position = "bottom", add_timescale = FALSE)
  expect_s3_class(p1, "ggplot")
  p2 <- plot_timetree(example_tree, rank = "phylum", legend_position = "none", add_timescale = FALSE)
  expect_s3_class(p2, "ggplot")
})

# ==============================================================================
# 11. Self-test mode
# ==============================================================================
run("ST-001: selftest all pass", {
  expect_equal(run_rclade_selftest(), 0L)
})

# ==============================================================================
# Report output
# ==============================================================================
cat("\n")
cat(paste(rep("=", 70), collapse = ""), "\n", sep = "")
cat("  Rclade Functional Smoke Test Report\n")
cat(paste(rep("=", 70), collapse = ""), "\n\n", sep = "")

cat(sprintf("  %-50s %s\n", "Test case", "Result"))
cat(paste(rep("-", 70), collapse = ""), "\n", sep = "")
for (nm in names(results)) {
  cat(sprintf("  %-50s [%s]\n", nm, results[[nm]]))
}

cat("\n")
cat(paste(rep("=", 70), collapse = ""), "\n", sep = "")
cat(sprintf("  Total:   %d\n", total))
cat(sprintf("  Passed:  %d\n", pass))
cat(sprintf("  Failed:  %d\n", fail))
cat(sprintf("  Skipped: %d\n", skip))
cat(sprintf("  Pass rate: %.1f%%\n", (pass / total) * 100))
cat(paste(rep("=", 70), collapse = ""), "\n\n", sep = "")

if (fail > 0) {
  cat("Some tests failed; see output above.\n")
  quit(status = 1)
}
