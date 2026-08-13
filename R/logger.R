# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Real-time logging system for Rclade

#' Rclade Logger
#'
#' A real-time logging system with flush support, timestamps, and log levels.
#' Messages are printed immediately (not buffered) with formatted output.
#'
#' @section Log Levels:
#' \itemize{
#'   \item \strong{DEBUG}: Detailed debug information
#'   \item \strong{INFO}: Normal operation information
#'   \item \strong{WARNING}: Warning messages
#'   \item \strong{ERROR}: Error messages
#'   \item \strong{CRITICAL}: Critical errors
#' }
#'
#' @details
#' \strong{Thread safety}: The logger uses a package-global environment and is
#' \emph{not} thread-safe. In concurrent contexts (e.g., multiple Shiny sessions
#' or parallel Snakemake/Nextflow rule executions), multiple Rclade instances
#' writing to the same log file will produce interleaved or corrupted log output.
#'
#' \strong{Best practices for parallel execution}:
#' \itemize{
#'   \item \strong{Each process MUST use an independent log file} (mandatory).
#'         Never point two concurrent Rclade processes at the same \code{--log_file}.
#'         Sharing one log file is only safe when the \code{filelock} package is
#'         installed (it provides an advisory lock on each write); otherwise
#'         concurrent writes will interleave/corrupt output.
#'   \item Assign each Rclade instance a unique log file via \code{--log_file}
#'         (e.g., \code{--log_file logs/task_\$SLURM_JOB_ID.log})
#'   \item In Snakemake/Nextflow pipelines, use wildcards to generate per-rule
#'         or per-sample log paths
#'   \item For Shiny deployments, disable file logging with
#'         \code{enable_file_logging(FALSE)} before launching the app
#'   \item The console output (via \code{message()}) is process-local and does
#'         not suffer from interleaving issues
#' }
#'
#' \strong{Limitation}: The current design does not support a shared log file
#' across concurrent Rclade processes. This is a known limitation tracked for
#' a future release. For now, use per-instance log files as described above.
#'
#' @name rclade_logger
#' @keywords internal
NULL

# Global logger state
.logger_env <- new.env(parent = emptyenv())
.logger_env$level <- "INFO"
.logger_env$enabled <- TRUE
.logger_env$step_counter <- 0
.logger_env$step_total <- 0
.logger_env$start_time <- NULL
.logger_env$log_file <- NULL
.logger_env$log_con <- NULL
.logger_env$log_lock_release <- NULL   # release fn for an acquired advisory file lock
.logger_env$warn_unknown_level_issued <- FALSE  # emit the unknown-level note once

#' Set log level
#'
#' @param level Character. One of "DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL".
#' @export
set_log_level <- function(level) {
  valid_levels <- c("DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL")
  level <- toupper(level)
  if (!level %in% valid_levels) {
    stop("Invalid log level: '", level, "'. Valid: ", paste(valid_levels, collapse = ", "),
         call. = FALSE)
  }
  .logger_env$level <- level
  invisible(NULL)
}

#' Enable or disable logging
#'
#' @param enabled Logical.
#' @export
set_log_enabled <- function(enabled) {
  .logger_env$enabled <- isTRUE(enabled)
  invisible(NULL)
}

#' Get numeric value for log level
#' @keywords internal
level_to_num <- function(level) {
  switch(toupper(level),
    "DEBUG" = 1,
    "INFO" = 2,
    "WARNING" = 3,
    "ERROR" = 4,
    "CRITICAL" = 5,
    2
  )
}

#' Format timestamp in ISO 8601 with milliseconds and timezone offset
#' @keywords internal
format_timestamp <- function() {
  t <- Sys.time()
  secs <- as.numeric(t)
  ms <- round((secs %% 1) * 1000)
  base <- format(t, "%Y-%m-%dT%H:%M:%S")
  # Append a timezone offset (e.g. "+08:00") for unambiguous, sortable logs (L-C6)
  tz <- format(t, "%z")
  if (nzchar(tz) && grepl("^[+-]", tz)) {
    tz <- paste0(substr(tz, 1, 3), ":", substr(tz, 4, 5))
  }
  sprintf("%s.%03d%s", base, ms, tz)
}

