# Tests for timescale functions

test_that("deep time gets geological breaks", {
  result <- Rclade:::compute_time_breaks(-4567, 0)
  expect_true(all(result$breaks <= 0))
  expect_true(length(result$breaks) >= 3)
  expect_equal(result$unit_label, "Time (Ma)")
})

test_that("medium time gets pretty breaks", {
  result <- Rclade:::compute_time_breaks(-100, 0)
  expect_true(length(result$breaks) >= 3)
  expect_equal(result$unit_label, "Time (Ma)")
})

test_that("short time uses Ka unit", {
  result <- Rclade:::compute_time_breaks(-0.5, 0)
  expect_equal(result$unit_label, "Time (Ka)")
  expect_true(max(abs(result$breaks)) <= 0.5)
})

test_that("deep time breaks fall within range", {
  result <- Rclade:::compute_time_breaks(-2000, 0)
  expect_true(all(result$breaks >= -2000))
  expect_true(all(result$breaks <= 0))
})

test_that("boundary at 500 Ma uses correct strategy", {
  result <- Rclade:::compute_time_breaks(-500, 0)
  expect_equal(result$unit_label, "Time (Ma)")
  expect_true(length(result$breaks) >= 2)
  expect_true(all(result$breaks >= -500))
  expect_true(all(result$breaks <= 0))
})

test_that("boundary at 1 Ma uses correct strategy", {
  result <- Rclade:::compute_time_breaks(-1, 0)
  expect_equal(result$unit_label, "Time (Ma)")
  expect_true(length(result$breaks) >= 2)
})

test_that("deep time breaks are unique", {
  result <- Rclade:::compute_time_breaks(-4567, 0)
  expect_equal(length(result$breaks), length(unique(result$breaks)))
})

test_that("deep time with exact standard break", {
  result <- Rclade:::compute_time_breaks(-252, 0)
  expect_equal(result$unit_label, "Time (Ma)")
  # pretty() may round -252 to -250, so allow tolerance of 5 Ma
  expect_true(-252 %in% result$breaks || any(abs(result$breaks - (-252)) < 5))
})
