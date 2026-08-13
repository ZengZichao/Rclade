# Regression tests for four previously identified high-risk rendering/parsing scenarios
# (E-T6 H-regression). Each builds a small synthetic semicolon-delimited taxonomy
# tree so the tests run without any external reference data.

make_taxonomy_tree <- function() {
  tips <- c(
    "d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria;o__Enterobacterales;f__Enterobacteriaceae;g__Escherichia;s__Escherichia_coli",
    "d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria;o__Enterobacterales;f__Enterobacteriaceae;g__Salmonella;s__Salmonella_enterica",
    "d__Bacteria;p__Firmicutes;c__Bacilli;o__Lactobacillales;f__Lactobacillaceae;g__Lactobacillus;s__Lactobacillus_acidophilus"
  )
  tr <- ape::rtree(3)
  tr$tip.label <- tips
  tr
}

test_that("H-regression: circular layout + default theme", {
  tr <- make_taxonomy_tree()
  p <- Rclade::plot_timetree(tr, rank = "phylum", layout = "circular",
                              add_timescale = FALSE, timescale_mode = "radial")
  expect_s3_class(p, "ggplot")
  expect_true(!is.null(attr(p, "rclade_info")))
})

test_that("H-regression: taxonomy names containing underscores", {
  tr <- make_taxonomy_tree()
  p <- Rclade::plot_timetree(tr, rank = "phylum", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  expect_true(!is.null(attr(p, "rclade_info")))
})

test_that("H-regression: nested clade collapse", {
  tr <- make_taxonomy_tree()
  p <- Rclade::plot_timetree(tr, clade = "Gammaproteobacteria",
                              add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  expect_true(!is.null(attr(p, "rclade_info")))
})

test_that("H-regression: color_rank decoupled from rank (CLI/Shiny path)", {
  tr <- make_taxonomy_tree()
  p <- Rclade::plot_timetree(tr, rank = "phylum", color_rank = "class",
                              add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  expect_true(!is.null(attr(p, "rclade_info")))
})
