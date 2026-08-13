# Tests for aaa-utils.R internal utility functions

test_that("normalize_rank handles all single-letter abbreviations", {
  expect_equal(Rclade:::normalize_rank("k"), "kingdom")
  expect_equal(Rclade:::normalize_rank("d"), "domain")
  expect_equal(Rclade:::normalize_rank("p"), "phylum")
  expect_equal(Rclade:::normalize_rank("c"), "class")
  expect_equal(Rclade:::normalize_rank("o"), "order")
  expect_equal(Rclade:::normalize_rank("f"), "family")
  expect_equal(Rclade:::normalize_rank("g"), "genus")
  expect_equal(Rclade:::normalize_rank("s"), "species")
  expect_equal(Rclade:::normalize_rank("ss"), "subspecies")
  expect_equal(Rclade:::normalize_rank("none"), "none")
})

test_that("normalize_rank passes through full names unchanged", {
  expect_equal(Rclade:::normalize_rank("phylum"), "phylum")
  expect_equal(Rclade:::normalize_rank("domain"), "domain")
  expect_equal(Rclade:::normalize_rank("class"), "class")
})

test_that("normalize_rank returns unknown rank as-is", {
  expect_equal(Rclade:::normalize_rank("tribe"), "tribe")
})

test_that("get_rank_name returns display names", {
  expect_equal(Rclade:::get_rank_name("p"), "Phylum")
  expect_equal(Rclade:::get_rank_name("domain"), "Domain")
  expect_equal(Rclade:::get_rank_name("none"), "Taxa")
  expect_equal(Rclade:::get_rank_name("k"), "Kingdom")
  expect_equal(Rclade:::get_rank_name("ss"), "Subspecies")
})

test_that("get_rank_name returns rank as-is for unknown", {
  expect_equal(Rclade:::get_rank_name("tribe"), "tribe")
})

test_that("compute_x_min is adaptive to tree depth", {
  tree <- ape::read.tree(text = "((A:100,B:200):50,(C:150,D:50):100):0;")
  x_min <- Rclade:::compute_x_min(tree)
  expect_true(x_min < 0)
  # Young trees (root < 4031 Ma) use the adaptive margin (-max_depth * 1.05)
  # instead of a forced Hadean floor, so the tree fills the panel.
  expect_equal(x_min, -250 * Rclade:::RCLADE_X_MARGIN_FACTOR)
})

test_that("compute_x_min floors at -4567 only for Hadean-reaching trees", {
  # max depth 4200 Ma: margin (-4410) does not cover the full Hadean, so the
  # floor engages to keep the eon visible
  deep_tree <- ape::read.tree(text = "(A:4200,B:4100):0;")
  expect_equal(Rclade:::compute_x_min(deep_tree), Rclade:::RCLADE_X_MIN_FLOOR)
  # Boundary: exactly at the Archean boundary (4031 Ma) triggers the floor
  boundary_tree <- ape::read.tree(text = "(A:4031,B:4000):0;")
  expect_equal(Rclade:::compute_x_min(boundary_tree), Rclade:::RCLADE_X_MIN_FLOOR)
  # Very deep trees whose margin already extends past -4567 keep the margin
  deeper_tree <- ape::read.tree(text = "(A:4600,B:4500):0;")
  expect_equal(Rclade:::compute_x_min(deeper_tree),
               -4600 * Rclade:::RCLADE_X_MARGIN_FACTOR)
})

test_that("RCLADE_X_MARGIN_FACTOR is 1.05", {
  expect_equal(Rclade:::RCLADE_X_MARGIN_FACTOR, 1.05)
})

test_that("build_base_tree returns ggplot for rectangular", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  p <- Rclade:::build_base_tree(tree, "rectangular", 360, 1)
  expect_s3_class(p, "ggplot")
})

test_that("build_base_tree returns ggplot for circular", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  p <- Rclade:::build_base_tree(tree, "circular", 360, 1)
  expect_s3_class(p, "ggplot")
})

test_that("build_base_tree handles partial fan angle", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  p <- Rclade:::build_base_tree(tree, "circular", 180, 1)
  expect_s3_class(p, "ggplot")
})

test_that("convert_unit multiplies Ga by 1000", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  result <- Rclade:::convert_unit(tree, "Ga")
  expect_equal(result$edge.length, tree$edge.length * 1000)
})

test_that("convert_unit preserves Ma unchanged", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  result <- Rclade:::convert_unit(tree, "Ma")
  expect_equal(result$edge.length, tree$edge.length)
})

test_that("convert_unit returns tree unchanged for NULL unit", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  result <- Rclade:::convert_unit(tree, NULL)
  expect_equal(result$edge.length, tree$edge.length)
})

test_that("convert_unit preserves extra attributes", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$custom_attr <- "test_value"
  result <- Rclade:::convert_unit(tree, "Ga")
  expect_equal(result$custom_attr, "test_value")
})

test_that("prepare_geo_timescales returns list with eons/eras/periods", {
  skip_if_not_installed("deeptime")
  geo <- Rclade:::prepare_geo_timescales()
  expect_true(is.list(geo))
  expect_true(all(c("eons", "eras", "periods") %in% names(geo)))
  expect_true("Hadean" %in% geo$eons$name)
})

test_that("prepare_geo_timescales warns for unsupported version", {
  skip_if_not_installed("deeptime")
  # E-T3: warnings routed through log_warning() (emitted via message()).
  # Scope the option so it cannot leak into later tests (after fix A the logger
  # actually honours rclade.log_level, so a global set would suppress INFO
  # messages elsewhere in the suite).
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(Rclade:::prepare_geo_timescales("ICS 2020"))
    # grepl() returns one logical per message; assert that ANY line matches.
    expect_true(any(grepl("currently supported", msgs, fixed = TRUE)))
  })
})
