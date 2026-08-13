# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Graceful termination and resource cleanup handling

# Global state for tracking progress
.interrupt_env <- new.env(parent = emptyenv())
.interrupt_env$active <- FALSE
.interrupt_env$interrupted <- FALSE
.interrupt_env$progress <- list(
  trees_total = 0,
  trees_processed = 0,
  current_tree = NULL,
  start_time = NULL,
  open_connections = list(),
  temp_files = character(0)
)

#' Initialize progress tracking for a batch operation
#'
#' @param total Integer. Total number of items to process.
#' @param preserve_temp_files Logical. If TRUE, do not reset temp_files list
#'   (used when nesting inside an already-active interrupt context).
#' @keywords internal
init_progress_tracking <- function(total = 0, preserve_temp_files = FALSE) {
  .interrupt_env$active <- TRUE
  .interrupt_env$progress$trees_total <- total
  .interrupt_env$progress$trees_processed <- 0
  .interrupt_env$progress$current_tree <- NULL
  .interrupt_env$progress$start_time <- Sys.time()
  if (!preserve_temp_files) {
    .interrupt_env$progress$temp_files <- character(0)
  }
}

#' Update progress counter
#'
#' @param processed Integer. Number processed so far.
#' @param current Character. Description of current item.
#' @keywords internal
update_progress <- function(processed = NULL, current = NULL) {
  if (!is.null(processed)) .interrupt_env$progress$trees_processed <- processed
  if (!is.null(current)) .interrupt_env$progress$current_tree <- current
}

#' Get current progress summary
#'
#' @return Character string with progress info.
#' @keywords internal
get_progress_summary <- function() {
  p <- .interrupt_env$progress
  elapsed <- as.numeric(difftime(Sys.time(), p$start_time, units = "secs"))

  msg <- sprintf("Progress: %d/%d trees processed (%.1f seconds elapsed)",
                 p$trees_processed, p$trees_total, elapsed)
  if (!is.null(p$current_tree)) {
    msg <- paste0(msg, "\nCurrently processing: ", p$current_tree)
  }
  return(msg)
}

#' Clean up resources on interruption
#'
#' Closes open connections, removes incomplete temp files.
#' @keywords internal
cleanup_on_interrupt <- function() {
  log_warning("Interruption detected, cleaning up resources...",
              .module = "interrupt/cleanup_on_interrupt")

  # Print progress
  progress_msg <- get_progress_summary()
  message(progress_msg)

  # Close open connections
  for (id in names(.interrupt_env$progress$open_connections)) {
    con <- .interrupt_env$progress$open_connections[[id]]
    tryCatch({
      if (isOpen(con)) close(con)
      log_debug("Closed connection: %s", id)
    }, error = function(e) {
      log_debug("Error closing connection %s: %s", id, e$message)
    })
  }
  .interrupt_env$progress$open_connections <- list()

  # Remove incomplete temp files
  for (tmp in .interrupt_env$progress$temp_files) {
    if (file.exists(tmp)) {
      tryCatch({
        file.remove(tmp)
        log_debug("Removed temp file: %s", tmp)
      }, error = function(e) {
        log_debug("Error removing temp file %s: %s", tmp, e$message)
      })
    }
  }
  .interrupt_env$progress$temp_files <- character(0)

  .interrupt_env$active <- FALSE
}

#' Execute expression with graceful interrupt handling
#'
#' Wraps an expression so that SIGINT (Ctrl+C) is caught gracefully:
#' progress is reported, resources are cleaned up, and the function
#' returns NULL instead of throwing an error.
#'
#' @param expr Expression to evaluate.
#' @param total Integer. Total items for progress tracking (batch mode).
#' @return Result of expr, or NULL if interrupted.
#' @keywords internal
#' @examples
#' \dontrun{
#' result <- with_graceful_interrupt({
#'   for (i in 1:100) {
#'     Sys.sleep(0.1)
#'   }
#'   "done"
#' })
#' }
with_graceful_interrupt <- function(expr, total = 0) {
  init_progress_tracking(total)
  # Ensure active state is reset on any exit path (normal, error, interrupt)
  on.exit(.interrupt_env$active <- FALSE, add = TRUE)

  result <- tryCatch(
    expr,
    error = function(e) {
      # Handle errors normally
      stop(e)
    },
    interrupt = function(cond) {
      # Catch Ctrl+C
      .interrupt_env$interrupted <- TRUE
      cleanup_on_interrupt()
      message("\n")
      message("================================================================")
      message("  OPERATION INTERRUPTED BY USER (Ctrl+C)")
      message("================================================================")
      message(get_progress_summary())
      message("================================================================")
      message("Exiting gracefully...")
      # Return NULL instead of aborting, so cleanup after this wrapper runs
      invisible(NULL)
    }
  )

  return(result)
}

#' Execute batch operation with interrupt handling and progress
#'
#' Processes a list of items with progress tracking and graceful
#' interrupt handling. If interrupted, reports how many items were
#' completed before stopping.
#'
#' @param items List or vector of items to process.
#' @param fun Function to apply to each item. Receives (item, index).
#' @param label_fun Optional function to generate label for each item.
#' @return List of results (NULL for items not processed due to interrupt).
#' @keywords internal
#' @examples
#' \dontrun{
#' trees <- list(tree1, tree2, tree3)
#' results <- batch_with_interrupt(trees, function(t, i) {
#'   plot_timetree(t, rank = "phylum")
#' })
#' }
batch_with_interrupt <- function(items, fun, label_fun = NULL) {
  n <- length(items)
  results <- vector("list", n)
  # Preserve temp_files if already inside an active interrupt context
  init_progress_tracking(n, preserve_temp_files = isTRUE(.interrupt_env$active))
  # Ensure active state is reset on any exit path (normal, error, interrupt)
  on.exit(.interrupt_env$active <- FALSE, add = TRUE)

  results <- tryCatch(
    {
      for (i in seq_len(n)) {
        item <- items[[i]]
        label <- if (!is.null(label_fun)) label_fun(item, i) else paste("Item", i)
        update_progress(processed = i - 1, current = label)
        log_info("Processing %d/%d: %s", i, n, label)

        # Use list() assignment to preserve NULL placeholders
        results[i] <- list(fun(item, i))

        update_progress(processed = i)
      }
      results
    },
    interrupt = function(cond) {
      .interrupt_env$interrupted <- TRUE
      cleanup_on_interrupt()
      completed <- .interrupt_env$progress$trees_processed
      message("\n")
      message("================================================================")
      message("  BATCH OPERATION INTERRUPTED")
      message("================================================================")
      message(sprintf("  Completed: %d / %d items", completed, n))
      message(sprintf("  Remaining: %d items", n - completed))
      message("================================================================")
      # Return partial results so far
      results
    }
  )

  return(results)
}
