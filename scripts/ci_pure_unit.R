#!/usr/bin/env Rscript
# CI: run the unit test suite (tests/testthat/).
#
# This deliberately targets tests/testthat/ only. testthat does not recurse
# into subdirectories, so any external/ suite (if present) is never executed
# here.
#
# A green run of this script is a hard requirement for CI: missing
# external reference data must never produce a false pass, and it must never
# block the unit suite either.

status <- 0L
tryCatch({
  if (!requireNamespace("testthat", quietly = TRUE)) {
    stop("testthat is required to run the unit suite")
  }
  library(testthat)

  # Ensure the package under test is available (installed or dev-loaded).
  if (!requireNamespace("Rclade", quietly = TRUE)) {
    if (requireNamespace("devtools", quietly = TRUE)) {
      devtools::load_all(".", quiet = TRUE)
    } else {
      stop("Rclade package is not available and devtools is missing")
    }
  }

  # tests/testthat/ excludes the external/ subdirectory by design.
  res <- test_dir("tests/testthat", reporter = "summary", stop_on_failure = TRUE)
  if (!is.null(res$error) && length(res$error) > 0L) {
    status <- 1L
  }
}, error = function(e) {
  cat("Pure unit suite failed:\n", conditionMessage(e), "\n", sep = "")
  status <<- 1L
})

quit(status = status)
