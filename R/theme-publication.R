# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Publication-quality theme

#' Publication-ready theme for timetree plots
#'
#' Based on ggtree::theme_tree2(), customized for publication quality.
#' Includes \code{coord_cartesian(clip = "off")} to prevent collapsed clade
#' triangles from being clipped at the plot panel boundary — triangle vertices
#' (especially the MRCA node apex) often extend beyond the tip-based y-axis range.
#'
#' @param base_size Base font size
#' @return A \code{list} with components \code{theme} (ggplot2 theme) and
#'   \code{coord} (\code{coord_cartesian(clip = "off")}).  Callers should apply
#'   both via \code{p + result$theme + result$coord}.
#' @importFrom ggplot2 %+replace%
#' @export
theme_timetree <- function(base_size = 12) {
  # Get base theme from ggtree (returns a list in ggtree >= 4.0)
  base_theme_list <- ggtree::theme_tree2(base_size = base_size)

  # Convert list to proper theme object if needed
  if (is.list(base_theme_list) && !inherits(base_theme_list, "theme")) {
    base_theme <- do.call(ggplot2::theme, base_theme_list)
  } else {
    base_theme <- base_theme_list
  }

  # Apply customizations using %+replace%
  th <- base_theme %+replace%
    ggplot2::theme(
      panel.grid = ggplot2::element_blank(),
      axis.line.x = ggplot2::element_blank(),
      axis.ticks.x = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_blank(),
      plot.margin = ggplot2::margin(t = 20, r = 15, b = 5, l = 15, unit = "pt"),
      legend.title = ggplot2::element_text(size = base_size - 1, face = "bold"),
      legend.text = ggplot2::element_text(size = base_size - 2),
      legend.key.size = grid::unit(0.5, "cm")
    )

  # coord_cartesian(clip = "off") prevents collapsed triangle vertices from
  # being clipped at the panel edge.  ggtree::collapse() creates polygons whose
  # apex (V1 at MRCA node y-position) can lie outside the original tip-based
  # y-axis range, causing the top/bottom triangles to be partially cut off.
  coord_off <- ggplot2::coord_cartesian(clip = "off")

  list(theme = th, coord = coord_off)
}
