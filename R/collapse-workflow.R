# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Batch collapse workflow
#
# Includes custom geoms (GeomSegmentStraight, GeomPolygonStraight) that draw
# straight-edged primitives even in polar/radial coordinates.  Standard
# geom_segment / geom_polygon delegate to GeomPath, whose draw_panel() calls
# coord_munch() to interpolate straight lines into curves in polar coordinates
# — the root cause of curved collapse triangle edges in circular tree layout.
#
# Additionally, ggtree::collapse()'s geom_polygon layer uses fixed fill colours
# (passed as aes_params) that conflict with scale_fill_manual used for the
# legend, causing "No shared levels found" warnings and a missing legend.
#
# Fix for circular layout: call ggtree::collapse() with fill=NA, color=NA
# (invisible, data-modification only), then overlay GeomPolygonStraight and
# GeomSegmentStraight layers that draw the triangle fill and edges as straight
# primitives in Cartesian npc space.

# ggplot2's internal pt-per-mm constant (not exported)
.PT_PER_MM <- 72.27 / 25.4

# Version-compatibility guard: GeomPolygonStraight and GeomSegmentStraight
# depend on coord$transform() behaviour and ggplot2 internal constants
# (e.g. .PT_PER_MM).  These may change across ggplot2 / ggtree releases.
# The custom geoms were developed and tested with:
#   ggplot2 >= 3.5.0, ggtree == 4.0.4
# If the loaded ggtree major version differs from 4.x, or ggplot2 major
# version differs from 3.x/4.x, a warning is issued at package load time
# (see R/zzz.R).

# ---------------------------------------------------------------------------
# GeomSegmentStraight: straight line segments in polar/radial coords
# ---------------------------------------------------------------------------
# Transforms ONLY the endpoints via coord$transform() and draws a straight
# grid::segmentsGrob between them, bypassing coord_munch() interpolation.
#
# Colour is passed as a non-aesthetic parameter (segment_colour) to avoid
# conflict with scale_color_manual used for branch coloring on the plot.
GeomSegmentStraight <- ggplot2::ggproto(
  "GeomSegmentStraight", ggplot2::Geom,
  default_aes = ggplot2::aes(
    linewidth = 0.5, linetype = 1, alpha = 1
  ),
  required_aes = c("x", "y", "xend", "yend"),
  draw_panel = function(data, panel_params, coord, lineend = "butt",
                        segment_colour = "black", na.rm = FALSE) {
    data <- ggplot2::remove_missing(
      data, na.rm = na.rm, c("x", "y", "xend", "yend"),
      name = "geom_segment_straight"
    )
    if (nrow(data) == 0) return(grid::nullGrob())

    starts <- data
    ends <- data
    ends$x <- data$xend
    ends$y <- data$yend

    starts_t <- coord$transform(starts, panel_params)
    ends_t   <- coord$transform(ends,   panel_params)

    grid::segmentsGrob(
      x0 = starts_t$x, y0 = starts_t$y,
      x1 = ends_t$x,   y1 = ends_t$y,
      gp = grid::gpar(
        col = segment_colour,
        lwd = starts_t$linewidth * .PT_PER_MM,
        lty = starts_t$linetype,
        lineend = lineend
      )
    )
  }
)

geom_segment_straight <- function(mapping = NULL, data = NULL,
                                  stat = "identity", position = "identity",
                                  ..., segment_colour = "black",
                                  lineend = "butt", na.rm = FALSE,
                                  show.legend = NA, inherit.aes = TRUE) {
  ggplot2::layer(
    geom = GeomSegmentStraight, mapping = mapping, data = data,
    stat = stat, position = position,
    params = list(lineend = lineend, na.rm = na.rm,
                  segment_colour = segment_colour, ...),
    show.legend = show.legend, inherit.aes = inherit.aes
  )
}

# ---------------------------------------------------------------------------
# GeomPolygonStraight: straight-edged polygons in polar/radial coords
# ---------------------------------------------------------------------------
# Transforms ONLY the vertices via coord$transform() and draws a
# grid::polygonGrob with straight edges, bypassing coord_munch().
#
# Fill colour and alpha are passed as non-aesthetic parameters
# (polygon_fill, polygon_alpha) to avoid conflict with scale_fill_manual
# used for the legend.
GeomPolygonStraight <- ggplot2::ggproto(
  "GeomPolygonStraight", ggplot2::Geom,
  default_aes = ggplot2::aes(
    linewidth = 0.5, linetype = 1, alpha = 1
  ),
  required_aes = c("x", "y"),
  draw_panel = function(data, panel_params, coord,
                        polygon_fill = "grey50", polygon_alpha = 0.3,
                        na.rm = FALSE) {
    data <- ggplot2::remove_missing(
      data, na.rm = na.rm, c("x", "y"),
      name = "geom_polygon_straight"
    )
    if (nrow(data) == 0) return(grid::nullGrob())

    # Transform each vertex independently — the connecting edges become
    # straight chords in Cartesian npc space.
    data_t <- coord$transform(data, panel_params)

    # Draw one polygonGrob per group (each group = one triangle)
    # Fall back to a single group if group column is missing
    grp <- data_t$group
    if (is.null(grp)) grp <- rep(1L, nrow(data_t))
    grobs <- lapply(split(data_t, grp), function(sub) {
      grid::polygonGrob(
        x = sub$x,
        y = sub$y,
        gp = grid::gpar(
          fill = polygon_fill,
          alpha = polygon_alpha,
          col = NA  # No border — borders drawn by geom_segment_straight
        )
      )
    })

    do.call(grid::gList, grobs)
  }
)

