#!/usr/bin/env Rscript
# ============================================================
# Baseline Manual Workflow for Phylogenetic Tree Visualization
# ============================================================
# This script demonstrates the traditional multi-package approach
# to semicolon-delimited taxonomy tree collapsing with geological
# timescale, equivalent to Rclade's single plot_timetree() call.
#
# Purpose: Supplementary File S8 — provides a fair, complete,
# runnable baseline for benchmark comparison.
#
# Equivalent Rclade call:
#   plot_timetree("tree.nwk", rank = "phylum", taxonomy_format = "GTDB",
#                 add_timescale = TRUE, unit = "Ma")
# ============================================================

library(ape)
library(ggtree)
library(ggplot2)
library(deeptime)
library(viridisLite)

# ---- 1. Read tree ----
tree <- read.tree("tree.nwk")
labels <- tree$tip.label

# ---- 2. Parse taxonomy (extract phylum from "d__X;p__Y;c__Z" labels) ----
parse_phylum <- function(lab) {
  m <- regmatches(lab, regexec("p__([^;]+)", lab))[[1]]
  if (length(m) >= 2) m[2] else NA_character_
}
phylum_vec <- vapply(labels, parse_phylum, character(1))

# ---- 3. Build group vector and compute MRCAs ----
unique_phyla <- unique(na.omit(phylum_vec))
mrca_list <- list()
for (phy in unique_phyla) {
  tips_in_group <- labels[phylum_vec == phy & !is.na(phylum_vec)]
  if (length(tips_in_group) >= 2) {
    mrca_node <- getMRCA(tree, tips_in_group)
    if (!is.null(mrca_node)) {
      mrca_list[[phy]] <- list(node = mrca_node, n = length(tips_in_group))
    }
  }
}

# ---- 4. (Optional) Monophyly check ----
for (phy in names(mrca_list)) {
  tips_in_group <- labels[phylum_vec == phy & !is.na(phylum_vec)]
  is_mono <- is.monophyletic(tree, tips_in_group)
  if (!is_mono) warning(paste("Non-monophyletic:", phy))
}

# ---- 5. Generate color palette ----
n_groups <- length(mrca_list)
colors <- setNames(viridis(n_groups), names(mrca_list))

# ---- 6. Render tree with ggtree ----
p <- ggtree(tree, ladderize = TRUE)

# ---- 7. Collapse each clade ----
# Note: mode="mixed" is ggtree::collapse() default, representing typical user behavior.
# Rclade forces mode="max" in circular layouts for correct polar-coordinate geometry.
for (phy in names(mrca_list)) {
  node_id <- mrca_list[[phy]]$node
  fill_col <- adjustcolor(colors[phy], alpha.f = 0.3)
  p <- ggtree::collapse(p, node = node_id, mode = "mixed",
                         fill = fill_col, color = colors[phy])
}

# ---- 8. Add color legend via dummy scale ----
p <- p + scale_fill_manual(
  name = "Phylum",
  values = setNames(adjustcolor(colors, alpha.f = 0.3), names(colors)),
  guide = guide_legend(override.aes = list(alpha = 1))
)

# ---- 9. Add geological timescale via deeptime ----
p <- ggtree::revts(p)
p <- p + deeptime::coord_geo(
  dat = list("eons", "eras"),
  pos = list("bottom", "bottom"),
  xlim = c(-max(node.depth.edgelength(tree)), 0),
  ylim = c(0, Ntip(tree) + 1),
  neg = TRUE, abbrv = TRUE,
  height = grid::unit(1.5, "line")
)

# ---- 10. Theme and legend adjustments ----
p <- p + theme(
  legend.position = "bottom",
  legend.title = element_text(face = "bold"),
  plot.margin = margin(t = 10, r = 10, b = 5, l = 10, unit = "pt")
) + labs(x = "Time (Ma)")

# ---- 11. Save output ----
ggsave("output_baseline.pdf", p, width = 14, height = 10)

cat("Baseline workflow complete. Lines of code (excluding comments): ~60\n")
