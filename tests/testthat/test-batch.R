# Tests for batch.R batch_plot function

test_that("batch_plot creates output directory", {
  tmp_in <- tempfile()
  dir.create(tmp_in)
  on.exit(unlink(tmp_in, recursive = TRUE), add = TRUE)

  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  ape::write.tree(tree, file.path(tmp_in, "test.tre"))

  tmp_out <- tempfile()
  on.exit(unlink(tmp_out, recursive = TRUE), add = TRUE)

  res <- batch_plot(tmp_in, output_dir = tmp_out, rank = "none",
                    add_timescale = FALSE)
  expect_true(dir.exists(tmp_out))
  expect_equal(length(res), 1)
  expect_true(file.exists(file.path(tmp_out, "test.pdf")))
})

test_that("batch_plot returns empty list for no matching files", {
  tmp_in <- tempfile()
  dir.create(tmp_in)
  on.exit(unlink(tmp_in, recursive = TRUE), add = TRUE)

  tmp_out <- tempfile()
  on.exit(unlink(tmp_out, recursive = TRUE), add = TRUE)

  expect_message(
    res <- batch_plot(tmp_in, output_dir = tmp_out, pattern = "*.xyz"),
    "No files matching"
  )
  expect_equal(length(res), 0)
})

test_that("batch_plot rejects invalid format", {
  tmp_in <- tempfile()
  dir.create(tmp_in)
  on.exit(unlink(tmp_in, recursive = TRUE), add = TRUE)

  ape::write.tree(ape::read.tree(text = "(A:1,B:1):1;"),
                  file.path(tmp_in, "test.tre"))

  expect_error(
    batch_plot(tmp_in, output_dir = tempfile(), format = "invalid"),
    "Invalid format"
  )
})

test_that("batch_plot processes multiple files", {
  tmp_in <- tempfile()
  dir.create(tmp_in)
  on.exit(unlink(tmp_in, recursive = TRUE), add = TRUE)

  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  for (i in 1:3) {
    ape::write.tree(tree, file.path(tmp_in, paste0("tree_", i, ".tre")))
  }

  tmp_out <- tempfile()
  on.exit(unlink(tmp_out, recursive = TRUE), add = TRUE)

  res <- batch_plot(tmp_in, output_dir = tmp_out, rank = "none",
                    add_timescale = FALSE)
  expect_equal(length(res), 3)
  expect_true(all(file.exists(file.path(tmp_out, paste0("tree_", 1:3, ".pdf")))))
})

test_that("batch_plot handles png format", {
  tmp_in <- tempfile()
  dir.create(tmp_in)
  on.exit(unlink(tmp_in, recursive = TRUE), add = TRUE)

  ape::write.tree(ape::read.tree(text = "(A:1,B:1):1;"),
                  file.path(tmp_in, "test.tre"))

  tmp_out <- tempfile()
  on.exit(unlink(tmp_out, recursive = TRUE), add = TRUE)

  res <- batch_plot(tmp_in, output_dir = tmp_out, format = "png",
                    rank = "none", add_timescale = FALSE)
  expect_true(file.exists(file.path(tmp_out, "test.png")))
})

test_that("batch_plot reports failures gracefully", {
  tmp_in <- tempfile()
  dir.create(tmp_in)
  on.exit(unlink(tmp_in, recursive = TRUE), add = TRUE)

  # Write a valid tree
  ape::write.tree(ape::read.tree(text = "(A:1,B:1):1;"),
                  file.path(tmp_in, "good.tre"))
  # Write an invalid file
  writeLines("not a tree", file.path(tmp_in, "bad.tre"))

  tmp_out <- tempfile()
  on.exit(unlink(tmp_out, recursive = TRUE), add = TRUE)

  # E-T3: failure reporting now uses log_warning() (emitted via message()),
  # not base warning(). Capture the message stream and assert on it.
  # A: wrap in withr::with_options so the WARNING threshold is set locally and
  # is unaffected by .logger_env$level state leaked from other tests.
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(
      res <- batch_plot(tmp_in, output_dir = tmp_out, rank = "none",
                        add_timescale = FALSE)
    )
    # grepl() returns one logical per captured message; assert ANY line matches.
    expect_true(any(grepl("Failed", msgs, fixed = TRUE)))
    expect_equal(length(res), 2)
  })
})