geom_polygon_straight <- function(mapping = NULL, data = NULL,
                                  stat = "identity", position = "identity",
                                  ..., polygon_fill = "grey50",
                                  polygon_alpha = 0.3, na.rm = FALSE,
                                  show.legend = NA, inherit.aes = FALSE) {
  ggplot2::layer(
    geom = GeomPolygonStraight, mapping = mapping, data = data,
    stat = stat, position = position,
    params = list(na.rm = na.rm,
                  polygon_fill = polygon_fill,
                  polygon_alpha = polygon_alpha, ...),
    show.legend = show.legend, inherit.aes = inherit.aes
  )
}

# ---------------------------------------------------------------------------
# Triangle geometry helpers
# ---------------------------------------------------------------------------

# Compute the three triangle vertices for a clade about to be collapsed.
# Must be called BEFORE ggtree::collapse() because collapse() repositions
# descendant nodes in p$data.
# Returns a data.frame with columns: x, y  (3 rows per clade, ordered V1→V2→V3).
compute_collapse_vertices <- function(p, node_id, mode, tree = NULL) {
  d <- p$data
  node_row <- which(d$node == node_id)
  if (length(node_row) == 0) return(NULL)
  x_node <- d$x[node_row]
  y_node <- d$y[node_row]

  sp <- ggtree::get_clade_position(p, node_id)
  xmin <- sp$xmin; xmax <- sp$xmax

  # get_clade_position() uses a fixed 0.5 offset for ymin/ymax:
  #   sp$ymin = min(clade_tip_y) - 0.5, sp$ymax = max(clade_tip_y) + 0.5
  # After scaleClade() compresses the y range in circular layout, the fixed
  # 0.5 offset is far too large relative to the compressed tip spacing,
  # causing vertices to fall outside the coordinate scale range where they
  # are censored to NA by the scale's oob handler (and then removed by
  # remove_missing() in the geom).  Fix: replace the 0.5 offset with half
  # the actual (post-scaleClade) tip spacing so vertices stay in range.
  #
  # T03 (H3): the spacing must be computed from the CLADE'S OWN tips, not
  # from all global tips (d$y[d$isTip]).  Previously the global tip set was
  # used, so the offset was wrong whenever the tree contained tips outside
  # this clade.  We resolve the clade's descendant tip nodes via
  # phangorn::Descendants() when the tree is available and map them to the
  # data rows; only fall back to global tips when the tree is not supplied.
  clade_tip_y <- NULL
  if (!is.null(tree)) {
    clade_tips <- tryCatch(phangorn::Descendants(tree, node_id, "tips"),
                           error = function(e) NULL)
    if (!is.null(clade_tips) && length(clade_tips) > 0) {
      clade_rows <- which(d$node %in% clade_tips)
      if (length(clade_rows) > 0) clade_tip_y <- d$y[clade_rows]
    }
  }
  if (is.null(clade_tip_y) || length(clade_tip_y) == 0) {
    clade_tip_y <- d$y[d$isTip]
  }
  clade_tip_y <- clade_tip_y[!is.na(clade_tip_y)]
  if (length(clade_tip_y) > 1) {
    sorted_y <- sort(unique(clade_tip_y))
    tip_spacing <- if (length(sorted_y) > 1) median(diff(sorted_y)) else 1
  } else {
    tip_spacing <- 1
  }
  offset <- tip_spacing * 0.5
  ymin <- sp$ymin + 0.5 - offset  # = min(clade_tip_y) - offset
  ymax <- sp$ymax - 0.5 + offset  # = max(clade_tip_y) + offset

  # Triangle vertices (matching ggtree::collapse internal logic):
  #   max:    V1=(x_node,y_node)  V2=(xmax,ymin)  V3=(xmax,ymax)
  #   min:    V1=(x_node,y_node)  V2=(xmin,ymin)  V3=(xmin,ymax)
  #   mixed:  V1=(x_node,y_node)  V2=(xmin,ymin)  V3=(xmax,ymax)

  if (mode == "max") {
    data.frame(
      x = c(x_node, xmax, xmax),
      y = c(y_node, ymin, ymax),
      stringsAsFactors = FALSE
    )
  } else if (mode == "min") {
    data.frame(
      x = c(x_node, xmin, xmin),
      y = c(y_node, ymin, ymax),
      stringsAsFactors = FALSE
    )
  } else if (mode == "mixed") {
    data.frame(
      x = c(x_node, xmin, xmax),
      y = c(y_node, ymin, ymax),
      stringsAsFactors = FALSE
    )
  } else {
    NULL
  }
}

