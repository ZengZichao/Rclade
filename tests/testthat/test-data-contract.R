# Pure-unit data-contract coverage (E-T6): the bundled example_tree
# always satisfies the minimum structural invariants the pipeline relies on.

test_that("example_tree data contract", {
  data(example_tree)
  expect_s3_class(example_tree, "phylo")
  expect_true(ape::Ntip(example_tree) >= 3)
  expect_true(!is.null(example_tree$tip.label))
  expect_true(length(example_tree$tip.label) == ape::Ntip(example_tree))
  expect_true(!is.null(example_tree$edge.length))
  expect_true(all(example_tree$edge.length >= 0))
})
