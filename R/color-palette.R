# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Color palette generation

#' Generate color mapping for taxonomic groups
#'
#' @param groups Character vector of group names
#' @param palette Palette name (e.g., "viridis", "Set1", "rainbow") or color vector
#' @param color_mapping Named vector of specific color assignments (highest priority)
#' @return Named color vector (names = groups)
#' @keywords internal
generate_colors <- function(groups, palette = "viridis", color_mapping = NULL) {
  n <- length(groups)
  if (n == 0) return(character(0))

  # Step 1: Generate base colors from palette
  base_colors <- if (is.character(palette) && length(palette) == 1) {
    # palette is a palette name
    if (palette == "viridis") {
      if (requireNamespace("viridisLite", quietly = TRUE)) {
        viridisLite::viridis(n)
      } else {
        log_warning("viridisLite not installed, using grDevices::hcl.colors() instead.",
                    .module = "color-palette/generate_colors")
        grDevices::hcl.colors(n, "viridis")
      }
    } else if (palette == "rainbow") {
      grDevices::rainbow(n)
    } else {
      if (!requireNamespace("RColorBrewer", quietly = TRUE)) {
        log_warning("RColorBrewer not installed, falling back to viridis.",
                    .module = "color-palette/generate_colors")
        if (requireNamespace("viridisLite", quietly = TRUE)) viridisLite::viridis(n)
        else grDevices::hcl.colors(n, "viridis")
      } else {
        tryCatch({
          max_colors <- RColorBrewer::brewer.pal.info[palette, "maxcolors"]
          if (n <= max_colors) {
            RColorBrewer::brewer.pal(max(3, n), palette)[seq_len(n)]
          } else {
            grDevices::colorRampPalette(RColorBrewer::brewer.pal(max_colors, palette))(n)
          }
        }, error = function(e) {
          log_warning("Cannot use palette '%s', falling back to viridis.", palette,
                      .module = "color-palette/generate_colors")
          if (requireNamespace("viridisLite", quietly = TRUE)) viridisLite::viridis(n)
          else grDevices::hcl.colors(n, "viridis")
        })
      }
    }
  } else if (is.character(palette) && length(palette) > 1) {
    # palette is a color vector
    if (length(palette) >= n) palette[seq_len(n)]
    else grDevices::colorRampPalette(palette)(n)
  } else {
    if (requireNamespace("viridisLite", quietly = TRUE)) viridisLite::viridis(n)
    else grDevices::hcl.colors(n, "viridis")
  }

  names(base_colors) <- groups

  # Step 2: Override with user-specified colors (highest priority)
  if (!is.null(color_mapping)) {
    for (g in names(color_mapping)) {
      if (g %in% groups) base_colors[g] <- color_mapping[g]
    }
  }

  return(base_colors)
}
