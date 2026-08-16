# Performance regression tests for Rclade
#
# DESIGN INTENT: These tests are a CATASTROPHIC / ORDER-OF-MAGNITUDE regression
# safety net, NOT a fine-grained performance gate.  The TOLERANCE multiplier (3x)
# is deliberately generous because shared CI runners exhibit substantial timing
# jitter.  A test failure here means something broke by 3x or more — e.g., an
# accidental O(n^2) rewrite — not that a 20% slowdown occurred.  Do not tighten
# these thresholds expecting precision benchmarking; use bench::mark or
# scripts/benchmark_synthetic.R for that purpose.
#
# These tests ensure that key operations don't degrade in performance over time.
# They use a threshold-based approach: if an operation takes more than X times
# the baseline, the test fails.

library(testthat)
library(Rclade)

# covr instrumentation inserts tracing probes into every function call,
# slowing code by 10-50x with per-call overhead that is NOT uniform across
# tree sizes. That makes every threshold/ratio assertion in this file
# meaningless (observed: MRCA max/min ratio > 5 under covr while the same
# suite passes clean R CMD check). Performance gates are the job of the
# R-CMD-check workflow, so skip the whole file under coverage.
skip_on_covr <- function() {
  if (requireNamespace("covr", quietly = TRUE) && covr::in_covr()) {
    skip("Performance tests are meaningless under covr instrumentation")
  }
}

# Baseline thresholds (in seconds) - adjust based on CI environment
BASELINE_THRESHOLDS <- list(
  small_tree_render = 5,    # ~100 tips
  medium_tree_render = 15,   # ~1000 tips
  large_tree_render = 60,    # ~5000 tips
  taxonomy_parse = 2,        # per 1000 tips
  mrca_compute = 3,          # per 1000 tips
  collapse = 5               # per 1000 tips
)

# Tolerance multiplier (e.g., 3x baseline is acceptable)
TOLERANCE <- 3

#' Generate a random phylogenetic tree with n tips
#' @keywords internal
generate_test_tree <- function(n_tips, seed = 42) {
  set.seed(seed)
  tree <- ape::rtree(n_tips)
  # Make it ultrametric for time tree testing
  tree <- ape::chronoMPL(tree)
  # Clamp negative branch lengths (chronoMPL can produce them)
  tree$edge.length[tree$edge.length < 0] <- 0.001
  tree$tip.label <- paste0("tip_", seq_len(n_tips), "_d_Bacteria_p_Proteobacteria_c_Gammaproteobacteria_o_Pseudomonadales_f_Pseudomonadaceae_g_Pseudomonas_s_aeruginosa")
  tree
}

test_that("Small tree rendering performance is within threshold", {
  skip_on_cran()
  skip_on_covr()
  tree <- generate_test_tree(100)
  
  elapsed <- system.time({
    p <- suppressWarnings(plot_timetree(tree, rank = "phylum", add_timescale = FALSE))
  })["elapsed"]

  threshold <- BASELINE_THRESHOLDS$small_tree_render * TOLERANCE
  expect_lt(elapsed, threshold,
            sprintf("Small tree rendering took %.2fs (threshold: %.2fs)", elapsed, threshold))
})

test_that("Medium tree rendering performance is within threshold", {
  skip_on_cran()
  skip_on_covr()
  tree <- generate_test_tree(500)
  
  elapsed <- system.time({
    p <- suppressWarnings(plot_timetree(tree, rank = "phylum", add_timescale = FALSE))
  })["elapsed"]

  threshold <- BASELINE_THRESHOLDS$medium_tree_render * TOLERANCE
  expect_lt(elapsed, threshold,
            sprintf("Medium tree rendering took %.2fs (threshold: %.2fs)", elapsed, threshold))
})

