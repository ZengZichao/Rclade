#!/usr/bin/env Rscript
# Split-cost + improved-repeat benchmark.
# Uses proc.time() for sub-second accuracy.
# All output suppressed except final results.

suppressPackageStartupMessages({
  library(Rclade)
  library(ape)
  library(ggtree)
  library(ggplot2)
  library(phangorn)
})

out_dir <- commandArgs(trailingOnly = TRUE)[1]
if (is.na(out_dir)) out_dir <- "benchmark_results"
if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)

set.seed(42)

# ------------------------------------------------------------------
# Tree building helpers
# ------------------------------------------------------------------
partition_tree <- function(tree, k, min_size = 2L) {
  n_tips <- Ntip(tree); n_nodes <- tree[["Nnode"]]
  all_nodes <- seq_len(n_tips + n_nodes)
  desc <- phangorn::Descendants(tree, all_nodes, type = "tips")
  names(desc) <- all_nodes; nodes <- list(n_tips + 1)
  while (length(nodes) < k) {
    counts <- vapply(nodes, function(nd) length(desc[[as.character(nd)]]), integer(1))
    idx <- which.max(counts); if (counts[idx] <= min_size) break
    node <- nodes[[idx]]; children <- tree[["edge"]][tree[["edge"]][,1]==node,2]
    nodes[[idx]] <- NULL; nodes <- c(nodes, as.list(children))
  }
  groups <- integer(n_tips)
  for (i in seq_along(nodes)) groups[desc[[as.character(nodes[[i]])]]] <- i
  setNames(paste0("P", groups), tree[["tip.label"]])
}
make_taxonomy_labels <- function(tree, gv) {
  paste0(tree[["tip.label"]], ";d__Bacteria;p__", gv,
         ";c__Class;o__Order;f__Family;g__Genus;s__Species")
}

build_tree <- function(n) {
  tree <- ape::rcoal(n)
  gv <- partition_tree(tree, k = max(2L, floor(sqrt(n))))
  tree[["tip.label"]] <- make_taxonomy_labels(tree, gv)
  list(tree = tree, gv = setNames(unname(gv), tree[["tip.label"]]),
       n_groups = length(unique(na.omit(gv))))
}

# ==================================================================
# 1. Split-cost at n=1000
# ==================================================================
cat("\n=== Split-cost (n=1000) ===\n")
d1k <- build_tree(1000)

# (a) detect + parse
ta <- replicate(3, {
  invisible(gc()); t0 <- proc.time()
  fmt <- Rclade::detect_taxonomy_format(d1k$tree[["tip.label"]])
  Rclade::parse_taxonomy(d1k$tree[["tip.label"]], rank = "phylum", format = fmt)
  (proc.time() - t0)[["elapsed"]]
})
cat(sprintf("(a) Parse:        %.3f ± %.3f s\n", mean(ta), sd(ta)))

# (b) MRCA + monophyly
tb <- replicate(3, {
  invisible(gc()); t0 <- proc.time()
  Rclade:::compute_mrca_map(d1k$tree, d1k$gv, check_monophyly = TRUE)
  (proc.time() - t0)[["elapsed"]]
})
cat(sprintf("(b) MRCA:         %.3f ± %.3f s\n", mean(tb), sd(tb)))

# (c) collapse + render (no timescale, no legend)
cat("(c) Collapse+render...")
tc <- replicate(3, {
  invisible(gc()); t0 <- proc.time()
  df <- data.frame(label = d1k$tree[["tip.label"]], Group = unname(d1k$gv),
                   stringsAsFactors = FALSE)
  p <- ggtree(d1k$tree, layout = "rectangular", linewidth = 0.6) %<+% df
  mm <- Rclade:::compute_mrca_map(d1k$tree, d1k$gv, check_monophyly = FALSE)
  sorted <- names(rev(sort(sapply(mm, function(x) x$tip_count))))
  for (g in sorted) {
    if (mm[[g]]$tip_count > 1)
      p <- ggtree::scaleClade(p, node = mm[[g]]$node,
              scale = 1 / mm[[g]]$tip_count, vertical_only = TRUE)
  }
  for (g in sorted) {
    if (mm[[g]]$tip_count > 1)
      p <- ggtree::collapse(p, node = mm[[g]]$node, mode = "mixed")
  }
  p <- p + theme_tree2(); ggplot2::ggplotGrob(p)
  (proc.time() - t0)[["elapsed"]]
})
cat(sprintf(" %.3f ± %.3f s\n", mean(tc), sd(tc)))

# (d) Full Rclade
cat("(d) Full Rclade...")
td <- replicate(3, {
  invisible(gc()); t0 <- proc.time()
  p <- plot_timetree(d1k$tree, rank = "phylum", unit = "Ma",
                     add_timescale = TRUE, show_tip_labels = FALSE,
                     low_memory = TRUE, color_palette = "Set1",
                     legend_position = "right")
  ggplot2::ggplotGrob(p)
  (proc.time() - t0)[["elapsed"]]
})
cat(sprintf(" %.3f ± %.3f s\n", mean(td), sd(td)))

