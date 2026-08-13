# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Smart legend system

utils::globalVariables(c("x", "y", "Group"))

#' Compute legend row/column layout
#'
#' @param n_groups Number of groups
#' @param position Position ("right", "left", "top", "bottom", "inside")
#' @param nrow User-specified rows (can be NULL)
#' @param ncol User-specified columns (can be NULL)
#' @return list(nrow = integer, ncol = integer)
#' @keywords internal
compute_legend_layout <- function(n_groups, position, nrow, ncol) {
  if (n_groups <= 0) return(list(nrow = 0, ncol = 0))

  # User specified both nrow and ncol
  if (!is.null(nrow) && !is.null(ncol)) {
    if (nrow * ncol < n_groups) {
      log_warning("Legend grid (%dx%d = %d) is insufficient for %d groups. Auto-adjusting.",
                  nrow, ncol, nrow * ncol, n_groups,
                  .module = "legend-smart/compute_legend_layout")
      ncol <- ceiling(n_groups / nrow)
    }
    return(list(nrow = nrow, ncol = ncol))
  }

  # Only nrow specified
  if (!is.null(nrow)) {
    return(list(nrow = nrow, ncol = ceiling(n_groups / nrow)))
  }

  # Only ncol specified
  if (!is.null(ncol)) {
    return(list(nrow = ceiling(n_groups / ncol), ncol = ncol))
  }

  # Auto-compute
  if (position %in% c("top", "bottom")) {
    # For bottom/top, prefer a single row if possible; cap at 6 per row
    ncol <- min(n_groups, 6)
    nrow <- ceiling(n_groups / ncol)
  } else if (position %in% c("left", "right")) {
    nrow <- min(n_groups, 15)
    ncol <- ceiling(n_groups / nrow)
  } else {
    # "inside" or other
    ncol <- ceiling(sqrt(n_groups))
    nrow <- ceiling(n_groups / ncol)
  }

  return(list(nrow = nrow, ncol = ncol))
}

#' Add smart legend to a tree plot
#'
#' @param p ggplot object
#' @param colors Named color vector
#' @param rank_name Display name for the rank
#' @param position Position: cardinal direction or length-2 numeric vector
#' @param nrow User-specified rows
#' @param ncol User-specified columns
#' @return ggplot object
#' @keywords internal
add_smart_legend <- function(p, colors, rank_name, position, nrow, ncol) {
  n_groups <- length(colors)

  # Parse position
  if (is.numeric(position) && length(position) == 2) {
    legend_position <- "inside"
    legend_x <- position[1]
    legend_y <- position[2]
  } else if (is.character(position) && length(position) == 1) {
    legend_position <- match.arg(position, c("right", "left", "top", "bottom", "none"))
    legend_x <- NULL
    legend_y <- NULL
  } else {
    log_warning("Invalid legend_position argument. Using 'right'.",
                .module = "legend-smart/add_smart_legend")
    legend_position <- "right"
    legend_x <- NULL
    legend_y <- NULL
  }

  if (legend_position == "none") return(p)

  # Compute layout
  lay <- compute_legend_layout(n_groups, legend_position, nrow, ncol)

  # Add invisible geom_point layer to drive the fill legend.
  # ggtree::collapse() hard-codes fill colours in aes_params rather than
  # mapping them, so scale_fill_manual cannot detect them automatically.
  # A transparent point at (-Inf, -Inf) registers the fill aesthetic without
  # affecting the visible plot.
  dummy_df <- data.frame(
    x = -Inf,
    y = -Inf,
    Group = names(colors),
    stringsAsFactors = FALSE
  )
  p <- p + ggplot2::geom_point(
    data = dummy_df,
    ggplot2::aes(x = x, y = y, fill = Group),
    alpha = 0,
    inherit.aes = FALSE,
    shape = 22,
    size = 0
  )

  # Create discrete fill scale with native ggplot2 mechanism
  p <- p + ggplot2::scale_fill_manual(
    values = colors,
    name = rank_name,
    guide = ggplot2::guide_legend(
      ncol = lay$ncol,
      nrow = lay$nrow,
      override.aes = list(size = 5, alpha = 1)
    )
  )

  # Apply theme
  if (legend_position == "inside") {
    # M-D2: ggplot2 >= 3.5 supports legend.position = "inside" with explicit
    # coordinates via legend.position.inside = c(x, y). On older ggplot2 we
    # fall back to normalised panel coordinates.
    theme_args <- list(
      legend.title = ggplot2::element_text(size = 10, face = "bold"),
      legend.text = ggplot2::element_text(size = 8),
      legend.key.size = grid::unit(0.5, "cm"),
      legend.background = ggplot2::element_blank()
    )
    if (utils::packageVersion("ggplot2") >= "3.5.0") {
      theme_args$legend.position <- "inside"
      theme_args$legend.position.inside <- c(legend_x, legend_y)
    } else {
      theme_args$legend.position <- c(legend_x, legend_y)
    }
    p <- p + do.call(ggplot2::theme, theme_args)
  } else {
    p <- p + ggplot2::theme(
      legend.position = legend_position,
      legend.title = ggplot2::element_text(size = 10, face = "bold"),
      legend.text = ggplot2::element_text(size = 8),
      legend.key.size = grid::unit(0.5, "cm"),
      legend.background = ggplot2::element_blank()
    )
  }

  return(p)
}

#' Extract legend as separate grob and combine with patchwork
#'
#' @param p ggplot object
#' @param ncol_split Number of columns for legend splitting (used for reflow)
#' @return patchwork object. Note: This returns a patchwork object, not a ggplot object.
#'   You cannot add ggplot2 layers with \code{+} after calling \code{split_legend()}.
#'   Use patchwork operators like \code{|} and \code{/} for layout composition.
#' @keywords internal
split_legend <- function(p, ncol_split = 2) {
  if (!requireNamespace("cowplot", quietly = TRUE)) {
    stop("Please install cowplot for legend splitting: install.packages('cowplot')",
         call. = FALSE)
  }
  if (!requireNamespace("patchwork", quietly = TRUE)) {
    stop("Please install patchwork for legend splitting: install.packages('patchwork')",
         call. = FALSE)
  }

  # Use standard ggplot2 guide system to set ncol
  p <- p + ggplot2::guides(fill = ggplot2::guide_legend(ncol = ncol_split))

  legend_grob <- cowplot::get_legend(p)
  p_no_legend <- p + ggplot2::theme(legend.position = "none")
  p_no_legend + patchwork::wrap_elements(legend_grob)
}
