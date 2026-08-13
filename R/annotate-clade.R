# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Clade annotation labels

utils::globalVariables(c("x", "y", "label", "xend", "yend", "Group"))

#' Add clade labels next to collapsed triangles
#'
#' Supports both rectangular and circular (fan) layouts.
#' For rectangular: labels are at the tips' x-position, extending rightward.
#' For circular: labels are at the tips' x-position (outer radius),
#'   angled along the MRCA's angular position, extending outward.
#'
#' @param p ggplot object
#' @param tree phylo object
#' @param mrca_map Output of compute_mrca_map()
#' @param colors Named color vector
#' @param show_count Whether to show species count
#' @param offset Offset from the tree's right edge (tips).
#'   Default 0 places labels right at the tip line.
#' @param fontsize Font size for labels (default 3)
#' @param singleton_map Optional named list mapping single-species group names
#'   to their tip label. When provided, these tips are also labeled.
#' @return ggplot object
#' @keywords internal
annotate_clade <- function(p, tree, mrca_map, colors, show_count = TRUE,
                           offset = 0, fontsize = 3, singleton_map = NULL) {
  if (offset < 0 || offset > 5000) {
    log_warning("clade_label_offset should be between 0 and 5000, got %s. Using default 0.",
                offset, .module = "annotate-clade")
    offset <- 0
  }

  if (fontsize < 1 || fontsize > 20) {
    log_warning("fontsize should be between 1 and 20, got %s. Using default 3.",
                fontsize, .module = "annotate-clade")
    fontsize <- 3
  }

  d <- p$data
  groups <- names(mrca_map)

  # Detect layout: circular/fan layouts use coord_polar internally.
  # T05 / L-D3: also treat deeptime radial coordinate systems (class names
  # containing "geo"/"radial") as circular so that angular label placement
  # applies for timescale_mode="radial" on circular trees.
  coord_class <- class(p$coordinates)
  is_circular <- inherits(p$coordinates, "CoordPolar") ||
    any(grepl("polar|radial", coord_class, ignore.case = TRUE))

  # For rectangular: tips are at x = 0 after revts(), labels extend rightward.
  # For circular: x = radius, y = angle. Labels at outer radius (tips' x),
  #   at MRCA's angle, angled to follow the arc.
  tip_x <- d$x[d$isTip]
  x_rightmost <- if (length(tip_x) > 0 && any(!is.na(tip_x))) {
    max(tip_x, na.rm = TRUE)
  } else {
    0
  }
  x_label <- x_rightmost + offset

  label_rows <- list()

  # Helper to add a label row
  add_label <- function(g, n_tips, y_pos, color, is_singleton = FALSE) {
    display_name <- paste0(toupper(substr(g, 1, 1)), substring(g, 2))
    if (is_singleton) {
      label_text <- if (show_count) paste0(display_name, " (n=1)") else display_name
    } else {
      label_text <- if (show_count) paste0(display_name, " (n=", n_tips, ")") else display_name
    }
    if (is_circular) {
      data.frame(
        x = x_label,
        y = y_pos,
        label = label_text,
        color = color,
        angle = y_pos - 90,
        stringsAsFactors = FALSE
      )
    } else {
      data.frame(
        x = x_label,
        y = y_pos,
        label = label_text,
        color = color,
        angle = 0,
        stringsAsFactors = FALSE
      )
    }
  }

  # Labels for collapsed clades
  for (g in groups) {
    node_id <- mrca_map[[g]]$node
    n_tips <- mrca_map[[g]]$tip_count
    mrca_row <- which(d$node == node_id)
    if (length(mrca_row) == 0) next
    col <- colors[g]
    if (is.na(col)) col <- "grey40"
    label_rows[[length(label_rows) + 1]] <- add_label(g, n_tips, d$y[mrca_row[1]], col)
  }

  # Labels for single-species groups (singletons)
  if (!is.null(singleton_map) && length(singleton_map) > 0) {
    for (g in names(singleton_map)) {
      if (!(g %in% names(colors))) next
      tip_label <- singleton_map[[g]]
      tip_row <- which(d$isTip & d$label == tip_label)
      if (length(tip_row) == 0) next
      label_rows[[length(label_rows) + 1]] <- add_label(g, 1, d$y[tip_row[1]], colors[g], is_singleton = TRUE)
    }
  }

  if (length(label_rows) > 0) {
    label_df <- do.call(rbind, label_rows)
    p <- p + ggplot2::geom_text(
      data = label_df,
      ggplot2::aes(x = x, y = y, label = label, angle = .data$angle),
      color = label_df$color,
      hjust = 0,
      vjust = 0.5,
      size = fontsize,
      fontface = "bold",
      inherit.aes = FALSE
    )
  }

  return(p)
}
