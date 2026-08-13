# Tests for legend layout

test_that("legend layout auto-adjusts for horizontal position", {
  layout <- Rclade:::compute_legend_layout(20, "top", nrow = 2, ncol = NULL)
  expect_equal(layout$nrow, 2)
  expect_equal(layout$ncol, 10)
})

test_that("legend layout auto-adjusts for vertical position", {
  layout <- Rclade:::compute_legend_layout(20, "right", nrow = NULL, ncol = 2)
  expect_equal(layout$ncol, 2)
  expect_equal(layout$nrow, 10)
})

test_that("legend layout warns when nrow*ncol < n_groups", {
  # E-T3: warnings routed through log_warning() (emitted via message()).
  # Scope the option so it cannot leak into later tests (after fix A the
  # logger actually honours rclade.log_level, so a global set would suppress
  # INFO messages elsewhere in the suite).
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(
      Rclade:::compute_legend_layout(20, "right", nrow = 2, ncol = 3)
    )
    expect_true(grepl("insufficient", msgs, fixed = TRUE))
  })
})

test_that("legend layout handles both nrow and ncol specified", {
  layout <- Rclade:::compute_legend_layout(10, "right", nrow = 5, ncol = 3)
  expect_equal(layout$nrow, 5)
  expect_equal(layout$ncol, 3)
})

test_that("legend layout auto-computes for inside position", {
  layout <- Rclade:::compute_legend_layout(16, "inside", nrow = NULL, ncol = NULL)
  expect_equal(layout$ncol, 4)
  expect_equal(layout$nrow, 4)
})

test_that("legend layout handles zero groups", {
  layout <- Rclade:::compute_legend_layout(0, "right", nrow = NULL, ncol = NULL)
  expect_equal(layout$nrow, 0)
  expect_equal(layout$ncol, 0)
})
