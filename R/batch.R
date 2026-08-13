# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Batch processing

#' Batch plot timetrees from a directory of tree files
#'
#' @param input_dir Input directory containing tree files
#' @param output_dir Output directory for plots
#' @param pattern File matching pattern (glob format, e.g., "*.tre")
#' @param format Output format: "pdf", "png", "tiff", "svg", "eps" (default "pdf")
#' @param width Output width in inches (default 14)
#' @param height Output height in inches (default 10)
#' @param overwrite Overwrite mode: "ask" (default), "force", or "no-clobber"
#' @param ignore_malformed Logical. If \code{TRUE}, malformed tree inputs are
#'   skipped (with a warning) instead of aborting the whole batch, aligned with
#'   the CLI's \code{--ignore_malformed} flag. Default: \code{FALSE}.
#' @param ... Additional arguments passed to plot_timetree()
#' @return Invisibly returns list of success/failure status
#' @export
batch_plot <- function(input_dir, output_dir, pattern = "*.tre", format = "pdf",
                       width = 14, height = 10, overwrite = "ask",
                       ignore_malformed = FALSE, ...) {
  if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)
  regex_pattern <- utils::glob2rx(pattern)
  files <- list.files(input_dir, pattern = regex_pattern, full.names = TRUE)

  if (length(files) == 0) {
    log_info("No files matching '%s' found in %s", pattern, input_dir)
    return(invisible(list()))
  }

  # Validate format
  valid_formats <- c("pdf", "png", "tiff", "svg", "eps")
  if (!format %in% valid_formats) {
    stop("Invalid format '", format, "'. Must be one of: ",
         paste(valid_formats, collapse = ", "), call. = FALSE)
  }

  log_info("Processing %d files...", length(files))

  # Use progress bar if more than 3 files
  use_pb <- length(files) > 3
  if (use_pb) {
    pb <- utils::txtProgressBar(min = 0, max = length(files), style = 3)
    on.exit(close(pb))
  }

  results <- batch_with_interrupt(
    items = seq_along(files),
    fun = function(i, idx) {
      f <- files[i]
      out <- file.path(output_dir,
                       paste0(tools::file_path_sans_ext(basename(f)), ".", format))
      result <- tryCatch({
        # Merge dots explicitly so a user-supplied ignore_malformed in ...
        # overrides the function argument instead of causing a duplicate
        # formal-argument match error in plot_timetree().
        call_args <- utils::modifyList(
          list(ignore_malformed = ignore_malformed),
          list(...)
        )
        p <- do.call(plot_timetree, c(list(f), call_args))
        save_timetree(p, out, width = width, height = height, overwrite = overwrite)
        log_info("Done: %s -> %s", basename(f), basename(out))
        TRUE
      }, error = function(e) {
        log_warning("Failed: %s: %s", basename(f), e$message,
                    .module = "batch/batch_plot")
        FALSE
      })
      if (use_pb) utils::setTxtProgressBar(pb, i)
      result
    }
  )

  n_success <- sum(vapply(results, isTRUE, logical(1)))
  log_info("Batch complete: %d/%d succeeded.", n_success, length(files))
  invisible(results)
}
