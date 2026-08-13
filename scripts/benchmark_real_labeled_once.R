#!/usr/bin/env Rscript
# Run Rclade on a real tree with embedded taxonomy labels (pipe-delimited).
# Usage: Rscript scripts/benchmark_real_labeled_once.R <tree> <rank>

suppressPackageStartupMessages(library(Rclade))
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) stop("Usage: benchmark_real_labeled_once.R <tree> <rank>")
tree_file <- args[1]
rank <- args[2]

patterns <- list(
  domain = "d__([^-]+)",
  phylum = "p__([^-]+)",
  class  = "c__([^-]+)",
  order  = "o__([^-]+)",
  family = "f__([^-]+)",
  genus  = "g__([^-]+)"
)

p <- plot_timetree(
  tree = tree_file,
  rank = rank,
  taxonomy_format = "custom_regex",
  custom_patterns = patterns,
  add_timescale = FALSE,
  show_tip_labels = FALSE,
  low_memory = TRUE,
  legend_position = "none",
  color_palette = "Set1"
)

info <- attr(p, "rclade_info")
invisible(ggplot2::ggplotGrob(p))

cat(sprintf("METRICS tips=%d groups=%d actual=%d format=%s rank=%s\n",
            info$n_tips, info$n_groups, info$actual_ntips,
            info$taxonomy_format, info$rank))