test_that("Taxonomy parsing performance scales linearly", {
  skip_on_cran()
  skip_on_covr()

  # Timing block strategy: a single parse of 250-2000 labels is sub-millisecond,
  # far below system.time() resolution, so max/min per-tip ratios are pure
  # quantization noise (observed 8x with identical code). Instead, time a block
  # of enough repeats to reach >= ~100 ms per size, then divide by reps.
  sizes <- c(250, 500, 1000, 2000)
  times <- numeric(length(sizes))

  for (i in seq_along(sizes)) {
    labels <- generate_test_tree(sizes[i])$tip.label
    # Warm-up
    invisible(parse_taxonomy_with_file(labels, "phylum"))
    # Calibrate reps so each block measurement is well above clock resolution
    t1 <- system.time(invisible(parse_taxonomy_with_file(labels, "phylum")))["elapsed"]
    n_reps <- max(10L, ceiling(0.1 / max(t1, 0.001)))
    elapsed <- system.time(
      for (r in seq_len(n_reps)) invisible(parse_taxonomy_with_file(labels, "phylum"))
    )["elapsed"]
    times[i] <- elapsed / n_reps
  }

  # Check that time per tip is roughly constant (within 5x factor)
  time_per_tip <- times / sizes
  ratio <- max(time_per_tip) / min(time_per_tip)
  expect_lt(if (is.nan(ratio) || is.infinite(ratio)) 0 else ratio, 5,
            sprintf("Taxonomy parsing does not scale linearly with tip count (max/min ratio = %.2f)", ratio))
})

test_that("MRCA computation performance scales linearly", {
  skip_on_cran()
  skip_on_covr()

  # See taxonomy-parsing test above: a single call is sub-millisecond, so time
  # a calibrated block of repeats (>= ~100 ms per size) instead of one call,
  # which makes the max/min per-tip ratio pure clock-quantization noise.
  sizes <- c(250, 500, 1000, 2000)
  times <- numeric(length(sizes))

  for (i in seq_along(sizes)) {
    tree <- generate_test_tree(sizes[i])
    taxa <- parse_taxonomy_with_file(tree$tip.label, "phylum")
    group_vec <- setNames(taxa$Group, taxa$label)

    # Warm-up: first call pays JIT/namespace/lazy-load costs that are not
    # representative of steady-state scaling.
    invisible(suppressWarnings(
      compute_mrca_map(tree, group_vec, check_monophyly = TRUE)
    ))

    t1 <- system.time(suppressWarnings(
      compute_mrca_map(tree, group_vec, check_monophyly = TRUE)
    ))["elapsed"]
    n_reps <- max(10L, ceiling(0.1 / max(t1, 0.001)))
    elapsed <- system.time(
      for (r in seq_len(n_reps)) {
        invisible(suppressWarnings(compute_mrca_map(tree, group_vec, check_monophyly = TRUE)))
      }
    )["elapsed"]
    times[i] <- elapsed / n_reps
  }

  time_per_tip <- times / sizes
  ratio <- max(time_per_tip) / min(time_per_tip)
  expect_lt(if (is.nan(ratio) || is.infinite(ratio)) 0 else ratio, 5,
            sprintf("MRCA computation does not scale linearly with tip count (max/min ratio = %.2f)", ratio))
})

test_that("Memory usage is reasonable for large trees", {
  skip_on_cran()
  skip_on_covr()

  tree <- generate_test_tree(2000)

  # Use gc() to measure memory before and after
  gc(reset = TRUE)
  p <- suppressWarnings(plot_timetree(tree, rank = "phylum", add_timescale = FALSE, low_memory = TRUE))
  mem <- gc()

  # gc() returns a matrix: rows = Ncells, Vcells; columns include (Mb)
  # Use the last (Mb) column which corresponds to "max used"
  mb_cols <- which(colnames(mem) == "(Mb)")
  peak_mb <- sum(as.numeric(mem[, tail(mb_cols, 1)]))
  expect_lt(peak_mb, 500,
            sprintf("Peak memory usage: %.1f MB (threshold: 500 MB)", peak_mb))
})

test_that("Batch processing performance scales with tree count", {
  skip_on_cran()
  skip_on_covr()
  
  # Create a multiPhylo object with 3 trees
  trees <- lapply(1:3, function(i) generate_test_tree(100, seed = i))
  class(trees) <- "multiPhylo"
  
  elapsed <- system.time({
    plots <- suppressWarnings(plot_timetree(trees, rank = "phylum", add_timescale = FALSE))
  })["elapsed"]
  
  # Should not take more than 3x single tree + overhead
  threshold <- BASELINE_THRESHOLDS$small_tree_render * TOLERANCE * 3 * 1.5
  expect_lt(elapsed, threshold,
            sprintf("Batch processing took %.2fs (threshold: %.2fs)", elapsed, threshold))
})
