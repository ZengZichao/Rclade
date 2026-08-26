# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Parameter options constructor (P0-2B / route B1)
#
#' Construct a validated options list for \code{plot_timetree()}
#'
#' \code{rclade_options()} returns a named list of commonly used rendering
#' parameters that can be passed to \code{plot_timetree(opts = ...)} as a
#' single object.  Explicit arguments supplied directly to
#' \code{plot_timetree()} always take precedence over values in \code{opts}.
#'
#' This constructor is the first step toward parameter-surface convergence:
#' it provides a single validated source of truth for parameter defaults,
#' reducing the risk of drift between the \code{plot_timetree()} signature,
#' internal forwarding lists, and documentation.
#'
#' @param rank Character. Collapsing rank (e.g. "phylum", "class", "none").
#' @param layout Character. "rectangular" or "circular".
#' @param color_palette Character. Palette name (e.g. "viridis", "plasma", "Set1").
#' @param taxonomy_format Character. One of "auto", "GTDB", "Silva", "NCBI",
#'   "embedded", "custom_regex".
#' @param add_timescale Logical. Whether to add a geological timescale.
#' @param timescale_mode Character. "radial", "linear", "none".
#' @param unit Character or NULL. "Ma", "Ga", or NULL. Required when
#'   add_timescale = TRUE (the pipeline aborts for NULL); NULL leaves native
#'   units untouched and is only valid with add_timescale = FALSE.
#' @param legend_position Character. Legend placement (e.g. "bottom", "right", "none").
#' @param line_width Numeric. Branch line width.
#' @param show_tip_labels Logical. Whether to display tip labels.
#' @param width Numeric. Output width in inches.
#' @param height Numeric. Output height in inches.
#' @param ... Additional named parameters to include in the options list.
#'   These are passed through without validation.
#'
#' @return A named list of class \code{"rclade_options"} suitable for the
#'   \code{opts} argument of \code{plot_timetree()}.
#'
#' @examples
#' # Create a reusable options object
#' opts <- rclade_options(rank = "phylum", layout = "circular",
#'                        color_palette = "plasma", add_timescale = TRUE)
#'
#' # Use with plot_timetree (explicit args override opts)
#' \dontrun{
#' plot_timetree(tree, opts = opts)
#' plot_timetree(tree, opts = opts, layout = "rectangular")  # overrides layout
#' }
#'
#' @export
rclade_options <- function(
    rank = "none",
    layout = "rectangular",
    color_palette = "viridis",
    taxonomy_format = "auto",
    add_timescale = TRUE,
    timescale_mode = "radial",
    unit = NULL,
    legend_position = "bottom",
    line_width = 1,
    show_tip_labels = FALSE,
    width = 14,
    height = 10,
    ...
) {
  # Validate key parameters
  valid_layouts <- c("rectangular", "circular")
  if (!layout %in% valid_layouts) {
    stop("rclade_options: 'layout' must be one of: ",
         paste(valid_layouts, collapse = ", "), call. = FALSE)
  }

  valid_ts_modes <- c("radial", "linear", "none", "block", "background")
  if (!timescale_mode %in% valid_ts_modes) {
    stop("rclade_options: 'timescale_mode' must be one of: ",
         paste(valid_ts_modes, collapse = ", "), call. = FALSE)
  }

  if (!is.null(unit) && !unit %in% c("Ma", "Ga")) {
    stop("rclade_options: 'unit' must be 'Ma', 'Ga', or NULL", call. = FALSE)
  }

  opts <- list(
    rank = rank,
    layout = layout,
    color_palette = color_palette,
    taxonomy_format = taxonomy_format,
    add_timescale = add_timescale,
    timescale_mode = timescale_mode,
    unit = unit,
    legend_position = legend_position,
    line_width = line_width,
    show_tip_labels = show_tip_labels,
    width = width,
    height = height
  )

  # Merge additional parameters
  extra <- list(...)
  if (length(extra) > 0) {
    opts <- c(opts, extra)
  }

  structure(opts, class = "rclade_options")
}

#' Print method for rclade_options
#' @param x A \code{rclade_options} object.
#' @param ... Ignored.
#' @keywords internal
#' @export
print.rclade_options <- function(x, ...) {
  cat("Rclade options:\n")
  for (nm in names(x)) {
    val <- x[[nm]]
    if (is.null(val)) val <- "NULL"
    cat(sprintf("  %-20s = %s\n", nm, paste(val, collapse = ", ")))
  }
  invisible(x)
}
