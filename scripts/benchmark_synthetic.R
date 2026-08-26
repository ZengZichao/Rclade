#!/usr/bin/env Rscript
# Synthetic benchmark: Rclade vs. a manual ggtree collapse workflow
# Includes rendering cost (ggplotGrob) to reflect end-to-end plotting time.
# Usage: Rscript scripts/benchmark_synthetic.R [output_dir]

suppressPackageStartupMessages({
  library(Rclade)
  library(ape)
  library(ggtree)
  library(ggplot2)
  library(bench)
  library(phangorn)
})

out_dir <- commandArgs(trailingOnly = TRUE)[1]
if (is.na(out_dir)) out_dir <- "benchmark_results"
if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)

set.seed(42)

# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------

partition_tree <- function(tree, k, min_size = 2L) {
  # Split the tree recursively into up to k monophyletic groups.
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

make_taxonomy_labels <- function(tree, group_vec) {
  paste0(tree[["tip.label"]], ";d__Bacteria;p__", group_vec,
         ";c__Class;o__Order;f__Family;g__Genus;s__Species")
}

sort_by_depth <- function(groups, mrca_map, tree) {
  depths <- ape::node.depth(tree)
  d <- vapply(groups, function(g) depths[mrca_map[[g]]$node], numeric(1))
  groups[order(d, decreasing = TRUE)]
}

baseline_ggtree <- function(tree, group_vec, palette = "Set1") {
  df <- data.frame(label = tree[["tip.label"]],
                   Group = unname(group_vec), stringsAsFactors = FALSE)
  p <- ggtree(tree, layout = "rectangular", linewidth = 0.6) %<+% df

  groups <- unique(na.omit(group_vec))
  mrca_map <- list()
  root <- Ntip(tree) + 1L
  for (g in groups) {
    tips <- which(tree[["tip.label"]] %in% names(group_vec)[group_vec == g])
    if (length(tips) > 1L) {
      node <- ape::getMRCA(tree, tips)
      if (!is.null(node) && node != root) {
        mrca_map[[g]] <- list(node = node, tip_count = length(tips))
      }
    }
  }
  if (length(mrca_map) == 0L) return(p + theme_tree2())

  cols <- Rclade:::generate_colors(names(mrca_map), palette, NULL)
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
  p + theme_tree2()
}

rclade_call <- function(tree) {
  # v1.1.0 unified protocol (reviewer issue 3): default low_memory = FALSE
  # so Rclade is measured under its default configuration, matching the
  # baseline which performs no explicit garbage collection.  The explicit
  # unit is required by the fail-safe contract; rcoal() branch lengths are
  # coalescent units, so synthetic trees serve only as computational
  # workloads and are NOT evidence of geological-time correctness.
  plot_timetree(tree, rank = "phylum", unit = "Ma",
                add_timescale = TRUE, show_tip_labels = FALSE,
                color_palette = "Set1",
                legend_position = "none")
}

bench_render <- function(expr, reps) {
  # Include rendering cost in each iteration.
  bench::mark(
    ggplot2::ggplotGrob({{ expr }}),
    iterations = reps,
    check = FALSE,
    memory = FALSE,
    filter_gc = FALSE
  )
}

run_one <- function(n, reps = 5L) {
  message("\n=== n = ", n, " ===")
  tree <- ape::rcoal(n)
  group_vec <- partition_tree(tree, k = max(2L, floor(sqrt(n))))
  tree[["tip.label"]] <- make_taxonomy_labels(tree, group_vec)

  # v1.1.0 unified protocol (reviewer issue 3): one discarded warm-up run
  # per method, then randomized method order to avoid systematic
  # warm-up/session-drift bias between the two pipelines.
  invisible(suppressWarnings(ggplot2::ggplotGrob(rclade_call(tree))))
  invisible(suppressWarnings(ggplot2::ggplotGrob(baseline_ggtree(tree, group_vec, palette = "Set1"))))

  rclade_first <- sample(c(TRUE, FALSE), 1L)
  if (rclade_first) {
    rc <- bench_render(rclade_call(tree), reps = reps)
    gg <- bench_render(baseline_ggtree(tree, group_vec, palette = "Set1"), reps = reps)
  } else {
    gg <- bench_render(baseline_ggtree(tree, group_vec, palette = "Set1"), reps = reps)
    rc <- bench_render(rclade_call(tree), reps = reps)
  }

  rc_times <- as.numeric(rc$time[[1]])
  gg_times <- as.numeric(gg$time[[1]])

  list(
    n = n,
    n_groups = length(unique(na.omit(group_vec))),
    rclade_median = as.numeric(rc$median),
    rclade_mean = mean(rc_times),
    rclade_sd = if (length(rc_times) > 1L) sd(rc_times) else NA_real_,
    ggtree_median = as.numeric(gg$median),
    ggtree_mean = mean(gg_times),
    ggtree_sd = if (length(gg_times) > 1L) sd(gg_times) else NA_real_,
    rclade_min = as.numeric(rc$min),
    ggtree_min = as.numeric(gg$min),
    rclade_max = max(rc_times),
    ggtree_max = max(gg_times)
  )
}

# ------------------------------------------------------------------
# Run
# ------------------------------------------------------------------

# Unified measurement protocol (v1.1.0 revision, reviewer issue 3):
# in-session bench::mark medians, 5 replicates at EVERY scale, identical
# forcing point (ggplotGrob per iteration), discarded warm-up runs, and
# randomized method order.  Both pipelines use the default configuration
# (low_memory = FALSE; rectangular layout; mixed triangle mode).
set.seed(20260826)
sizes <- c(200L, 500L, 1000L, 2000L, 5000L, 10000L)
results <- lapply(sizes, function(n) {
  run_one(n, reps = 5L)
})

df <- do.call(rbind, lapply(results, as.data.frame))
write.csv(df, file.path(out_dir, "benchmark_synthetic_rendered.csv"), row.names = FALSE)
message("\nSynthetic benchmark (rendered) saved to ", file.path(out_dir, "benchmark_synthetic_rendered.csv"))
print(df)
