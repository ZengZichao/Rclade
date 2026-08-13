# Smoke tests for the Shiny interface (run_rclade_shiny)

test_that("Shiny app object can be constructed without error", {
  testthat::skip_if_not_installed("shiny")
  app <- suppressMessages(suppressWarnings(run_rclade_shiny()))
  expect_s3_class(app, "shiny.appobj")
})

test_that("Shiny app has a server function and UI", {
  testthat::skip_if_not_installed("shiny")
  app <- suppressMessages(suppressWarnings(run_rclade_shiny()))
  # shiny.appobj exposes the server function for testServer-style inspection
  expect_true(is.function(app$serverFuncSource()))
  ui <- app$httpHandler
  expect_true(is.function(ui))
})

test_that("Shiny CSS does not load remote fonts (offline/HPC safe)", {
  testthat::skip_if_not_installed("shiny")
  src <- paste(deparse(run_rclade_shiny), collapse = "\n")
  expect_false(grepl("fonts.googleapis.com", src, fixed = TRUE))
  expect_false(grepl("@import url(", src, fixed = TRUE))
})
