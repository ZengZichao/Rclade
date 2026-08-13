# Pure-unit coverage for multi-tree handling (E-T6): read_tree_auto
# honours every multi_tree_mode on a multiPhylo input. No external data.

test_that("read_tree_auto handles multiPhylo via multi_tree_mode", {
  data(example_tree)
  trees <- c(example_tree, example_tree)
  class(trees) <- "multiPhylo"

  tf <- tempfile(fileext = ".tre")
  on.exit(unlink(tf), add = TRUE)
  ape::write.tree(trees, file = tf)

  expect_s3_class(Rclade:::read_tree_auto(tf, multi_tree_mode = "first"), "phylo")
  expect_s3_class(Rclade:::read_tree_auto(tf, multi_tree_mode = "last"), "phylo")
  expect_s3_class(Rclade:::read_tree_auto(tf, multi_tree_mode = "random"), "phylo")

  all_t <- Rclade:::read_tree_auto(tf, multi_tree_mode = "all")
  expect_s3_class(all_t, "multiPhylo")
  expect_equal(length(all_t), 2)

  # Default mode without an explicit choice must abort (not silently pick one).
  expect_error(Rclade:::read_tree_auto(tf), class = "Rclade_read_error")
})
