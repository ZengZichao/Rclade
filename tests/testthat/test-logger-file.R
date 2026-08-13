# Pure-unit coverage for file logging (E-T6): set_log_file routes
# log output to a file. No external data required.

test_that("set_log_file routes log output to a file", {
  tf <- tempfile(fileext = ".log")
  on.exit({
    Rclade:::set_log_file(NULL)
    unlink(tf)
  }, add = TRUE)

  Rclade:::set_log_file(tf)
  Rclade:::log_info("hello-from-test-%d", 42)
  # Closing the log file flushes the connection.
  Rclade:::set_log_file(NULL)

  expect_true(file.exists(tf))
  content <- paste(readLines(tf, warn = FALSE), collapse = "")
  expect_true(grepl("hello-from-test-42", content))
})
