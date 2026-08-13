# Tests for annotate-clade.R

test_that("annotate_clade adds text layer to plot", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  tree$tip.label <- paste0("d__D1;p__P", c(1, 1, 2, 2))
  p <- plot_timetree(tree, rank = "phylum", taxonomy_format = "GTDB",
                     add_timescale = FALSE, show_clade_label = TRUE)
  expect_s3_class(p, "ggplot")
  # Verify geom_text layers were added
  text_layers <- vapply(p$layers, function(l) inherits(l$geom, "GeomText"), logical(1))
  expect_true(any(text_layers))
})

test_that("annotate_clade respects show_count = FALSE", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  tree$tip.label <- paste0("d__D1;p__P", c(1, 1, 2, 2))
  p <- plot_timetree(tree, rank = "phylum", taxonomy_format = "GTDB",
                     add_timescale = FALSE, show_clade_label = TRUE,
                     show_clade_count = FALSE)
  expect_s3_class(p, "ggplot")
})

test_that("annotate_clade warns for out-of-range offset", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  d <- data.frame(node = c(1, 2, 3), x = c(-1, -1, 0), y = c(1, 2, 1.5),
                  isTip = c(TRUE, TRUE, FALSE), label = c("A", "B", ""),
                  parent = c(3, 3, NA), stringsAsFactors = FALSE)
  p <- ggplot2::ggplot(d, ggplot2::aes(x = x, y = y)) + ggplot2::geom_blank()
  p$data <- d
  mrca_map <- list(P1 = list(node = 3, tip_count = 2))
  colors <- c(P1 = "#FF0000")

  # E-T3: warnings routed through log_warning() (emitted via message()).
  # Scope the option so it cannot leak into later tests (after fix A the logger
  # actually honours rclade.log_level, so a global set would suppress INFO
  # messages elsewhere in the suite).
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(
      Rclade:::annotate_clade(p, tree, mrca_map, colors, offset = -1)
    )
    expect_true(grepl("clade_label_offset", msgs, fixed = TRUE))
  })
})

test_that("annotate_clade warns for out-of-range fontsize", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  d <- data.frame(node = c(1, 2, 3), x = c(-1, -1, 0), y = c(1, 2, 1.5),
                  isTip = c(TRUE, TRUE, FALSE), label = c("A", "B", ""),
                  parent = c(3, 3, NA), stringsAsFactors = FALSE)
  p <- ggplot2::ggplot(d, ggplot2::aes(x = x, y = y)) + ggplot2::geom_blank()
  p$data <- d
  mrca_map <- list(P1 = list(node = 3, tip_count = 2))
  colors <- c(P1 = "#FF0000")

  # E-T3: warnings routed through log_warning() (emitted via message()).
  # Scope the option so it cannot leak into later tests (after fix A the logger
  # actually honours rclade.log_level, so a global set would suppress INFO
  # messages elsewhere in the suite).
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(
      Rclade:::annotate_clade(p, tree, mrca_map, colors, fontsize = 0)
    )
    expect_true(grepl("fontsize", msgs, fixed = TRUE))
  })
})

test_that("annotate_clade positions labels at rightmost tip", {
  tree <- ape::read.tree(text = "((A:100,B:200):50,(C:150,D:50):100):0;")
  tree$tip.label <- paste0("d__D1;p__P", c(1, 1, 2, 2))
  p <- plot_timetree(tree, rank = "phylum", taxonomy_format = "GTDB",
                     add_timescale = FALSE, show_clade_label = TRUE,
                     clade_label_offset = 10)
  expect_s3_class(p, "ggplot")
  # The label x should be near the rightmost tip (which is at x=0 after revts)
  text_layers <- p$layers[vapply(p$layers, function(l) inherits(l$geom, "GeomText"), logical(1))]
  if (length(text_layers) > 0) {
    label_data <- text_layers[[1]]$data
    # Labels are placed to the right of the rightmost tip (x >= 0 after revts)
    expect_true(all(label_data$x >= 0))
  }
})