# (e) ggtree baseline
cat("(e) ggtree baseline...")
te <- replicate(3, {
  invisible(gc()); t0 <- proc.time()
  df <- data.frame(label = d1k$tree[["tip.label"]], Group = unname(d1k$gv),
                   stringsAsFactors = FALSE)
  p <- ggtree(d1k$tree, layout = "rectangular", linewidth = 0.6) %<+% df
  groups <- unique(na.omit(d1k$gv)); mrca_map <- list()
  root <- Ntip(d1k$tree) + 1L
  for (g in groups) {
    tips <- which(d1k$tree[["tip.label"]] %in% names(d1k$gv)[d1k$gv == g])
    if (length(tips) > 1L) {
      node <- ape::getMRCA(d1k$tree, tips)
      if (!is.null(node) && node != root)
        mrca_map[[g]] <- list(node = node, tip_count = length(tips))
    }
  }
  if (length(mrca_map) > 0) {
    cols <- Rclade:::generate_colors(names(mrca_map), "Set1", NULL)
    depths <- ape::node.depth(d1k$tree)
    sorted <- names(mrca_map)[order(sapply(names(mrca_map),
              function(g) depths[mrca_map[[g]]$node]), decreasing = TRUE)]
    for (g in sorted) {
      node <- mrca_map[[g]]$node; tc <- mrca_map[[g]]$tip_count
      if (tc > 1L) p <- ggtree::scaleClade(p, node = node,
              scale = 1 / tc, vertical_only = TRUE)
    }
    for (g in sorted) {
      node <- mrca_map[[g]]$node
      fill <- grDevices::adjustcolor(cols[g], alpha.f = 0.3)
      p <- ggtree::collapse(p, node = node, mode = "mixed", fill = fill, color = cols[g])
    }
  }
  p <- p + theme_tree2(); ggplot2::ggplotGrob(p)
  (proc.time() - t0)[["elapsed"]]
})
cat(sprintf(" %.3f ± %.3f s\n", mean(te), sd(te)))

cat(sprintf("\nRclade/ggtree: %.1f×  |  Overhead: %.2f s  |  Parse+MRCA: %.2f s  |  Timescale+legend: %.2f s\n",
    mean(td)/mean(te), mean(td)-mean(te), mean(ta)+mean(tb), mean(td)-mean(tc)))

sc <- data.frame(
  stage = c("a_detect_parse", "b_mrca_monophyly", "c_collapse_render",
            "d_full_rclade", "e_ggtree_baseline"),
  mean_s = c(mean(ta), mean(tb), mean(tc), mean(td), mean(te)),
  sd_s = c(sd(ta), sd(tb), sd(tc), sd(td), sd(te)),
  stringsAsFactors = FALSE
)
sc$pct <- round(100 * sc$mean_s / mean(td), 1)
write.csv(sc, file.path(out_dir, "benchmark_split_cost_1000.csv"), row.names = FALSE)

# ==================================================================
# 2. Improved repeats: n=200,1000 with 5 reps each
# ==================================================================
cat("\n=== Improved repeats (5 reps) ===\n")

run_at <- function(n) {
  d <- build_tree(n)
  cat(sprintf("\nn=%d (%d groups):  ", n, d$n_groups))

  rc <- replicate(5, {
    invisible(gc()); t0 <- proc.time()
    p <- plot_timetree(d$tree, rank = "phylum", unit = "Ma",
                       add_timescale = TRUE, show_tip_labels = FALSE,
                       low_memory = TRUE, color_palette = "Set1",
                       legend_position = "right")
    ggplot2::ggplotGrob(p)
    (proc.time() - t0)[["elapsed"]]
  })

  gg <- replicate(5, {
    invisible(gc()); t0 <- proc.time()
    df <- data.frame(label = d$tree[["tip.label"]], Group = unname(d$gv),
                     stringsAsFactors = FALSE)
    p <- ggtree(d$tree, layout = "rectangular", linewidth = 0.6) %<+% df
    groups <- unique(na.omit(d$gv)); mrca_map <- list()
    root <- Ntip(d$tree) + 1L
    for (g in groups) {
      tips <- which(d$tree[["tip.label"]] %in% names(d$gv)[d$gv == g])
      if (length(tips) > 1L) {
        node <- ape::getMRCA(d$tree, tips)
        if (!is.null(node) && node != root)
          mrca_map[[g]] <- list(node = node, tip_count = length(tips))
      }
    }
    if (length(mrca_map) > 0) {
      cols <- Rclade:::generate_colors(names(mrca_map), "Set1", NULL)
      depths <- ape::node.depth(d$tree)
      sorted <- names(mrca_map)[order(sapply(names(mrca_map),
                function(g) depths[mrca_map[[g]]$node]), decreasing = TRUE)]
      for (g in sorted) {
        node <- mrca_map[[g]]$node; tc <- mrca_map[[g]]$tip_count
        if (tc > 1L) p <- ggtree::scaleClade(p, node = node,
                scale = 1 / tc, vertical_only = TRUE)
      }
      for (g in sorted) {
        node <- mrca_map[[g]]$node
        fill <- grDevices::adjustcolor(cols[g], alpha.f = 0.3)
        p <- ggtree::collapse(p, node = node, mode = "mixed", fill = fill, color = cols[g])
      }
    }
    p <- p + theme_tree2(); ggplot2::ggplotGrob(p)
    (proc.time() - t0)[["elapsed"]]
  })

  cat(sprintf("Rclade %.2f±%.2fs  ggtree %.2f±%.2fs  ratio %.2fx",
              mean(rc), sd(rc), mean(gg), sd(gg), mean(rc)/mean(gg)))
  data.frame(n = n, n_groups = d$n_groups, n_reps = 5L,
             rclade_mean = mean(rc), rclade_sd = sd(rc),
             ggtree_mean = mean(gg), ggtree_sd = sd(gg),
             ratio = mean(rc)/mean(gg), stringsAsFactors = FALSE)
}

r200  <- run_at(200)
r1000 <- run_at(1000)

improved <- rbind(r200, r1000)
write.csv(improved, file.path(out_dir, "benchmark_improved_repeats.csv"), row.names = FALSE)
cat("\n\nDone.\n")