#' Set log file for dual output
#'
#' @param filepath Character. Path to log file. NULL to disable.
#' @export
set_log_file <- function(filepath) {
  # Close existing connection
  if (!is.null(.logger_env$log_con) && isOpen(.logger_env$log_con)) {
    tryCatch(close(.logger_env$log_con), error = function(e) NULL)
  }

  if (is.null(filepath)) {
    .logger_env$log_file <- NULL
    .logger_env$log_con <- NULL
    return(invisible(NULL))
  }

  # Ensure directory exists
  dir.create(dirname(filepath), recursive = TRUE, showWarnings = FALSE)

  .logger_env$log_file <- filepath
  .logger_env$log_con <- file(filepath, open = "a", encoding = "UTF-8")

  log_info("Log file opened: %s", filepath)
  invisible(NULL)
}

#' Format elapsed time
#' @keywords internal
format_elapsed <- function() {
  if (is.null(.logger_env$start_time)) return("")
  elapsed <- as.numeric(difftime(Sys.time(), .logger_env$start_time, units = "secs"))
  if (elapsed < 60) {
    sprintf("[%6.2fs]", elapsed)
  } else if (elapsed < 3600) {
    mins <- floor(elapsed / 60)
    secs <- elapsed - mins * 60
    sprintf("[%dm %05.2fs]", mins, secs)
  } else {
    hours <- floor(elapsed / 3600)
    mins <- floor((elapsed - hours * 3600) / 60)
    secs <- elapsed - hours * 3600 - mins * 60
    sprintf("[%dh %02dm %05.2fs]", hours, mins, secs)
  }
}

#' Format step counter
#' @keywords internal
format_step <- function() {
  if (.logger_env$step_total > 0) {
    sprintf("[%2d/%2d]", .logger_env$step_counter, .logger_env$step_total)
  } else {
    ""
  }
}

#' Get level prefix
#' @keywords internal
get_level_prefix <- function(level) {
  switch(toupper(level),
    "DEBUG"    = "[DEBUG]   ",
    "INFO"     = "[INFO]    ",
    "WARNING"  = "[WARNING] ",
    "ERROR"    = "[ERROR]   ",
    "CRITICAL" = "[CRITICAL]",
    "[LOG]     "
  )
}

#' Acquire an advisory file lock for the active log file (L-C5)
#'
#' Uses the \code{filelock} package when available; otherwise it is a silent
#' no-op and parallel safety relies on the documented per-process log-file
#' convention. Lock acquisition is non-blocking (\code{timeout = 0}).
#' @keywords internal
.acquire_log_lock <- function() {
  if (!is.null(.logger_env$log_lock_release)) return(invisible(TRUE))
  if (is.null(.logger_env$log_file)) return(invisible(FALSE))
  if (requireNamespace("filelock", quietly = TRUE)) {
    lock_path <- paste0(.logger_env$log_file, ".lock")
    res <- tryCatch(filelock::lock(lock_path, timeout = 0),
                    error = function(e) NULL)
    if (!is.null(res)) {
      .logger_env$log_lock_release <- function() {
        tryCatch(filelock::unlock(res), error = function(e) NULL)
      }
      return(invisible(TRUE))
    }
  }
  invisible(FALSE)
}

#' Release the advisory log file lock acquired by \code{.acquire_log_lock()}
#' @keywords internal
.release_log_lock <- function() {
  if (is.function(.logger_env$log_lock_release)) {
    .logger_env$log_lock_release()
    .logger_env$log_lock_release <- NULL
  }
  invisible(NULL)
}

