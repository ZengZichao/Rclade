#!/usr/bin/env Rscript
# Run Rclade on a real tree with external taxonomy file and report key metrics.
# Usage: Rscript scripts/benchmark_real_once.R <tree> <taxonomy> <rank>

suppressPackageStartupMessages(library(Rclade))
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 3) stop("Usage: benchmark_real_once.R <tree> <taxonomy> <rank>")
tree_file <- args[1]
tax_file <- args[2]
rank <- args[3]

# v1.1.0 unified protocol (reviewer issue 3): default configuration
# (low_memory = FALSE); full render forced so process-level wall time
# matches the in-session measurement boundary.
p <- plot_timetree(
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

info <- attr(p, "rclade_info")
# Force rendering
invisible(ggplot2::ggplotGrob(p))

cat(sprintf(paste0("METRICS tips=%d groups=%d total=%d collapsed=%d ",
                   "singleton=%d skipped_nm=%d skipped_other=%d actual=%d ",
                   "format=%s rank=%s\n"),
            info$n_tips, info$n_groups, info$groups_total,
            info$groups_collapsed, info$groups_singleton,
            info$groups_skipped_non_monophyletic, info$groups_skipped_other,
            info$actual_ntips, info$taxonomy_format, info$rank))
