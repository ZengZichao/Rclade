# Tests for logging system and input validation

test_that("set_log_level validates input", {
  # Valid levels
  expect_silent(set_log_level("DEBUG"))
  expect_silent(set_log_level("INFO"))
  expect_silent(set_log_level("WARNING"))
  expect_silent(set_log_level("ERROR"))
  expect_silent(set_log_level("CRITICAL"))

  # Case insensitive
  expect_silent(set_log_level("debug"))
  expect_silent(set_log_level("info"))

  # Invalid level
  expect_error(set_log_level("INVALID"), "Invalid log level")
})

test_that("set_log_enabled toggles logging", {
  expect_silent(set_log_enabled(TRUE))
  expect_silent(set_log_enabled(FALSE))
  expect_silent(set_log_enabled(TRUE))
})

test_that("log_info outputs message", {
  set_log_level("INFO")
  expect_message(log_info("Test message"), "Test message")
})

test_that("log_debug respects log level", {
  # Set level to INFO, debug should not show
  set_log_level("INFO")
  expect_silent(log_debug("This should not appear"))

  # Set level to DEBUG, debug should show
  set_log_level("DEBUG")
  expect_message(log_debug("Debug message"), "Debug message")
})

test_that("log_warning outputs warning level", {
  set_log_level("WARNING")
  expect_message(log_warning("Warning message"), "WARNING")
})

test_that("log_error outputs error level", {
  set_log_level("ERROR")
  expect_message(log_error("Error message"), "ERROR")
})

test_that("log_section outputs formatted header", {
  set_log_level("INFO")
  expect_message(log_section("Test Section"), "Test Section")
})

test_that("log_subsection outputs formatted header", {
  set_log_level("INFO")
  expect_message(log_subsection("Test Subsection"), "Test Subsection")
})

test_that("log_keyvalue outputs key-value pair", {
  set_log_level("INFO")
  expect_message(log_keyvalue("key", "value"), "key")
  expect_message(log_keyvalue("key", "value"), "value")
})

test_that("log_stats outputs statistics", {
  set_log_level("INFO")
  stats <- list("Tips" = 50, "Groups" = 5)
  expect_message(log_stats(stats), "Tips")
  expect_message(log_stats(stats), "50")
})

test_that("timer_start and timer_stop work", {
  set_log_level("INFO")
  # timer_start uses log_debug, so it won't output at INFO level
  expect_silent(timer_start("test_timer"))
  Sys.sleep(0.1)
  expect_message(timer_stop("test_timer"), "test_timer")
})

test_that("get_supported_extensions returns list", {
  exts <- get_supported_extensions()
  expect_true(is.list(exts))
  expect_true("tree" %in% names(exts))
  expect_true("sequence" %in% names(exts))
  expect_true("taxonomy" %in% names(exts))
  expect_true("nwk" %in% exts$tree)
  expect_true("fasta" %in% exts$sequence)
})