#' Log a message with real-time flush
#'
#' @param level Character. Log level.
#' @param ... Message components.
#' @param .flush Logical. Whether to flush immediately. Default: TRUE.
#' @param .module Character. Optional module/function tag for §15 error message
#'   format. When non-empty, inserted as \code{[MODULE]} between the level and
#'   the message. Example: \code{.module = "parse_taxonomy"}.
#' @keywords internal
log_message <- function(level, ..., .flush = TRUE, .module = NULL) {
  if (!.logger_env$enabled) return(invisible(NULL))

  # L-C5: explicit, one-time warning when an unknown log level is supplied,
  # then fall back to INFO (rather than silently coercing via level_to_num).
  valid_levels <- c("DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL")
  if (!toupper(level) %in% valid_levels) {
    if (!.logger_env$warn_unknown_level_issued) {
      .logger_env$warn_unknown_level_issued <- TRUE
      warning("Unknown log level '", level, "'; defaulting to INFO.",
              call. = FALSE, immediate. = TRUE)
    }
    level <- "INFO"
  }

  # A (regression fix): the effective threshold now also honours the
  # `rclade.log_level` global option (set by tests via
  # options(rclade.log_level = "WARNING")) so that callers can raise the
  # threshold without mutating the package-global .logger_env$level.
  # Invalid/unknown option values fall back to .logger_env$level; default
  # behaviour when the option is unset is unchanged.
  opt_level <- getOption("rclade.log_level", NULL)
  current_level <- if (!is.null(opt_level) && toupper(opt_level) %in% valid_levels) {
    toupper(opt_level)
  } else {
    .logger_env$level
  }
  current_level_num <- level_to_num(current_level)
  message_level_num <- level_to_num(level)

  if (message_level_num < current_level_num) return(invisible(NULL))

  timestamp <- format_timestamp()
  elapsed <- format_elapsed()
  step <- format_step()
  prefix <- get_level_prefix(level)

  msg <- paste0(...)

  # Format: TIMESTAMP | LEVEL | [MODULE] | MESSAGE
  # The [MODULE] tag is optional (§15). When absent, format is unchanged.
  if (!is.null(.module) && nzchar(.module)) {
    formatted <- sprintf("%s | %-8s | [%s] | %s", timestamp, level, .module, msg)
  } else {
    formatted <- sprintf("%s | %-8s | %s", timestamp, level, msg)
  }

  # Use message() for real-time output (not buffered like cat in some contexts)
  message(formatted)

  # Write to log file if configured. Wrap the write in an advisory file lock
  # (when filelock is available) so concurrent Rclade processes writing the
  # same log file do not produce interleaved/corrupted lines (L-C5).
  if (!is.null(.logger_env$log_con) && isOpen(.logger_env$log_con)) {
    .acquire_log_lock()
    on.exit(.release_log_lock(), add = TRUE)
    tryCatch({
      writeLines(formatted, .logger_env$log_con, sep = "\n")
      flush(.logger_env$log_con)
    }, error = function(e) NULL)
  }

  # Force flush to stdout
  if (.flush) {
    flush(stdout())
  }

  invisible(NULL)
}

#' Initialize step counter for progress tracking
#'
#' @param total Integer. Total number of steps.
#' @keywords internal
init_steps <- function(total) {
  .logger_env$step_counter <- 0
  .logger_env$step_total <- total
  .logger_env$start_time <- Sys.time()
  invisible(NULL)
}

#' Increment step counter
#'
#' @param step_name Character. Description of the step.
#' @keywords internal
next_step <- function(step_name = NULL) {
  .logger_env$step_counter <- .logger_env$step_counter + 1
  if (!is.null(step_name)) {
    log_info("Step %d/%d: %s", .logger_env$step_counter, .logger_env$step_total, step_name)
  }
  invisible(NULL)
}

# Public logging functions

