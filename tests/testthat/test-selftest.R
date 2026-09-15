# Pure-unit coverage for the self-test entry point (E-T6):
# run_rclade_selftest() executes and returns a valid exit code.

test_that("run_rclade_selftest returns a valid exit code", {
  msgs <- utils::capture.output(
    res <- Rclade:::run_rclade_selftest(),
    type = "message"
  )
  expect_type(res, "integer")
  expect_true(res %in% c(0L, 1L))
  # CRAN policy: self-test reporting must use message() (stderr), not cat().
  expect_true(length(msgs) > 0)
})

test_that("run_rclade_selftest output is suppressible via suppressMessages", {
  msgs <- utils::capture.output(
    res <- suppressMessages(Rclade:::run_rclade_selftest()),
    type = "message"
  )
  expect_length(msgs, 0)
  expect_true(res %in% c(0L, 1L))
})

test_that("run_rclade_selftest(verbose = FALSE) emits no self-test reporting", {
  stdout_lines <- utils::capture.output(
    msg_lines <- utils::capture.output(
      res <- Rclade:::run_rclade_selftest(verbose = FALSE),
      type = "message"
    ),
    type = "output"
  )
  # The self-test's own reporting (banner, section headers, [PASS]/[FAIL]
  # lines, summary) is fully disabled. Any remaining message lines come from
  # the package logger inside the functions under test; those are governed by
  # the logger's own controls (options(rclade.log_level), set_log_enabled()).
  selftest_lines <- grep("Self-Test|\\[PASS\\]|\\[FAIL\\]|Dependency Checks|Taxonomy Extraction|Monophyly Logic|Input Validation|Summary",
                         msg_lines, value = TRUE)
  expect_length(selftest_lines, 0)
  expect_length(stdout_lines, 0)
  expect_true(res %in% c(0L, 1L))
})
