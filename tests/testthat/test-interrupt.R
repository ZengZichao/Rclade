# Tests for graceful interrupt handling

test_that("init_progress_tracking sets up state", {
  Rclade:::init_progress_tracking(10)
  expect_true(Rclade:::.interrupt_env$active)
  expect_equal(Rclade:::.interrupt_env$progress$trees_total, 10)
  expect_equal(Rclade:::.interrupt_env$progress$trees_processed, 0)
})

test_that("update_progress updates counters", {
  Rclade:::init_progress_tracking(5)
  Rclade:::update_progress(processed = 3, current = "Tree 3")
  expect_equal(Rclade:::.interrupt_env$progress$trees_processed, 3)
  expect_equal(Rclade:::.interrupt_env$progress$current_tree, "Tree 3")
})

test_that("get_progress_summary returns string", {
  Rclade:::init_progress_tracking(10)
  Rclade:::update_progress(processed = 5, current = "Tree 5")
  summary <- Rclade:::get_progress_summary()
  expect_true(is.character(summary))
  expect_true(grepl("5/10", summary))
})

test_that("with_graceful_interrupt executes normally", {
  result <- with_graceful_interrupt({
    1 + 1
  })
  expect_equal(result, 2)
})

test_that("with_graceful_interrupt handles errors", {
  expect_error(with_graceful_interrupt({
    stop("test error")
  }), "test error")
})

test_that("batch_with_interrupt processes all items", {
  items <- list(1, 2, 3, 4, 5)
  results <- batch_with_interrupt(items, function(x, i) x * 2)
  expect_equal(unlist(results), c(2, 4, 6, 8, 10))
})

test_that("batch_with_interrupt with label function", {
  items <- list("a", "b", "c")
  results <- batch_with_interrupt(
    items,
    function(x, i) toupper(x),
    label_fun = function(x, i) paste("Item", x)
  )
  expect_equal(unlist(results), c("A", "B", "C"))
})

# NOTE: register_temp_file() / register_cleanup() were removed during the H5
# fix (dead code with zero call sites across R/). cleanup_on_interrupt() is now
# the single cleanup path, wired into with_graceful_interrupt() and
# batch_with_interrupt(). The stale test that referenced the deleted
# register_temp_file() has been removed.