#' Log a DEBUG message
#'
#' @param ... Message components (passed to sprintf if multiple).
#' @param .module Character. Optional module/function tag (§15). Default: NULL.
#' @keywords internal
log_debug <- function(..., .module = NULL) {
  args <- list(...)
  if (length(args) == 1) {
    log_message("DEBUG", args[[1]], .module = .module)
  } else {
    log_message("DEBUG", sprintf(...), .module = .module)
  }
}

#' Log an INFO message
#'
#' @param ... Message components (passed to sprintf if multiple).
#' @param .module Character. Optional module/function tag (§15). Default: NULL.
#' @keywords internal
log_info <- function(..., .module = NULL) {
  args <- list(...)
  if (length(args) == 1) {
    log_message("INFO", args[[1]], .module = .module)
  } else {
    log_message("INFO", sprintf(...), .module = .module)
  }
}

#' Log a WARNING message
#'
#' @param ... Message components (passed to sprintf if multiple).
#' @param .module Character. Optional module/function tag (§15). Default: NULL.
#' @keywords internal
log_warning <- function(..., .module = NULL) {
  args <- list(...)
  if (length(args) == 1) {
    log_message("WARNING", args[[1]], .module = .module)
  } else {
    log_message("WARNING", sprintf(...), .module = .module)
  }
}

#' Log an ERROR message
#'
#' @param ... Message components (passed to sprintf if multiple).
#' @param .module Character. Optional module/function tag (§15). Default: NULL.
#' @keywords internal
log_error <- function(..., .module = NULL) {
  args <- list(...)
  if (length(args) == 1) {
    log_message("ERROR", args[[1]], .module = .module)
  } else {
    log_message("ERROR", sprintf(...), .module = .module)
  }
}

#' Log a CRITICAL message
#'
#' @param ... Message components (passed to sprintf if multiple).
#' @param .module Character. Optional module/function tag (§15). Default: NULL.
#' @keywords internal
log_critical <- function(..., .module = NULL) {
  args <- list(...)
  if (length(args) == 1) {
    log_message("CRITICAL", args[[1]], .module = .module)
  } else {
    log_message("CRITICAL", sprintf(...), .module = .module)
  }
}

#' Print a formatted section header
#'
#' @param title Character. Section title.
#' @keywords internal
log_section <- function(title) {
  if (!.logger_env$enabled) return(invisible(NULL))

  width <- 60
  border <- paste(rep("=", width), collapse = "")
  padding <- floor((width - nchar(title) - 2) / 2)
  padded_title <- paste0(
    paste(rep(" ", padding), collapse = ""),
    title,
    paste(rep(" ", padding), collapse = "")
  )

  message(sprintf("\n%s", border))
  message(sprintf("  %s", padded_title))
  message(sprintf("%s\n", border))
  flush(stdout())
  invisible(NULL)
}

#' Print a formatted subsection header
#'
#' @param title Character. Subsection title.
#' @keywords internal
log_subsection <- function(title) {
  if (!.logger_env$enabled) return(invisible(NULL))

  width <- 50
  border <- paste(rep("-", width), collapse = "")
  message(sprintf("\n  %s", border))
  message(sprintf("  >> %s", title))
  message(sprintf("  %s", border))
  flush(stdout())
  invisible(NULL)
}

#' Log a key-value pair
#'
#' @param key Character. Key name.
#' @param value Any. Value to display.
#' @param level Character. Log level. Default: "INFO".
#' @keywords internal
log_keyvalue <- function(key, value, level = "INFO") {
  formatted_value <- if (is.null(value)) "NULL" else as.character(value)
  log_message(level, sprintf("%-25s: %s", key, formatted_value))
}

#' Log a progress indicator
#'
#' @param current Integer. Current progress.
#' @param total Integer. Total items.
#' @param item Character. Description of current item.
#' @keywords internal
log_progress <- function(current, total, item = "") {
  pct <- round(current / total * 100, 1)
  bar_width <- 30
  filled <- round(current / total * bar_width)
  bar <- paste0(
    "[",
    paste(rep("#", filled), collapse = ""),
    paste(rep(".", bar_width - filled), collapse = ""),
    "]"
  )
  log_info("%s %5.1f%% (%d/%d) %s", bar, pct, current, total, item)
}

