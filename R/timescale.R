# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Timescale and adaptive time break functions

#' Compute adaptive time breaks for x-axis
#'
#' @param x_min Minimum x value (negative, in Ma)
#' @param x_max Maximum x value (usually 0)
#' @return List with breaks, labels, unit_label
#' @keywords internal
compute_time_breaks <- function(x_min, x_max) {
  range_ma <- abs(x_max - x_min)

  # Strategy 1: Deep time (> 500 Ma) - use standard geological breaks
  if (range_ma > 500) {
    standard_breaks <- c(0, 66, 252, 538.8, 1000, 1600, 2500, 4000, 4567)
    neg_breaks <- -standard_breaks
    breaks <- neg_breaks[neg_breaks >= x_min & neg_breaks <= x_max]
    breaks <- sort(unique(breaks))
    if (length(breaks) == 0 || min(breaks) > x_min + range_ma * 0.05) {
      breaks <- sort(unique(c(x_min, breaks)))
    }
    # Supplement with pretty breaks if fewer than 5 standard breaks
    if (length(breaks) < 5) {
      pretty_breaks <- pretty(c(x_min, x_max), n = 6)
      breaks <- sort(unique(c(breaks, pretty_breaks)))
      breaks <- breaks[breaks >= x_min & breaks <= x_max]
    }
    labels <- as.character(abs(round(breaks, 1)))
    return(list(breaks = breaks, labels = labels, unit_label = "Time (Ma)"))
  }

  # Strategy 2: Medium time scale (1-500 Ma) - use pretty breaks
  if (range_ma >= 1) {
    p <- pretty(c(x_min, x_max), n = 6)
    return(list(breaks = p, labels = as.character(abs(p)), unit_label = "Time (Ma)"))
  }

  # Strategy 3: Short time scale (< 1 Ma) - use Ka units
  breaks_ka <- pretty(c(x_min * 1000, x_max * 1000), n = 6)
  return(list(
    breaks = breaks_ka / 1000,
    labels = as.character(abs(breaks_ka)),
    unit_label = "Time (Ka)"
  ))
}

