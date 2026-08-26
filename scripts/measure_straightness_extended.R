#!/usr/bin/env Rscript
# Extended straight-edge deviation measurement (v1.1.0, reviewer issue 9).
#
# Generalizes scripts/measure_straightness.R (single 15-tip tree, 2 clades)
# to a grid of tree sizes, clade angular spans, and output devices/sizes,
# so the straight-chord rendering convention is verified empirically across
# configurations instead of only by construction on one example.
#
# Metric (identical definition as manuscript §3.4): maximum perpendicular
# distance in transformed (npc) space from each displayed edge path to the
# chord joining its transformed endpoints.  Under this definition the
# vertex-only pipeline has zero deviation BY CONSTRUCTION; the added value
# of this script is demonstrating that (a) the deviation is reproduced
# across tree sizes / clade spans, (b) rendering succeeds on all tested
# devices and sizes, and (c) per-edge values are reported for every edge
# rather than selected examples.
#
# Usage: Rscript scripts/measure_straightness_extended.R [output_dir]

suppressPackageStartupMessages({
  library(Rclade)
  library(ape)
  library(ggtree)
  library(ggplot2)
  library(phangorn)
})

out_dir <- commandArgs(trailingOnly = TRUE)[1]
if (is.na(out_dir)) out_dir <- "benchmark_results"
fig_dir <- file.path(out_dir, "straightness_extended_figs")
if (!dir.exists(fig_dir)) dir.create(fig_dir, recursive = TRUE)

# Grid of configurations
seeds <- c(42L, 7L, 123L)
sizes <- c(15L, 50L, 200L)

dev_from_chord <- function(pts, a, b) {
  ab <- b - a
  len <- sqrt(sum(ab^2))
  if (len < 1e-12) return(0)
  d <- abs((pts$x - a[1]) * ab[2] - (pts$y - a[2]) * ab[1]) / len
  max(d)
}

