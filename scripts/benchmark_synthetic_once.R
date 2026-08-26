#!/usr/bin/env Rscript
# Run a single synthetic benchmark configuration (for external timing/memory).
# Usage: Rscript scripts/benchmark_synthetic_once.R <n> <method> [seed]

suppressPackageStartupMessages({
  library(Rclade)
  library(ape)
  library(ggtree)
  library(ggplot2)
  library(phangorn)
})

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) stop("Usage: benchmark_synthetic_once.R <n> <method> [seed]")
n <- as.integer(args[1])
method <- match.arg(args[2], c("rclade", "ggtree"))
seed <- if (length(args) >= 3) as.integer(args[3]) else 42L

set.seed(seed)

partition_tree <- function(tree, k, min_size = 2L) {
  n_tips <- Ntip(tree)
  n_nodes <- tree[["Nnode"]]
  all_nodes <- seq_len(n_tips + n_nodes)
  desc <- phangorn::Descendants(tree, all_nodes, type = "tips")
  names(desc) <- all_nodes

  nodes <- list(n_tips + 1)
  while (length(nodes) < k) {
    counts <- vapply(nodes, function(nd) length(desc[[as.character(nd)]]), integer(1))
    idx <- which.max(counts)
    if (counts[idx] <= min_size) break
    node <- nodes[[idx]]
    children <- tree[["edge"]][tree[["edge"]][, 1] == node, 2]
    nodes[[idx]] <- NULL
    nodes <- c(nodes, as.list(children))
  }

  groups <- integer(n_tips)
  for (i in seq_along(nodes)) {
    groups[desc[[as.character(nodes[[i]])]]] <- i
  }
  setNames(paste0("P", groups), tree[["tip.label"]])
}

sort_by_depth <- function(groups, mrca_map, tree) {
  depths <- ape::node.depth(tree)
  d <- vapply(groups, function(g) depths[mrca_map[[g]]$node], numeric(1))
  groups[order(d, decreasing = TRUE)]
}

tree <- ape::rcoal(n)
group_vec <- partition_tree(tree, k = max(2L, floor(sqrt(n))))
tree[["tip.label"]] <- paste0(tree[["tip.label"]], ";d__Bacteria;p__", group_vec,
                              ";c__Class;o__Order;f__Family;g__Genus;s__Species")

if (method == "rclade") {
  # v1.1.0 unified protocol (reviewer issue 3): default configuration
  # (low_memory = FALSE) so process-level numbers are comparable with the
  # in-session benchmark and with the unmodified baseline.
  p <- plot_timetree(tree, rank = "phylum", unit = "Ma",
                     add_timescale = TRUE, show_tip_labels = FALSE,
                     color_palette = "Set1",
                     legend_position = "none")
} else {
  df <- data.frame(label = tree[["tip.label"]], Group = unname(group_vec), stringsAsFactors = FALSE)
  p <- ggtree(tree, layout = "rectangular", linewidth = 0.6) %<+% df
  groups <- unique(na.omit(group_vec))
  mrca_map <- list()
  root <- Ntip(tree) + 1L
  for (g in groups) {
    tips <- which(tree[["tip.label"]] %in% names(group_vec)[group_vec == g])
    if (length(tips) > 1L) {
      node <- ape::getMRCA(tree, tips)
      if (!is.null(node) && node != root) mrca_map[[g]] <- list(node = node, tip_count = length(tips))
    }
  }
  if (length(mrca_map) > 0L) {
    cols <- Rclade:::generate_colors(names(mrca_map), "Set1", NULL)
    sorted <- sort_by_depth(names(mrca_map), mrca_map, tree)
    for (g in sorted) {
      node <- mrca_map[[g]]$node
      tc <- mrca_map[[g]]$tip_count
      if (tc > 1L) p <- ggtree::scaleClade(p, node = node, scale = 1 / tc, vertical_only = TRUE)
    }
    for (g in sorted) {
      node <- mrca_map[[g]]$node
      fill <- grDevices::adjustcolor(cols[g], alpha.f = 0.3)
      p <- ggtree::collapse(p, node = node, mode = "mixed", fill = fill, color = cols[g])
    }
  }
  p <- p + theme_tree2()
}

# Force plot build to account for rendering cost
invisible(ggplot2::ggplotGrob(p))
message(method, " n=", n, " done")
