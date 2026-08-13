# Tests for support-labels.R

test_that("add_support_labels skips when no node data", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  p <- ggtree::ggtree(tree)
  expect_message(
    result <- Rclade:::add_support_labels(p, tree, threshold = 0.9),
    "No node annotations"
  )
  expect_s3_class(result, "ggplot")
})

test_that("add_support_labels skips when no support column", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$node.data <- data.frame(node = 3, unrelated_col = "x",
                               stringsAsFactors = FALSE)
  p <- ggtree::ggtree(tree)
  expect_message(
    result <- Rclade:::add_support_labels(p, tree, threshold = 0.9),
    "No support annotation"
  )
  expect_s3_class(result, "ggplot")
})

test_that("add_hpd_range skips when no node data", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  p <- ggtree::ggtree(tree)
  expect_message(
    result <- Rclade:::add_hpd_range(p, tree, color = "firebrick"),
    "No node annotations"
  )
  expect_s3_class(result, "ggplot")
})

test_that("add_hpd_range skips when no HPD column", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$node.data <- data.frame(node = 3, unrelated_col = "x",
                               stringsAsFactors = FALSE)
  p <- ggtree::ggtree(tree)
  expect_message(
    result <- Rclade:::add_hpd_range(p, tree),
    "No HPD annotation"
  )
  expect_s3_class(result, "ggplot")
})

test_that("add_hpd_range skips when no node column", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$node.data <- data.frame(HPD_lower = 0.5, HPD_upper = 1.5,
                               stringsAsFactors = FALSE)
  p <- ggtree::ggtree(tree)
  expect_message(
    result <- Rclade:::add_hpd_range(p, tree),
    "No 'node' column"
  )
  expect_s3_class(result, "ggplot")
})

test_that("add_hpd_range skips when all HPD values are NA", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$node.data <- data.frame(node = 3, HPD = I(list(NA)),
                               stringsAsFactors = FALSE)
  p <- ggtree::ggtree(tree)
  expect_message(
    result <- Rclade:::add_hpd_range(p, tree),
    "All HPD values are missing"
  )
  expect_s3_class(result, "ggplot")
})
