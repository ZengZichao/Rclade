# Tests for legend-smart.R

test_that("compute_legend_layout handles horizontal position", {
  layout <- Rclade:::compute_legend_layout(12, "top", nrow = NULL, ncol = NULL)
  expect_true(layout$nrow >= 1)
  expect_true(layout$ncol >= 1)
  expect_true(layout$nrow * layout$ncol >= 12)
})

test_that("compute_legend_layout handles vertical position", {
  layout <- Rclade:::compute_legend_layout(12, "right", nrow = NULL, ncol = NULL)
  expect_true(layout$nrow >= 1)
  expect_true(layout$ncol >= 1)
  expect_true(layout$nrow * layout$ncol >= 12)
})

test_that("compute_legend_layout handles inside position", {
  layout <- Rclade:::compute_legend_layout(9, "inside", nrow = NULL, ncol = NULL)
  expect_equal(layout$ncol, 3)
  expect_equal(layout$nrow, 3)
})

test_that("compute_legend_layout respects user nrow", {
  layout <- Rclade:::compute_legend_layout(10, "right", nrow = 2, ncol = NULL)
  expect_equal(layout$nrow, 2)
  expect_equal(layout$ncol, 5)
})

test_that("compute_legend_layout respects user ncol", {
  layout <- Rclade:::compute_legend_layout(10, "top", nrow = NULL, ncol = 3)
  expect_equal(layout$ncol, 3)
  expect_equal(layout$nrow, 4)
})

test_that("compute_legend_layout warns when nrow*ncol < n_groups", {
  # E-T3: warnings routed through log_warning() (emitted via message()).
  # Scope the option so it cannot leak into later tests (after fix A the logger
  # actually honours rclade.log_level, so a global set would suppress INFO
  # messages elsewhere in the suite).
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(
      Rclade:::compute_legend_layout(20, "right", nrow = 2, ncol = 3)
    )
    expect_true(grepl("insufficient", msgs, fixed = TRUE))
  })
})

test_that("compute_legend_layout handles zero groups", {
  layout <- Rclade:::compute_legend_layout(0, "right", nrow = NULL, ncol = NULL)
  expect_equal(layout$nrow, 0)
  expect_equal(layout$ncol, 0)
})

test_that("compute_legend_layout handles single group", {
  layout <- Rclade:::compute_legend_layout(1, "right", nrow = NULL, ncol = NULL)
  expect_equal(layout$nrow, 1)
  expect_equal(layout$ncol, 1)
})

test_that("add_smart_legend returns ggplot", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  p <- ggtree::ggtree(tree)
  colors <- c(G1 = "#FF0000", G2 = "#0000FF")
  result <- Rclade:::add_smart_legend(p, colors, "Phylum", "right", NULL, NULL)
  expect_s3_class(result, "ggplot")
})

test_that("add_smart_legend handles position = none", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  p <- ggtree::ggtree(tree)
  colors <- c(G1 = "#FF0000")
  result <- Rclade:::add_smart_legend(p, colors, "Phylum", "none", NULL, NULL)
  expect_s3_class(result, "ggplot")
})

test_that("add_smart_legend handles numeric position", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  p <- ggtree::ggtree(tree)
  colors <- c(G1 = "#FF0000", G2 = "#0000FF")
  result <- Rclade:::add_smart_legend(p, colors, "Phylum", c(0.5, 0.5), NULL, NULL)
  expect_s3_class(result, "ggplot")
})

test_that("split_legend requires cowplot and patchwork", {
  skip_if_not_installed("cowplot")
  skip_if_not_installed("patchwork")
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  p <- ggtree::ggtree(tree)
  colors <- c(G1 = "#FF0000", G2 = "#0000FF")
  p <- Rclade:::add_smart_legend(p, colors, "Phylum", "right", NULL, NULL)
  result <- split_legend(p, ncol_split = 1)
  expect_true(inherits(result, "ggplot") || inherits(result, "patchwork"))
})
