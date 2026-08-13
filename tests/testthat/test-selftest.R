# Pure-unit coverage for the self-test entry point (E-T6):
# run_rclade_selftest() executes and returns a valid exit code.

test_that("run_rclade_selftest returns a valid exit code", {
  res <- Rclade:::run_rclade_selftest()
  expect_type(res, "integer")
  expect_true(res %in% c(0L, 1L))
})
