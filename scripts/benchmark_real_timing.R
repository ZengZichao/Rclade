#!/usr/bin/env Rscript
# Real-data in-session timing for Rclade (manuscript Table 4, ar53).
#
# Records bench::mark median/min/max over `iterations` runs of plot_timetree()
# on a REAL tree file. Process-level wall-clock / peak RSS is captured
# SEPARATELY by the shell wrapper `/usr/bin/time -l` (see 基准测试完整流程.md
# Step 1c); this script only measures the in-session (already-loaded) cost.
#
# The plot_timetree() call mirrors scripts/benchmark_real_once.R exactly so the
# timing reflects the same code path used to print METRICS.
#
# Usage: Rscript scripts/benchmark_real_timing.R <tree> <taxonomy> <rank> [out_csv]
#   <tree>      Newick file (real data, e.g. ar53_r232.tree)
#   <taxonomy>  taxonomy TSV (no header; col1=label, col2=d__...;p__... lineage)
#   <rank>      target rank, e.g. phylum
#   [out_csv]   output CSV (default benchmark_results/ar53_benchmark.csv)

suppressPackageStartupMessages({
  library(Rclade)
  library(bench)
})

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 3) {
  stop("Usage: benchmark_real_timing.R <tree> <taxonomy> <rank> [out_csv]")
}
tree_file <- args[1]
tax_file  <- args[2]
rank      <- args[3]
out_csv   <- if (length(args) >= 4) args[4] else "benchmark_results/ar53_benchmark.csv"

iterations <- 5L

build_plot <- function() {
  plot_timetree(
    tree = tree_file,
    rank = rank,
    taxonomy_format = "GTDB",
    taxonomy_file = tax_file,
    taxonomy_file_header = FALSE,
    add_timescale = FALSE,
    show_tip_labels = FALSE,
    legend_position = "none",
    color_palette = "Set1"
  )
}

# v1.1.0 unified protocol (reviewer issue 3): the timed expression is the
# FULLY RENDERED output (plot construction + grob build) on every
# iteration, identical to the synthetic benchmark boundary; default
# configuration (low_memory = FALSE); 5 replicates.
build_rendered <- function() {
  ggplot2::ggplotGrob(build_plot())
}

# One exploratory run to capture structural info (does not bias the median,
# which is computed over `iterations` independent runs inside bench::mark).
p0 <- build_plot()
info <- attr(p0, "rclade_info")
invisible(ggplot2::ggplotGrob(p0))   # warm-up render

gc(verbose = FALSE)
bm <- bench::mark(build_rendered(), iterations = iterations,
                  check = FALSE, memory = FALSE, filter_gc = FALSE)

# bench::mark does not expose a `max` summary column; derive min/max from the
# raw per-iteration timings (bench_time vector in bm$time[[1]]).
times <- as.numeric(bm$time[[1]])

res <- data.frame(
  rank = rank,
  n_tips = info$n_tips,
  n_groups = info$n_groups,
  groups_total = info$groups_total,
  groups_collapsed = info$groups_collapsed,
  groups_singleton = info$groups_singleton,
  groups_skipped_non_monophyletic = info$groups_skipped_non_monophyletic,
  groups_skipped_other = info$groups_skipped_other,
  in_session_median_s = as.numeric(bm$median),
  in_session_min_s    = min(times),
  in_session_max_s    = max(times),
  iterations = iterations,
  stringsAsFactors = FALSE
)

write.csv(res, out_csv, row.names = FALSE)
cat(sprintf(paste0("in_session_median_s=%.3f min=%.3f max=%.3f rank=%s tips=%d ",
                   "total=%d collapsed=%d singleton=%d skipped_nm=%d skipped_other=%d\n"),
            res$in_session_median_s, res$in_session_min_s, res$in_session_max_s,
            rank, res$n_tips, res$groups_total, res$groups_collapsed,
            res$groups_singleton, res$groups_skipped_non_monophyletic,
            res$groups_skipped_other))
cat("Saved ->", out_csv, "\n")
