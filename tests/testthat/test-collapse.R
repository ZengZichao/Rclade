# Tests for collapse workflow

test_that("generate_colors returns named vector", {
  groups <- c("A", "B", "C")
  colors <- generate_colors(groups, palette = "viridis")
  expect_length(colors, 3)
  expect_equal(names(colors), groups)
  expect_true(all(grepl("^#", colors)))
})

test_that("generate_colors respects color_mapping override", {
  groups <- c("A", "B", "C")
  colors <- generate_colors(groups, palette = "viridis",
                            color_mapping = c("A" = "#FF0000"))
  expect_equal(colors[["A"]], "#FF0000")
})

test_that("generate_colors handles empty groups", {
  colors <- generate_colors(character(0))
  expect_length(colors, 0)
})

test_that("generate_colors works with RColorBrewer palettes", {
  skip_if_not_installed("RColorBrewer")
  groups <- paste0("G", 1:5)
  colors <- generate_colors(groups, palette = "Set1")
  expect_length(colors, 5)
})

test_that("generate_colors works with color vector input", {
  groups <- paste0("G", 1:5)
  custom_colors <- c("#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#FF00FF")
  colors <- generate_colors(groups, palette = custom_colors)
  expect_equal(colors, setNames(custom_colors, groups))
})

test_that("actual_ntips counts displayed leaves, not backbone internal nodes", {
  data(example_tree)
  suppressMessages({
    p <- plot_timetree(example_tree, rank = "phylum", taxonomy_format = "GTDB",
                       add_timescale = FALSE)
  })
  info <- attr(p, "rclade_info")
  # example_tree has 5 phyla (P1..P5), 10 tips each; collapsing at phylum
  # must display exactly 5 pseudo-leaves (one per collapsed clade).
  expect_equal(info$actual_ntips, 5)
  expect_equal(info$n_tips, 50)
})

test_that("actual_ntips equals Ntip when nothing is collapsed", {
  data(example_tree)
  suppressMessages({
    p <- plot_timetree(example_tree, rank = "none", add_timescale = FALSE)
  })
  info <- attr(p, "rclade_info")
  expect_equal(info$actual_ntips, 50)
})

test_that("actual_ntips counts visible true tips plus collapsed pseudo-leaves", {
  data(example_tree)
  # Collapse only a single phylum; the other 40 tips stay visible.
  suppressMessages({
    p <- plot_timetree(example_tree, clade = "P1", taxonomy_format = "GTDB",
                       add_timescale = FALSE)
  })
  info <- attr(p, "rclade_info")
  expect_equal(info$actual_ntips, 40 + 1)
})
