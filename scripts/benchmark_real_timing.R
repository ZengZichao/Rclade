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

iterations <- 3L

build_plot <- function() {
  plot_timetree(
    tree = tree_file,
    rank = rank,
    taxonomy_format = "GTDB",
    taxonomy_file = tax_file,
    taxonomy_file_header = FALSE,
    add_timescale = FALSE,
    show_tip_labels = FALSE,
    low_memory = TRUE,
    legend_position = "none",
    color_palette = "Set1"
  )
}

# One exploratory run to capture structural info (does not bias the median,
# which is computed over `iterations` independent runs inside bench::mark).
p0 <- build_plot()
info <- attr(p0, "rclade_info")
invisible(ggplot2::ggplotGrob(p0))   # force a full render once

bm <- bench::mark(build_plot(), iterations = iterations,
                  check = FALSE, memory = FALSE, filter_gc = FALSE)

# bench::mark does not expose a `max` summary column; derive min/max from the
# raw per-iteration timings (bench_time vector in bm$time[[1]]).
times <- as.numeric(bm$time[[1]])

res <- data.frame(
  rank = rank,
  n_tips = info$n_tips,
  n_groups = info$n_groups,
  in_session_median_s = as.numeric(bm$median),
  in_session_min_s    = min(times),
  in_session_max_s    = max(times),
  iterations = iterations,
  stringsAsFactors = FALSE
)

write.csv(res, out_csv, row.names = FALSE)
cat(sprintf("in_session_median_s=%.3f min=%.3f max=%.3f rank=%s tips=%d groups=%d\n",
            res$in_session_median_s, res$in_session_min_s, res$in_session_max_s,
            rank, res$n_tips, res$n_groups))
cat("Saved ->", out_csv, "\n")
