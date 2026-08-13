# Tests for logo.R

test_that("rclade_logo outputs ASCII art", {
  expect_output(rclade_logo(), "######")
})

test_that("rclade_logo with show_version = FALSE", {
  expect_output(rclade_logo(show_version = FALSE), "######")
  # Should NOT contain version string
  output <- capture.output(rclade_logo(show_version = FALSE))
  expect_false(any(grepl("Version", output)))
})

test_that("rclade_logo with show_tagline = FALSE", {
  expect_output(rclade_logo(show_tagline = FALSE), "######")
  output <- capture.output(rclade_logo(show_tagline = FALSE))
  expect_false(any(grepl("Automated Deep-Time", output)))
})

test_that("rclade_logo with both FALSE", {
  expect_output(rclade_logo(show_version = FALSE, show_tagline = FALSE), "######")
})

test_that("rclade_logo shows version by default", {
  output <- capture.output(rclade_logo())
  expect_true(any(grepl("Version", output)))
})

test_that("rclade_logo shows tagline by default", {
  output <- capture.output(rclade_logo())
  expect_true(any(grepl("Automated Deep-Time", output)))
})

test_that("rclade_logo shows third-party dependencies", {
  output <- capture.output(rclade_logo())
  expect_true(any(grepl("ape", output)))
  expect_true(any(grepl("ggtree", output)))
  expect_true(any(grepl("deeptime", output)))
})

test_that("rclade_logo returns invisible NULL", {
  result <- capture.output(r <- rclade_logo())
  expect_null(r)
})