# Compute the three triangle-edge segments from vertices.
# Returns a data.frame with columns: x, y, xend, yend  (3 rows per clade).
compute_collapse_segments <- function(p, node_id, mode, tree = NULL) {
  verts <- compute_collapse_vertices(p, node_id, mode, tree = tree)
  if (is.null(verts)) return(NULL)

  # Three edges: V1→V2, V1→V3, V2→V3
  data.frame(
    x    = c(verts$x[1], verts$x[1], verts$x[2]),
    y    = c(verts$y[1], verts$y[1], verts$y[2]),
    xend = c(verts$x[2], verts$x[3], verts$x[3]),
    yend = c(verts$y[2], verts$y[3], verts$y[3]),
    stringsAsFactors = FALSE
  )
}

# ---------------------------------------------------------------------------
# Main collapse function
# ---------------------------------------------------------------------------

# Batch collapse taxonomic groups.
#
# For circular layout, ggtree::collapse() is called with fill=NA, color=NA
# (invisible polygon, data-modification only).  Straight-edged polygon fills
# and border segments are then overlaid via GeomPolygonStraight and
# GeomSegmentStraight, which bypass coord_munch() interpolation.
#
# Using fill=NA in ggtree::collapse() also prevents the polygon's fixed fill
# colour from conflicting with scale_fill_manual in the legend system.
#
# @param p ggplot object
# @param tree phylo object
# @param mrca_map Output of compute_mrca_map() (list of list(node, tip_count))
# @param mode Triangle mode: "max", "min", "mixed", "none"
# @param space_mode Space allocation: "equal", "proportional"
# @param colors Named color vector
# @param layout "rectangular" or "circular"
# @return ggplot object with attribute "actual_ntips"
# @keywords internal
collapse_by_groups <- function(p, tree, mrca_map, mode, space_mode, colors,
                               layout = "rectangular") {
  n <- length(mrca_map)
  if (n == 0) return(p)

  if (n > 10) {
    pb <- utils::txtProgressBar(min = 0, max = n, style = 3)
    on.exit(close(pb))
  }

  sorted_groups <- sort_by_depth(names(mrca_map), mrca_map, tree)

  # Step 1: scaleClade (all before any collapse, using depth-first order)
  if (space_mode == "equal") {
    for (g in sorted_groups) {
      node_id <- mrca_map[[g]]$node
      tip_count <- mrca_map[[g]]$tip_count
      if (tip_count > 1) {
        p <- ggtree::scaleClade(p, node = node_id, scale = 1 / tip_count,
                                vertical_only = TRUE)
      }
    }
  }

  # For circular layout: collect triangle vertices and edge segments to
  # overlay as straight primitives after all collapses are done.
  polygon_list <- list()
  segment_list  <- list()

  # For circular layout, always use "max" mode for triangle geometry.
  # In polar coordinates, "max" mode places both outer vertices at the same
  # radius (xmax), spanning the clade's angular range — this creates a proper
  # inward-pointing wedge.  "mixed" mode places vertices at opposite corners
  # (xmin,ymin) and (xmax,ymax), which in polar space creates a diagonal slash
  # that crosses adjacent clades' territory.  "min" mode creates an outward-
  # pointing wedge.  Only "max" produces the correct visual for circular.
  eff_mode <- if (layout == "circular" && mode != "none") "max" else mode

  # Step 2: collapse (deepest first to avoid inaccessible child nodes)
  for (i in seq_along(sorted_groups)) {
    g <- sorted_groups[i]
    node_id <- mrca_map[[g]]$node

    # For circular layout, compute triangle geometry BEFORE collapse
    # (collapse modifies p$data, repositioning descendant nodes).
    verts <- NULL
    segs  <- NULL
    if (layout == "circular" && mode != "none") {
      verts <- tryCatch(
        compute_collapse_vertices(p, node_id, eff_mode, tree = tree),
        error = function(e) {
          log_debug("Failed to compute vertices for node %d: %s",
                    node_id, e$message)
          NULL
        }
      )
      segs <- tryCatch(
        compute_collapse_segments(p, node_id, eff_mode, tree = tree),
        error = function(e) {
          log_debug("Failed to compute segments for node %d: %s",
                    node_id, e$message)
          NULL
        }
      )
    }

    # T04 (L-A3): compute the clade's fill / border colours ONCE and reuse them
    # for both the collapse polygon and the straight-primitive overlays.
    # Previously they were recomputed below (border_col / fill_col_full), which
    # risked drift between the two code paths.
    col <- colors[[g]]
    if (is.na(col) || is.null(col)) {
      fill_col <- "grey80"; border_col <- "grey40"
      log_warning("No color found for group '%s'; using grey fallback", g,
                  .module = "collapse-workflow/collapse_by_groups")
    } else {
      fill_col <- grDevices::adjustcolor(col, alpha.f = 0.3)
      border_col <- col
    }

    p <- tryCatch({
      if (layout == "circular" && mode != "none") {
        # Circular: call collapse with fill=NA, color=NA (invisible polygon,
        # data-modification only).  Straight-edged fill and borders are
        # overlaid below via GeomPolygonStraight / GeomSegmentStraight.
        # Using fill=NA avoids fixed fill colours conflicting with
        # scale_fill_manual in the legend system.
        # Use eff_mode ("max") for correct data repositioning in polar coords.
        ggtree::collapse(p, node = node_id, mode = eff_mode,
                         fill = NA, color = NA)
      } else {
        ggtree::collapse(p, node = node_id, mode = mode,
                         fill = fill_col, color = border_col)
      }
    }, error = function(e) {
      log_warning("Failed to collapse node %d for group '%s': %s",
                  node_id, g, e$message,
                  .module = "collapse-workflow/collapse_by_groups")
      p
    })

    # Collect vertex and segment data with the group's colours (reuse above)
    if (!is.null(verts) && nrow(verts) > 0) {
      verts$group <- i  # unique group per clade for polygon splitting
      verts$group_name <- g
      verts$fill_colour <- fill_col
      verts$border_colour <- border_col
      polygon_list[[length(polygon_list) + 1]] <- verts
    }
    if (!is.null(segs) && nrow(segs) > 0) {
      segs$colour <- border_col
      segment_list[[length(segment_list) + 1]] <- segs
    }

    if (n > 10) utils::setTxtProgressBar(pb, i)
  }

  # Step 3: overlay straight polygons and segments for circular layout.
  # Split by colour to add one layer per colour, using non-aesthetic
  # parameters (polygon_fill, segment_colour) to avoid conflict with
  # scale_fill_manual / scale_color_manual on the plot.
  if (layout == "circular") {
    if (length(polygon_list) > 0) {
      all_polys <- do.call(rbind, polygon_list)
      for (uc in unique(all_polys$fill_colour)) {
        poly_subset <- all_polys[all_polys$fill_colour == uc, , drop = FALSE]
        p <- p + geom_polygon_straight(
          data = poly_subset,
          ggplot2::aes(x = x, y = y, group = .data$group),
          polygon_fill = uc,
          polygon_alpha = 0.3,
          inherit.aes = FALSE
        )
      }
    }
    if (length(segment_list) > 0) {
      all_segments <- do.call(rbind, segment_list)
      for (uc in unique(all_segments$colour)) {
        seg_subset <- all_segments[all_segments$colour == uc, , drop = FALSE]
        p <- p + geom_segment_straight(
          data = seg_subset,
          ggplot2::aes(x = x, y = y, xend = xend, yend = yend),
          segment_colour = uc,
          linewidth = 0.5,
          inherit.aes = FALSE
        )
      }
    }
  }

  # Step 4: compute the number of displayed leaves after collapsing.
  # ggtree::collapse() sets the x/y of every hidden descendant (tips AND
  # internal nodes) to NA, while backbone internal nodes above the collapsed
  # MRCAs keep finite y.  Therefore the number of DISPLAYED leaves equals:
  #   (visible true tips, i.e. tips not swallowed by any collapsed clade)
  #   + (collapsed MRCA nodes, each rendered as one pseudo-leaf).
  # Simply counting finite-y rows over-counts by the number of visible
  # backbone internal nodes (verified: 5 phyla of example_tree collapsed to
  # 9 instead of the correct 5 before this fix).
  d <- p$data
  collapsed_nodes <- vapply(mrca_map, function(x) x$node, integer(1))
  visible_tips <- d$isTip & !is.na(d$y)
  visible_clade_nodes <- d$node %in% collapsed_nodes & !is.na(d$y)
  actual_ntips <- sum(visible_tips) + sum(visible_clade_nodes)
  attr(p, "actual_ntips") <- actual_ntips

  return(p)
}