#' Add geological timescale to a tree plot
#'
#' @param p ggplot object
#' @param tree phylo object (edge lengths in Ma)
#' @param levels Timescale levels vector, e.g., c("eras", "eons")
#' @param layout Layout type
#' @param version Geological timescale version. Default: "ICS 2023/02".
#' @return ggplot object
#' @keywords internal
add_geo_timescale <- function(p, tree, levels, layout, version = "ICS 2023/02",
                             actual_ntips = NULL, timescale_mode = "radial",
                             timescale_position = "right",
                             angle = 360, tree_start_position = "right") {
  if (layout != "rectangular" && layout != "circular") {
    log_warning("add_geo_timescale: unsupported layout '%s'; skipping geological timescale.",
                layout, .module = "timescale/add_geo_timescale")
    return(p + ggtree::theme_tree())
  }

  # Sanity: max tree depth should be within plausible geological time
  # (< 5000 Ma, the age of the Earth)
  max_depth <- max(ape::node.depth.edgelength(tree))
  if (is.na(max_depth) || max_depth <= 0 || max_depth > 5000) {
    log_warning("Tree max depth (%s) is outside plausible geological range (0-5000 Ma). Geological timescale may be misaligned. Ensure edge lengths are in Ma, or set add_timescale = FALSE.",
                round(max_depth, 1), .module = "timescale/add_geo_timescale")
  }

  if (!isTRUE(attr(p, "revts.done"))) {
    p <- ggtree::revts(p)
  }

  # Step 2: Compute x range from tree depth (no hardcoded values)
  x_min <- compute_x_min(tree)

  # Step 3: Prepare geological timescale data
  geo_data <- prepare_geo_timescales(version)
  dat_list <- list()
  for (lvl in levels) {
    dat <- switch(lvl,
      "eons"    = geo_data$eons,
      "eras"    = geo_data$eras,
      "periods" = geo_data$periods,
      stop("Unknown timescale level: '", lvl, "'", call. = FALSE)
    )
    dat_list <- c(dat_list, list(dat))
  }

  # Use actual_ntips (post-collapse) if available, otherwise fall back to Ntip
  n_tips <- if (!is.null(actual_ntips)) actual_ntips else ape::Ntip(tree)

  if (layout == "rectangular") {
    # Rectangular layout: use coord_geo with pos = "bottom"
    pos_list <- rep(list("bottom"), length(dat_list))

    # Step 4: ylim based on actual y range in the plot data
    # Collapsed clades may still occupy y-space beyond the post-collapse tip
    # count, so we read the real y-coordinates instead of guessing from n_tips.
    y_vals <- p$data$y[is.finite(p$data$y)]
    # Small top buffer for breathing room.  Collapsed-triangle vertices do not
    # actually exceed max(p$data$y) in rectangular layout (verified empirically),
    # and clip = "off" (below) prevents any clipping regardless, so the previous
    # 8% buffer only created a large blank band at the top of the panel.  A 1%
    # buffer keeps a slim margin without visible whitespace.
    y_max <- max(y_vals) + max(1, max(y_vals) * 0.01)

    # Step 5: coord_geo handles x-axis limits and geological labels.
    # clip = "off" keeps collapsed-clade triangle vertices from being clipped
    # at the panel boundary AND is applied here (rather than via a later
    # coord_cartesian) so the geological coordinate system is not overwritten.
    p <- p + deeptime::coord_geo(
      xlim = c(x_min, 0),
      ylim = c(0, y_max),
      height = grid::unit(1.5, "line"),
      neg = TRUE, abbrv = TRUE,
      clip = "off",
      dat = dat_list, pos = pos_list
    )

    p <- p + ggplot2::labs(x = "Time (Ma)")
  } else if (layout == "circular") {
    # ---- Circular layout ----
    #
    # coord_radial(theta = "y") maps y values to angles.  In ggplot2 4.x,
    # the theta→clock mapping is:
    #   theta = 0       → 12 o'clock
    #   theta = pi/2    → 3  o'clock
    #   theta = pi      → 6  o'clock
    #   theta = -pi/2   → 9  o'clock
    # Angles increase clockwise.  The r-axis guide (timescale) renders at
    # theta = start (the beginning of the arc), so choosing `start` also
    # chooses the clock position of the timescale.
    #
    #   tree_start_position   start (radians)   clock position
    #   -------------------   ----------------   --------------
    #   "top"    (12 o'clock)   0                12 o'clock
    #   "right"  ( 3 o'clock)   0.5 * pi         3  o'clock
    #   "bottom" ( 6 o'clock)   pi               6  o'clock
    #   "left"   ( 9 o'clock)  -0.5 * pi         9  o'clock
    #
    # The tree occupies the arc [start, start + angle_rad] and the gap
    # (where the timescale guide renders) occupies the remaining arc up to
    # start + 2*pi.

    pos_choices <- c("top", "right", "bottom", "left")
    tree_start_position <- match.arg(tree_start_position, pos_choices)
    timescale_position  <- match.arg(timescale_position,  pos_choices)

    # Consistency check: tree start position should match timescale position
    if (timescale_position != tree_start_position) {
      log_warning(
        "timescale_position ('%s') does not match tree_start_position ('%s'). The timescale axis will be drawn at a different clock position than where the tree starts expanding. Set tree_start_position = '%s' to align them.",
        timescale_position, tree_start_position, timescale_position,
        .module = "timescale/add_geo_timescale")
    }

    start_offset_map <- list(
      top    = 0,
      right  = 0.5 * pi,
      bottom = pi,
      left   = -0.5 * pi
    )
    coord_start <- start_offset_map[[tree_start_position]]

    angle_rad <- (angle / 360) * 2 * pi
    gap_size <- 2 * pi - angle_rad  # gap remaining after tree arc

    # guide_geo label rotation: the guide strip is rotated by coord_radial
    # to the start angle.  Strip rotation = rad2deg(-start).  To keep text
    # upright, the effective screen angle (rot + strip_rotation) must be
    # readable: ±90° for horizontal strips (top/bottom), 0° for vertical
    # strips (right/left).
    #   top    (start=0,     strip_rot=0°):    rot= 90  → effective= 90°
    #   right  (start=pi/2,  strip_rot=-90°):  rot= 90  → effective=  0°
    #   bottom (start=pi,    strip_rot=-180°): rot=-90  → effective=-90°
    #   left   (start=-pi/2, strip_rot=90°):   rot=-90  → effective=  0°
    geo_rot_map <- list(
      top    = 90,
      right  = 90,
      bottom = -90,
      left   = -90
    )

    if (timescale_mode == "linear") {
      # Linear mode: rectangular geological timescale axis (guide_geo stack)
      # at the gap position. No background colour bands.
      #
      # The radial axis guide renders in the angular gap between `end` and
      # `start + 2*pi`.  When angle = 360 the gap is zero, so we force a
      # minimum gap (0.15*pi ≈ 27°) to make room for the timescale axis.
      # The tree arc is shrunk accordingly.
      min_gap <- 0.15 * pi
      effective_gap <- max(gap_size, min_gap)
      tree_arc <- 2 * pi - effective_gap  # actual arc the tree occupies
      coord_end <- coord_start + tree_arc

      geo_rot <- geo_rot_map[[timescale_position]]
      time_info <- compute_time_breaks(x_min, 0)

      p <- p + ggplot2::coord_radial(
        theta = "y",
        start = coord_start,
        end = coord_end,
        expand = FALSE,
        r.axis.inside = TRUE,
        inner.radius = 0.3
      )

      geo_guides <- lapply(dat_list, function(dat) {
        deeptime::guide_geo(dat, neg = TRUE, rot = geo_rot, size = "auto",
                            abbrv = TRUE, height = grid::unit(1, "line"))
      })
      all_guides <- c(geo_guides, list(ggplot2::guide_axis()))
      stacked_guide <- do.call(
        ggplot2::guide_axis_stack,
        c(all_guides, list(spacing = grid::unit(0, "line")))
      )

      p <- p + ggplot2::scale_x_continuous(
        name = NULL,
        breaks = time_info$breaks,
        labels = time_info$labels,
        expand = ggplot2::expansion(mult = c(0.05, 0)),
        guide = stacked_guide
      )
    } else {
      # Radial mode: full circular geological background bands via
      # coord_geo_radial.  The start/end arc follows tree_start_position
      # and angle so the coloured bands match the tree's angular extent.
      # When angle = 360 the bands cover the full circle (no gap).
      p <- p + deeptime::coord_geo_radial(
        dat = dat_list,
        theta = "y",
        start = coord_start,
        end = coord_start + angle_rad,
        expand = FALSE,
        neg = TRUE,
        abbrv = TRUE,
        r.axis.inside = TRUE,
        inner.radius = 0.3,
        clip = "off"
      )
    }
  }

  return(p)
}

