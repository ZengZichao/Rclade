# Group-status accounting tests (v1.1.0, reviewer issues 2/8):
# results must distinguish parsed / collapsed / singleton / skipped groups.

test_that("compute_mrca_map exposes separate skip-reason attributes", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  # G1 singleton, G2 spans both subclades (non-monophyletic), G3 singleton
  group_vec <- c(A = "G1", B = "G2", C = "G2", D = "G3")
  mm <- Rclade:::compute_mrca_map(tree, group_vec,
                                  check_monophyly = TRUE, strict = FALSE)
  expect_equal(length(mm), 0)
  expect_equal(sort(names(attr(mm, "singleton_map"))), c("G1", "G3"))
  expect_equal(attr(mm, "non_monophyletic"), "G2")
  expect_equal(attr(mm, "skipped"), "G2")
})

test_that("compute_mrca_map records zero-tip groups separately", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  group_vec <- c(A = "G1", B = "G1")
  names(group_vec) <- c("A", "B")
  group_vec <- c(group_vec, MISSING = "G9")
  # G9 is not present among tip labels -> aligned tip count 0
  mm <- Rclade:::compute_mrca_map(tree, group_vec,
                                  check_monophyly = TRUE, strict = FALSE)
  expect_equal(attr(mm, "skipped_zero_tip"), "G9")
})

test_that("rclade_info reports full group-status breakdown (warn-and-skip)", {
  # Interleaved phyla: P1 = {A, B} and P2 = {C, D} are both
  # non-monophyletic on this topology, so rank-based collapsing warns
  # and skips them (default strict = FALSE).
  tree <- ape::read.tree(text = "((tA:1,tC:1):1,(tB:1,tD:1):1):1;")
  tree$tip.label <- c(
    "d__D;p__P1;c__C1", "d__D;p__P2;c__C3",
    "d__D;p__P1;c__C2", "d__D;p__P2;c__C4"
  )
  p <- suppressWarnings(
    plot_timetree(tree, rank = "phylum", taxonomy_format = "GTDB",
                  add_timescale = FALSE)
  )
  info <- attr(p, "rclade_info")
  expect_equal(info$groups_collapsed, 0)
  expect_equal(info$groups_skipped_non_monophyletic, 2)
  expect_equal(sort(info$skipped_non_monophyletic), c("P1", "P2"))
  expect_equal(info$groups_total,
               info$groups_collapsed + info$groups_singleton +
                 info$groups_skipped_non_monophyletic +
                 info$groups_skipped_other)
})

test_that("collapsed count equals mrca_map length end-to-end", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  p <- plot_timetree(
    tree, rank = "none",
    groups = list(G1 = c("A", "B"), G2 = c("C", "D")),
    add_timescale = FALSE
  )
  info <- attr(p, "rclade_info")
  expect_equal(info$groups_collapsed, 2)
  expect_equal(info$groups_singleton, 0)
  expect_equal(info$groups_skipped_non_monophyletic, 0)
  expect_equal(info$groups_total, 2)
})

test_that("summarize_timetree prints the breakdown", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  p <- plot_timetree(
    tree, rank = "none",
    groups = list(G1 = c("A", "B"), G2 = "C"),
    add_timescale = FALSE
  )
  out <- capture.output(summarize_timetree(p))
  expect_true(any(grepl("Groups collapsed", out)))
  expect_true(any(grepl("Singleton groups", out)))
  expect_true(any(grepl("Displayed leaves after collapse", out)))
})
