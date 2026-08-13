# Tests for custom-groups.R

test_that("validate_custom_groups accepts valid monophyletic groups", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  groups <- list(G1 = c("A", "B"), G2 = c("C", "D"))
  expect_silent(validate_custom_groups(tree, groups))
})

test_that("validate_custom_groups rejects unnamed list", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  groups <- list(c("A", "B"), c("C", "D"))
  expect_error(validate_custom_groups(tree, groups), "named list")
})

test_that("validate_custom_groups rejects empty group names", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  groups <- list(G1 = c("A", "B"), c("C", "D"))
  names(groups)[2] <- ""
  expect_error(validate_custom_groups(tree, groups), "named list")
})

test_that("validate_custom_groups rejects empty groups", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  groups <- list(G1 = c("A", "B"), G2 = character(0))
  expect_error(validate_custom_groups(tree, groups), "Empty custom group")
})

test_that("validate_custom_groups rejects tips not in tree", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  groups <- list(G1 = c("A", "X"))
  expect_error(validate_custom_groups(tree, groups), "not found in the tree")
})

test_that("validate_custom_groups rejects duplicate tip assignments", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  groups <- list(G1 = c("A", "B"), G2 = c("B", "C"))
  expect_error(validate_custom_groups(tree, groups), "multiple groups")
})

test_that("validate_custom_groups rejects non-monophyletic groups", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  groups <- list(G1 = c("A", "C"))
  expect_error(validate_custom_groups(tree, groups), "not monophyletic")
})

test_that("validate_custom_groups accepts single-tip groups", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  groups <- list(G1 = c("A"), G2 = c("B"), G3 = c("C", "D"))
  expect_silent(validate_custom_groups(tree, groups))
})

test_that("build_group_vec returns named vector", {
  groups <- list(G1 = c("A", "B"), G2 = c("C", "D"))
  tip_labels <- c("A", "B", "C", "D", "E")
  result <- build_group_vec(groups, tip_labels)
  expect_equal(length(result), 5)
  expect_equal(names(result), tip_labels)
  expect_equal(result[["A"]], "G1")
  expect_equal(result[["C"]], "G2")
  expect_true(is.na(result[["E"]]))
})

test_that("build_group_vec handles overlapping groups correctly", {
  groups <- list(G1 = c("A"), G2 = c("B"))
  tip_labels <- c("A", "B")
  result <- build_group_vec(groups, tip_labels)
  expect_equal(result[["A"]], "G1")
  expect_equal(result[["B"]], "G2")
})
