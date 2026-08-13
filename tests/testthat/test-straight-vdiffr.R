# Visual regression tests for straight-edge rendering (vdiffr).
# These snapshot tests guard the circular-layout straight-edge rendering of
# collapsed triangles (manuscript §2.7) against regressions caused by
# ggplot2/ggtree updates.

snap_dir <- file.path("tests", "testthat", "_snaps")
skip_if_missing_snapshots <- function() {
  if (!dir.exists(snap_dir) || length(list.files(snap_dir, pattern = "\\.png$")) == 0) {
    skip("vdiffr snapshot directory is empty or missing – generate snapshots first with testthat::snapshot_review()")
  }
}

test_that("circular collapsed triangles render straight edges (snapshot)", {
  skip_if_not_installed("vdiffr")
  skip_on_cran()
  skip_if_not_installed("phangorn")
  skip_if_missing_snapshots()

  set.seed(42)
  tree <- ape::rtree(15)
  tree$tip.label <- paste0("sp", seq_len(15))
  desc_a <- tree$tip.label[unlist(phangorn::Descendants(tree, 23, "tips"))]
  desc_b <- tree$tip.label[unlist(phangorn::Descendants(tree, 28, "tips"))]

  p <- plot_timetree(
    tree,
    groups = list(Group_A = desc_a, Group_B = desc_b),
    layout = "circular",
    add_timescale = FALSE,
    show_tip_labels = FALSE,
    legend_position = "none"
  )
  vdiffr::expect_doppelganger("circular-straight-edge-collapse", p)
})

test_that("rectangular collapsed triangles render (snapshot)", {
  skip_if_not_installed("vdiffr")
  skip_on_cran()
  skip_if_not_installed("phangorn")
  skip_if_missing_snapshots()

  set.seed(42)
  tree <- ape::rtree(15)
  tree$tip.label <- paste0("sp", seq_len(15))
  desc_a <- tree$tip.label[unlist(phangorn::Descendants(tree, 23, "tips"))]

  p <- plot_timetree(
    tree,
    groups = list(Group_A = desc_a),
    layout = "rectangular",
    add_timescale = FALSE,
    show_tip_labels = FALSE,
    legend_position = "none"
  )
  vdiffr::expect_doppelganger("rectangular-collapse", p)
})
