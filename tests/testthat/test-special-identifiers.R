# Tests for special identifiers (LUCA, LACA, LBCA) and logo functions

test_that("rclade_logo outputs without error", {
  expect_output(rclade_logo(), "######")
  expect_output(rclade_logo(show_version = FALSE), "######")
  expect_output(rclade_logo(show_tagline = FALSE), "######")
  expect_output(rclade_logo(show_version = FALSE, show_tagline = FALSE), "######")
})

test_that("resolve_special_identifier validates input", {
  data(example_tree)

  # Test invalid identifier
  expect_error(resolve_special_identifier(example_tree, "INVALID"),
               "not a recognized special identifier")

  # Test non-phylo input
  expect_error(resolve_special_identifier("not_a_tree", "LUCA"),
               "must be a phylo object")
})

test_that("resolve_special_identifier returns proper structure", {
  data(example_tree)

  result <- resolve_special_identifier(example_tree, "LUCA", quiet = TRUE)

  expect_true(is.list(result))
  expect_true("node" %in% names(result))
  expect_true("identifier" %in% names(result))
  expect_true("description" %in% names(result))
  expect_true("n_tips" %in% names(result))
  expect_true("tip_labels" %in% names(result))
  expect_equal(result$identifier, "LUCA")
})

test_that("check_special_monophyly validates input", {
  data(example_tree)

  # Test non-phylo input
  expect_error(check_special_monophyly("not_a_tree", "LUCA"),
               "must be a phylo object")
})

test_that("check_special_monophyly returns proper structure", {
  data(example_tree)

  result <- check_special_monophyly(example_tree, "LBCA", quiet = TRUE)

  expect_true(is.list(result))
  expect_true("is_monophyletic" %in% names(result))
  expect_true("identifier" %in% names(result))
  expect_true("node" %in% names(result))
  expect_true("n_tips" %in% names(result))
  expect_true("n_outsiders" %in% names(result))
  expect_true("outsider_domains" %in% names(result))
  expect_equal(result$identifier, "LBCA")
})

test_that("resolve_group handles special identifiers", {
  data(example_tree)

  # Test LUCA
  result_luca <- resolve_group(example_tree, "LUCA", quiet = TRUE)
  expect_true(is.list(result_luca))
  expect_true(result_luca$is_special)
  expect_equal(result_luca$group, "LUCA")

  # Test LACA
  result_laca <- resolve_group(example_tree, "LACA", quiet = TRUE)
  expect_true(is.list(result_laca))
  expect_true(result_laca$is_special)
  expect_equal(result_laca$group, "LACA")

  # Test LBCA
  result_lbca <- resolve_group(example_tree, "LBCA", quiet = TRUE)
  expect_true(is.list(result_lbca))
  expect_true(result_lbca$is_special)
  expect_equal(result_lbca$group, "LBCA")
})

test_that("resolve_group handles regular groups", {
  data(example_tree)

  # Test regular group (should not be special)
  result <- resolve_group(example_tree, "D1", rank = "domain", quiet = TRUE)
  expect_true(is.list(result))
  expect_false(result$is_special)
  expect_equal(result$group, "D1")
})
