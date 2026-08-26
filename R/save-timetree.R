# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Save, summarize, and session info functions

#' Save a timetree plot to file
#'
#' @param p ggplot object
#' @param file Output file path
#' @param width Width in inches
#' @param height Height in inches
#' @param dpi Resolution (for PNG/TIFF only)
#' @param overwrite Character. Overwrite mode: "ask" (default), "force", "no-clobber".
#' @return Invisibly returns the ggplot object
#' @export
save_timetree <- function(p, file, width = 14, height = 10, dpi = 300,
                          overwrite = "ask") {
  # Check if output file already exists
  if (file.exists(file)) {
    if (overwrite == "no-clobber") {
      log_info("Output file exists, skipping (--no-clobber): %s", file)
      return(invisible(p))
    } else if (overwrite == "ask") {
      if (interactive()) {
        ans <- readline(prompt = paste0("Output file exists: ", file,
                                        "\nOverwrite? (y/N): "))
        if (!tolower(ans) %in% c("y", "yes")) {
          log_info("Output skipped by user.")
          return(invisible(p))
        }
        log_info("Overwriting existing output file: %s", file)
      } else {
        # Non-interactive sessions have no user to prompt: downgrade "ask" to
        # "no-clobber" (skip, do not abort) so batch pipelines keep running (M-D5).
        log_warning("Output file already exists: %s (non-interactive session; overwrite='ask' downgraded to 'no-clobber', skipping).",
                    file, .module = "save-timetree/save_timetree")
        return(invisible(p))
      }
    } else if (overwrite == "force") {
      log_info("Overwriting existing output file: %s", file)
    }
  }

  # Ensure output directory exists
  out_dir <- dirname(file)
  if (out_dir != "." && !dir.exists(out_dir)) {
    dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
    log_debug("Created output directory: %s", out_dir)
  }

  ext <- tolower(tools::file_ext(file))
  device <- switch(ext,
    "pdf"  = "pdf",
    "png"  = "png",
    "tiff" = "tiff",
    "svg"  = "svg",
    "eps"  = "eps",
    {
      log_warning("Unsupported format '%s', defaulting to PDF.", ext,
                  .module = "save-timetree/save_timetree")
      "pdf"
    }
  )
  ggplot2::ggsave(file, plot = p, width = width, height = height,
                  device = device, dpi = dpi, limitsize = FALSE)
  invisible(p)
}

#' Print a summary of a Rclade timetree plot
#'
#' @param p ggplot object returned by plot_timetree() (with rclade_info attribute)
#' @return Invisibly returns the info list
#' @export
summarize_timetree <- function(p) {
  info <- attr(p, "rclade_info")
  if (is.null(info)) {
    cat("This object does not contain Rclade metadata. Use plot_timetree() to generate.\n")
    return(invisible(NULL))
  }

  msg <- "=== Rclade Timetree Summary ===\n"
  msg <- paste0(msg, "Input tips: ", info$n_tips, "\n")
  # v1.1.0 (reviewer issues 2/8): report the group-status breakdown. The old
  # single "Collapsed groups: n_groups" line mislabeled parsed candidates as
  # collapsed clades; the fields below distinguish every status class.
  if (!is.null(info$groups_collapsed)) {
    msg <- paste0(msg, "Groups parsed (total): ", info$groups_total, "\n")
    msg <- paste0(msg, "Groups collapsed: ", info$groups_collapsed, "\n")
    msg <- paste0(msg, "Singleton groups (1 tip, not collapsed): ",
                  info$groups_singleton, "\n")
    msg <- paste0(msg, "Skipped non-monophyletic groups: ",
                  info$groups_skipped_non_monophyletic, "\n")
    msg <- paste0(msg, "Skipped groups (root/zero-tip): ",
                  info$groups_skipped_other, "\n")
    if (length(info$skipped_non_monophyletic) > 0) {
      msg <- paste0(msg, "  non-monophyletic: ",
                    paste(info$skipped_non_monophyletic, collapse = ", "), "\n")
    }
    if (length(info$skipped_other) > 0) {
      msg <- paste0(msg, "  root/zero-tip: ",
                    paste(info$skipped_other, collapse = ", "), "\n")
    }
  } else {
    msg <- paste0(msg, "Collapsed groups: ", info$n_groups, "\n")
  }
  msg <- paste0(msg, "Displayed leaves after collapse: ", info$actual_ntips, "\n")
  msg <- paste0(msg, "Taxonomy format: ", info$taxonomy_format, "\n")
  msg <- paste0(msg, "Collapse rank: ", info$rank, "\n")
  msg <- paste0(msg, "Palette: ", info$palette, "\n")
  msg <- paste0(msg, "Layout: ", info$layout, "\n")
  msg <- paste0(msg, "Timescale: ", ifelse(info$add_timescale, "yes", "no"), "\n")

  if (info$n_groups > 0) {
    msg <- paste0(msg, "\nGroup details:\n")
    for (g in names(info$mrca_map)) {
      msg <- paste0(msg, sprintf("  %-30s  n=%d  node=%d\n",
                  g, info$mrca_map[[g]]$tip_count, info$mrca_map[[g]]$node))
    }
  }

  cat(msg)
  invisible(info)
}

#' Save sessionInfo() for reproducibility
#'
#' @param file Output file path (default "session_info.txt")
#' @return Invisibly returns sessionInfo
#' @export
save_session_info <- function(file = "session_info.txt") {
  info <- utils::sessionInfo()
  cat("=== R Session Info ===\n", file = file)
  utils::capture.output(info, file = file, append = TRUE)
  log_info("Session info saved to: %s", file)
  invisible(info)
}
