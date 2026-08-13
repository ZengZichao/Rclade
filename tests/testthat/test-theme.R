# Tests for theme-publication.R

test_that("theme_timetree returns a list with theme and coord", {
  t <- theme_timetree()
  expect_type(t, "list")
  expect_true(!is.null(t$theme))
  expect_true(!is.null(t$coord))
})

test_that("theme_timetree$theme is a ggplot2 theme", {
  t <- theme_timetree()
  expect_s3_class(t$theme, "theme")
})

test_that("theme_timetree accepts custom base_size", {
  t <- theme_timetree(base_size = 14)
  expect_s3_class(t$theme, "theme")
})

test_that("theme_timetree blanks x-axis elements", {
  t <- theme_timetree()
  # axis.line.x should be element_blank
  expect_true(inherits(t$theme$axis.line.x, "element_blank"))
  expect_true(inherits(t$theme$axis.ticks.x, "element_blank"))
  expect_true(inherits(t$theme$axis.text.x, "element_blank"))
  expect_true(inherits(t$theme$axis.title.x, "element_blank"))
})

test_that("theme_timetree removes panel grid", {
  t <- theme_timetree()
  expect_true(inherits(t$theme$panel.grid, "element_blank"))
})

test_that("theme_timetree coord has clip = off", {
  t <- theme_timetree()
  expect_s3_class(t$coord, "CoordCartesian")
  # coord_cartesian(clip = "off") — ggplot2 stores clip as character
  expect_equal(t$coord$clip, "off")
})

test_that("theme_timetree can be added to a plot", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  th <- theme_timetree()
  p <- ggtree::ggtree(tree) + th$theme + th$coord
  expect_s3_class(p, "ggplot")
})

test_that("theme_timetree works with plot_timetree", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  p <- plot_timetree(tree, rank = "none", add_timescale = FALSE,
                     theme_fun = theme_timetree)
  expect_s3_class(p, "ggplot")
})

test_that("theme_timetree with NULL theme_fun falls back to theme_tree2", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  p <- plot_timetree(tree, rank = "none", add_timescale = FALSE,
                     theme_fun = NULL)
  expect_s3_class(p, "ggplot")
})