#' Add geological event bands (e.g., GOE, NOE) to a tree plot
#'
#' Events are drawn as semi-transparent vertical bands covering the full
#' vertical extent of the tree (but not the geological timescale panels).
#'
#' @param p ggplot object
#' @param tree phylo object (edge lengths in Ma)
#' @param events Event specification. Can be:
#'   \itemize{
#'     \item \code{NULL} (default): shows built-in events (GOE = 2400–2000 Ma,
#'       NOE = 800–550 Ma).
#'     \item A \code{data.frame} with columns \code{name}, \code{age_min} (Ma),
#'       \code{age_max} (Ma), and optionally \code{color}.
#'     \item A \code{list} of named lists, each with elements \code{name},
#'       \code{age_min}, \code{age_max}, and optionally \code{color}.
#'     \item A named \code{list} with a single event (shorthand).
#'   }
#'   If only \code{age} is provided (instead of \code{age_min}/\code{age_max}),
#'   a default bandwidth of \code{+/- 200 Ma} is used.
#' @return ggplot object
#' @keywords internal
add_geo_events <- function(p, tree, events = NULL) {
  # --- Normalise input to a data.frame ----------------------------------------
  if (is.null(events)) {
    events <- data.frame(
      name = c("GOE", "NOE"),
      age_min = c(2400, 800),
      age_max = c(2000, 550),
      color = c("#2E5AAC", "#2E8B57"),
      stringsAsFactors = FALSE
    )
  } else if (is.list(events) && !is.data.frame(events)) {
    # List of events (either a single named list or a list of named lists)
    if (all(c("name", "age_min", "age_max") %in% names(events))) {
      # Single event passed as a named list
      events <- list(events)
    }
    # Convert list of lists to data.frame
    events <- do.call(rbind, lapply(events, function(ev) {
      as.data.frame(ev, stringsAsFactors = FALSE)
    }))
  }

  # Ensure required columns exist
  if (!("age_min" %in% names(events)) && "age" %in% names(events)) {
    events$age_min <- events$age + 200
    events$age_max <- events$age - 200
  }
  if (!all(c("age_min", "age_max") %in% names(events))) {
    log_warning("geo_events must contain 'age_min' and 'age_max' (or 'age') columns.",
                .module = "timescale/add_geo_events")
    return(p)
  }

  # Provide defaults for optional columns
  if (!"name" %in% names(events)) {
    events$name <- paste("Event", seq_len(nrow(events)))
  }
  if (!"color" %in% names(events)) {
    events$color <- grDevices::hcl.colors(nrow(events), palette = "viridis")
  }

  x_min <- compute_x_min(tree)

  # Convert ages to plot x coordinates (negative since revts was applied)
  events$xmin <- -events$age_min
  events$xmax <- -events$age_max

  # Filter events that overlap with the visible tree time range [x_min, 0]
  events <- events[
    events$xmin <= 0 & events$xmax >= x_min,
    , drop = FALSE
  ]
  if (nrow(events) == 0) return(p)

  # Clamp to visible x range so rectangles don't exceed plot bounds
  events$xmin <- pmax(events$xmin, x_min)
  events$xmax <- pmin(events$xmax, 0)

  # y range: cover the tree but stop before the geo timescale panels.
  # Use the actual plotted y-extent (M-D1) rather than the raw tip count, since
  # collapsed clades / polytomies shift y-coordinates away from Ntip(tree).
  y_vals <- p$data$y[is.finite(p$data$y)]
  y_max <- if (length(y_vals) > 0) max(y_vals) else ape::Ntip(tree)

  for (i in seq_len(nrow(events))) {
    p <- p + ggplot2::annotate(
      "rect",
      xmin = events$xmin[i],
      xmax = events$xmax[i],
      ymin = -0.5,
      ymax = Inf,
      fill = events$color[i],
      alpha = 0.12
    )

    # Horizontal label placed just above the tree (outside the branch area)
    band_centre <- (events$xmin[i] + events$xmax[i]) / 2
    label_y <- y_max + max(0.5, y_max * 0.015)  # small fixed offset above tree top
    p <- p + ggplot2::annotate(
      "text",
      x = band_centre,
      y = label_y,
      label = events$name[i],
      color = events$color[i],
      angle = 0,        # horizontal
      vjust = 0.5,
      hjust = 0.5,
      size = 3,
      fontface = "bold"
    )
  }

  return(p)
}
