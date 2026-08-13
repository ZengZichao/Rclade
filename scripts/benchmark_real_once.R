#!/usr/bin/env Rscript
# Run Rclade on a real tree with external taxonomy file and report key metrics.
# Usage: Rscript scripts/benchmark_real_once.R <tree> <taxonomy> <rank>

suppressPackageStartupMessages(library(Rclade))
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 3) stop("Usage: benchmark_real_once.R <tree> <taxonomy> <rank>")
tree_file <- args[1]
tax_file <- args[2]
rank <- args[3]

p <- plot_timetree(
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

info <- attr(p, "rclade_info")
# Force rendering
invisible(ggplot2::ggplotGrob(p))

cat(sprintf("METRICS tips=%d groups=%d actual=%d format=%s rank=%s\n",
            info$n_tips, info$n_groups, info$actual_ntips,
            info$taxonomy_format, info$rank))
