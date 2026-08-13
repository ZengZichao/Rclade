# Tests using built-in example_tree data (coded GTDB-style labels)

test_that("example_tree loads correctly", {
  data(example_tree, package = "Rclade")
  expect_s3_class(example_tree, "phylo")
  expect_true(length(example_tree$tip.label) == 50)
  expect_true(!is.null(example_tree$edge.length))
})

test_that("example_tree GTDB labels parse correctly", {
  data(example_tree, package = "Rclade")
  result <- Rclade:::parse_gtdb(example_tree$tip.label)
  expect_true(all(!is.na(result$domain)))
  expect_true(all(!is.na(result$phylum)))
  expect_true(all(result$domain == "D1"))
})

test_that("example_tree auto-detects as GTDB", {
  data(example_tree, package = "Rclade")
  expect_equal(Rclade:::detect_taxonomy_format(example_tree$tip.label), "GTDB")
})

test_that("example_tree end-to-end with timescale disabled", {
  data(example_tree, package = "Rclade")
  p <- plot_timetree(example_tree, rank = "phylum",
                     taxonomy_format = "GTDB",
                     add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  info <- attr(p, "rclade_info")
  expect_true(!is.null(info))
  expect_equal(info$n_tips, 50)
  expect_true(info$n_groups >= 1)
  expect_equal(info$taxonomy_format, "GTDB")
})

test_that("example_tree end-to-end with class-level collapsing", {
  data(example_tree, package = "Rclade")
  p <- plot_timetree(example_tree, rank = "class",
                     taxonomy_format = "GTDB",
                     add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  info <- attr(p, "rclade_info")
  expect_true(info$n_groups >= 1)
})

test_that("example_tree works with rank = none", {
  data(example_tree, package = "Rclade")
  p <- plot_timetree(example_tree, rank = "none",
                     add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  info <- attr(p, "rclade_info")
  expect_equal(info$n_groups, 0)
})

test_that("example_tree summarize_timetree output", {
  data(example_tree, package = "Rclade")
  p <- plot_timetree(example_tree, rank = "phylum",
                     taxonomy_format = "GTDB",
                     add_timescale = FALSE)
  expect_output(summarize_timetree(p), "Rclade Timetree Summary")
  expect_output(summarize_timetree(p), "Collapsed groups")
})

test_that("example_tree taxonomy quality report", {
  data(example_tree, package = "Rclade")
  expect_output(
    summarize_taxonomy_quality(example_tree$tip.label, format = "GTDB"),
    "Taxonomy Label Parsing Quality Report"
  )
})

test_that("example_tree save and re-read", {
  data(example_tree, package = "Rclade")
  p <- plot_timetree(example_tree, rank = "phylum",
                     taxonomy_format = "GTDB",
                     add_timescale = FALSE)
  tmp <- tempfile(fileext = ".pdf")
  on.exit(unlink(tmp))
  save_timetree(p, tmp, width = 14, height = 10)
  expect_true(file.exists(tmp))
  expect_true(file.size(tmp) > 0)
})

test_that("example_tree clade labels work", {
  data(example_tree, package = "Rclade")
  p <- plot_timetree(example_tree, rank = "phylum",
                     taxonomy_format = "GTDB",
                     add_timescale = FALSE,
                     show_clade_label = TRUE,
                     clade_label_offset = 0.5)
  expect_s3_class(p, "ggplot")
})

# --- L-C9: structural contract for built-in example data ---
test_that("example_tree satisfies structural contract (L-C9)", {
  data(example_tree, package = "Rclade")
  n_tips <- ape::Ntip(example_tree)
  n_nodes <- example_tree$Nnode
  expect_equal(n_tips, 50)
  expect_equal(n_nodes, 49)
  # edges = tips + internal_nodes - 1
  expect_equal(nrow(example_tree$edge), n_tips + n_nodes - 1)
  # exactly one root node (a node with no parent)
  all_children <- example_tree$edge[, 2]
  internal_nodes <- (n_tips + 1):(n_tips + n_nodes)
  roots <- setdiff(internal_nodes, all_children)
  expect_equal(length(roots), 1)
  # all edge indices within valid range
  expect_true(all(example_tree$edge >= 1 & example_tree$edge <= n_tips + n_nodes))
})

test_that("polytomy_tree satisfies structural contract (L-C9)", {
  data(polytomy_tree, package = "Rclade")
  expect_s3_class(polytomy_tree, "phylo")
  expect_equal(ape::Ntip(polytomy_tree), 9)
  n_tips <- ape::Ntip(polytomy_tree)
  n_nodes <- polytomy_tree$Nnode
  expect_equal(nrow(polytomy_tree$edge), n_tips + n_nodes - 1)
})