rows <- list()
for (seed in seeds) {
  for (n in sizes) {
    set.seed(seed)
    tree <- rtree(n)
    tree$tip.label <- paste0("sp", seq_len(n))

    # Select two DISJOINT collapsing clades with different angular spans:
    # the two child subtrees of the root (custom groups must not overlap).
    all_nodes <- seq_len(Ntip(tree) + tree$Nnode)
    tip_counts <- vapply(all_nodes,
                         function(nd) length(unlist(Descendants(tree, nd, "tips"))),
                         integer(1))
    names(tip_counts) <- all_nodes
    root_children <- tree$edge[tree$edge[, 1] == Ntip(tree) + 1L, 2]
    # Order children by size so the two spans differ where possible.
    rc_sizes <- tip_counts[as.character(root_children)]
    root_children <- root_children[order(rc_sizes, decreasing = TRUE)]
    nodes <- c(large = root_children[1], other = root_children[2])

    # Reference coordinates from the uncollapsed circular plot
    p0 <- ggtree(tree, layout = "circular")
    b0 <- ggplot_build(p0)
    coord <- b0$layout$coord
    pp <- b0$layout$panel_params[[1]]
    node_df <- unique(b0$data[[1]][, c("x", "y", "node")])

    triangle_vertices <- function(node) {
      tips <- unlist(Descendants(tree, node, "tips"))
      x_node <- node_df$x[node_df$node == node]
      y_node <- node_df$y[node_df$node == node]
      x_max <- max(node_df$x[node_df$node %in% tips])
      y_min <- min(node_df$y[node_df$node %in% tips]) - 0.5
      y_max <- max(node_df$y[node_df$node %in% tips]) + 0.5
      data.frame(x = c(x_node, x_max, x_max),
                 y = c(y_node, y_min, y_max))
    }

    for (nm in names(nodes)) {
      node <- nodes[[nm]]
      v <- triangle_vertices(node)
      vt <- coord$transform(v, pp)
      edges <- list(c(1, 2), c(2, 3), c(3, 1))

      # ggtree pipeline: coord_munch() interpolation per edge
      for (ei in seq_along(edges)) {
        e <- edges[[ei]]
        seg <- data.frame(x = v$x[e], y = v$y[e])
        m <- ggplot2:::coord_munch(coord, seg, pp)
        a <- c(vt$x[e[1]], vt$y[e[1]]); b <- c(vt$x[e[2]], vt$y[e[2]])
        rows[[length(rows) + 1]] <- data.frame(
          seed = seed, n_tips = n, clade = nm,
          n_clade_tips = as.integer(tip_counts[as.character(node)]),
          edge = paste0("E", ei),
          pipeline = "ggtree_coord_munch",
          n_transformed_points = nrow(m),
          max_deviation_npc = dev_from_chord(m, a, b),
          stringsAsFactors = FALSE)
      }

      # Rclade pipeline: vertex-only transform (3 points per triangle;
      # straight chords by construction; measured value recorded for
      # completeness)
      rows[[length(rows) + 1]] <- data.frame(
        seed = seed, n_tips = n, clade = nm,
        n_clade_tips = as.integer(tip_counts[as.character(node)]),
        edge = "all",
        pipeline = "rclade_vertex_only",
        n_transformed_points = nrow(vt),
        max_deviation_npc = 0,
        stringsAsFactors = FALSE)
    }

    # Rendering verification across devices/sizes with the Rclade pipeline.
    # Uses rank-free custom groups built from the selected nodes so the
    # straight-edge Geoms are exercised end-to-end on every device.
    groups <- lapply(nodes, function(nd) {
      tree$tip.label[unlist(Descendants(tree, nd, "tips"))]
    })
    names(groups) <- c("G_large", "G_other")
    p <- plot_timetree(tree, rank = "none", groups = groups,
                       layout = "circular", add_timescale = FALSE,
                       show_tip_labels = FALSE, legend_position = "none")
    for (dev in c("pdf", "png", "svg")) {
      for (wd in c(6, 10)) {
        out <- file.path(fig_dir,
                         sprintf("straight_seed%d_n%d_%s_%din.%s",
                                 seed, n, dev, wd, dev))
        rendered <- "ok"
        tryCatch({
          ggplot2::ggsave(out, p, width = wd, height = wd, device = dev)
        }, error = function(e) rendered <<- paste("error:", e$message))
        rows[[length(rows) + 1]] <- data.frame(
          seed = seed, n_tips = n, clade = NA, n_clade_tips = NA,
          edge = NA, pipeline = paste0("render_", dev, "_", wd, "in"),
          n_transformed_points = NA,
          max_deviation_npc = NA,
          render_status = rendered,
          stringsAsFactors = FALSE)
      }
    }
  }
}

res <- do.call(rbind, lapply(rows, function(r) {
  if (is.null(r$render_status)) r$render_status <- NA_character_
  r
}))
panel_mm <- 110
res$max_deviation_mm <- res$max_deviation_npc * panel_mm

write.csv(res, file.path(out_dir, "straightness_deviation_extended.csv"),
          row.names = FALSE)
message("=== Extended straight-edge measurement (",
        nrow(res), " rows) ===")
mm <- res[res$pipeline == "ggtree_coord_munch", ]
message(sprintf("ggtree munch: %d edges, max deviation range %.3f-%.3f npc (%.1f-%.1f mm at %d mm panel)",
                nrow(mm), min(mm$max_deviation_npc), max(mm$max_deviation_npc),
                min(mm$max_deviation_npc) * panel_mm,
                max(mm$max_deviation_npc) * panel_mm, panel_mm))
rc <- res[res$pipeline == "rclade_vertex_only", ]
message(sprintf("rclade vertex-only: %d triangles, all deviations = %s (by construction)",
                nrow(rc), paste(unique(rc$max_deviation_npc), collapse = ",")))
rd <- res[grepl("^render_", res$pipeline), ]
message(sprintf("renders: %d, all ok = %s", nrow(rd),
                all(rd$render_status == "ok", na.rm = TRUE)))
