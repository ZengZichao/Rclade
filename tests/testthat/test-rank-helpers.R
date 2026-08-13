# Pure unit tests for rank/helper functions (no external GTDB dependency).
# These were split out of the GTDB-dependent test-read.R so they always run
# in the pure unit suite (E-T8) regardless of whether GTDB data is available.

test_that("normalize_rank converts abbreviations", {
  expect_equal(Rclade:::normalize_rank("p"), "phylum")
  expect_equal(Rclade:::normalize_rank("d"), "domain")
  expect_equal(Rclade:::normalize_rank("phylum"), "phylum")
  expect_equal(Rclade:::normalize_rank("none"), "none")
})

test_that("get_rank_name returns display names", {
  expect_equal(Rclade:::get_rank_name("p"), "Phylum")
  expect_equal(Rclade:::get_rank_name("domain"), "Domain")
  expect_equal(Rclade:::get_rank_name("none"), "Taxa")
})

test_that("validate_inputs rejects non-phylo objects", {
  expect_error(Rclade:::validate_inputs("not_a_tree", "none", "Ga",
                                        "rectangular", "mixed", "proportional"),
               "phylo or treedata")
})