#' Print summary statistics
#'
#' @param stats Named list of statistics.
#' @keywords internal
log_stats <- function(stats) {
  if (!.logger_env$enabled) return(invisible(NULL))

  max_key_len <- max(nchar(names(stats)))
  for (key in names(stats)) {
    value <- stats[[key]]
    formatted <- if (is.null(value)) "NULL" else as.character(value)
    log_info(sprintf("  %-*s: %s", max_key_len + 2, key, formatted))
  }
  invisible(NULL)
}

#' Start a timer for performance measurement
#'
#' @param name Character. Timer name.
#' @keywords internal
timer_start <- function(name) {
  if (is.null(.logger_env$timers)) {
    .logger_env$timers <- list()
  }
  .logger_env$timers[[name]] <- Sys.time()
  log_debug("Timer started: %s", name)
  invisible(NULL)
}

#' Stop a timer and log elapsed time
#'
#' @param name Character. Timer name.
#' @param level Character. Log level. Default: "INFO".
#' @return Numeric. Elapsed seconds.
#' @keywords internal
timer_stop <- function(name, level = "INFO") {
  if (is.null(.logger_env$timers) || is.null(.logger_env$timers[[name]])) {
    log_warning("Timer '%s' was not started", name)
    return(invisible(NA))
  }

  elapsed <- as.numeric(difftime(Sys.time(), .logger_env$timers[[name]], units = "secs"))
  .logger_env$timers[[name]] <- NULL

  if (elapsed < 1) {
    log_message(level, sprintf("Timer '%s': %.0f ms", name, elapsed * 1000))
  } else if (elapsed < 60) {
    log_message(level, sprintf("Timer '%s': %.2f s", name, elapsed))
  } else {
    mins <- floor(elapsed / 60)
    secs <- elapsed - mins * 60
    log_message(level, sprintf("Timer '%s': %dm %.2fs", name, mins, secs))
  }

  invisible(elapsed)
}

#' Print a formatted table
#'
#' @param data Named list or data.frame to display.
#' @param title Character. Optional table title.
#' @keywords internal
log_table <- function(data, title = NULL) {
  if (!.logger_env$enabled) return(invisible(NULL))

  if (!is.null(title)) {
    log_subsection(title)
  }

  if (is.data.frame(data)) {
    for (i in seq_len(nrow(data))) {
      row_text <- paste(names(data), "=", data[i, ], collapse = " | ")
      log_info("  Row %d: %s", i, row_text)
    }
  } else if (is.list(data)) {
    max_key_len <- max(nchar(names(data)))
    for (key in names(data)) {
      value <- data[[key]]
      formatted <- if (is.null(value)) "NULL" else
                   if (is.atomic(value) && length(value) == 1) as.character(value) else
                   paste0("[", class(value)[1], " length=", length(value), "]")
      log_info("  %-*s: %s", max_key_len + 2, key, formatted)
    }
  }

  invisible(NULL)
}

#' Log current memory usage at DEBUG level
#'
#' Attempts to report memory usage. Uses gc() for R memory stats.
#'
#' @param label Character. Label for the memory checkpoint.
#' @keywords internal
log_memory <- function(label = "") {
  if (level_to_num(.logger_env$level) > level_to_num("DEBUG")) return(invisible(NULL))

  gc_info <- gc(verbose = FALSE)
  total_mb <- round(sum(gc_info[, 2]) / 1024, 1)

  msg <- sprintf("Memory: %.1f MB used (approx)", total_mb)
  if (nchar(label) > 0) msg <- paste0(label, " - ", msg)

  log_debug(msg)
  invisible(NULL)
}
