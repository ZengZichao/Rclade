# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Internal utility functions for Rclade

#' @importFrom stats complete.cases median na.omit setNames
#' @importFrom utils data head
utils::globalVariables("example_tree")

#' Default margin factor for x-axis range extension
#'
#' Extends the x-axis range by 5% beyond the tree depth to prevent
#' tip labels from being clipped at the plot boundary.
#' Source: ICS chronostratigraphic chart convention for visual padding.
#' @keywords internal
RCLADE_X_MARGIN_FACTOR <- 1.05

#' Minimum x-axis value used when the tree root reaches into the Hadean
#' (4567–4031 Ma), so the full Hadean eon is visible in that case
#' @keywords internal
RCLADE_X_MIN_FLOOR <- -4567

#' End of the Hadean eon / start of the Archean eon (Ma, ICS 2023/02)
#' @keywords internal
RCLADE_HADEAN_END <- 4031

#' Compute x-axis minimum from tree depth
#'
#' Calculates the leftmost x-axis value by finding the maximum tree depth
#' and applying a 5% margin extension for visual clarity.  The axis range is
#' \strong{adaptive}: for trees whose root is younger than the end of the
#' Hadean eon (4031 Ma), the axis starts slightly beyond the root so the tree
#' occupies the full panel width.  Only when the root reaches into the Hadean
#' is the axis floored at -4567 Ma, so the entire Hadean eon is shown exactly
#' when it is relevant.
#'
#' @param tree phylo object with edge lengths
#' @return Negative x_min value (in same units as edge lengths, typically Ma)
#' @keywords internal
compute_x_min <- function(tree) {
  # T01 (H1): without edge.length (cladogram / branch.length = "none"),
  # ape::node.depth.edgelength returns NULL and max(NULL) fails.  Fall back to
  # the Hadean floor constant, consistent with build_base_tree("none"), so
  # downstream scale_x_continuous receives a finite value.
  if (is.null(tree$edge.length)) {
    return(RCLADE_X_MIN_FLOOR)
  }
  max_height <- max(ape::node.depth.edgelength(tree))
  x_min <- -max_height * RCLADE_X_MARGIN_FACTOR
  # Adaptive Hadean coverage: only extend the axis to the full Hadean when
  # the tree root actually reaches into it (older than the Archean boundary).
  if (max_height >= RCLADE_HADEAN_END) {
    x_min <- min(x_min, RCLADE_X_MIN_FLOOR)
  }
  x_min
}

#' Normalize rank abbreviation to full name
#' @param rank Rank code or full name ("k","d","p","c","o","f","g","s","ss" or "kingdom","domain","phylum",...)
#' @return Standardized full name string
#' @keywords internal
normalize_rank <- function(rank) {
  rank_map <- c("k" = "kingdom", "d" = "domain", "p" = "phylum", "c" = "class",
                "o" = "order", "f" = "family", "g" = "genus", "s" = "species",
                "ss" = "subspecies", "none" = "none")
  if (rank %in% names(rank_map)) return(unname(rank_map[rank]))
  return(rank)
}

#' Get display name for a taxonomic rank
#' @param rank Taxonomic rank (abbreviation or full name)
#' @return Display name string
#' @keywords internal
get_rank_name <- function(rank) {
  rank_std <- normalize_rank(rank)
  display_names <- c("kingdom" = "Kingdom", "domain" = "Domain", "phylum" = "Phylum",
                     "class" = "Class", "order" = "Order", "family" = "Family",
                     "genus" = "Genus", "species" = "Species", "subspecies" = "Subspecies",
                     "none" = "Taxa")
  if (rank_std %in% names(display_names)) return(unname(display_names[rank_std]))
  return(rank_std)
}

#' Create base tree plot based on layout type
#' @param tree phylo object
#' @param layout Layout type: "rectangular" or "circular"
#' @param angle Fan angle for circular layout
#' @param line_width Branch line width
#' @param branch.length Branch length mode passed to ggtree. Use "none" to draw
#'   a cladogram where all tips are aligned (ignoring original branch lengths).
#'   Default: "branch.length" (use original edge lengths).
#' @return ggplot object
#' @keywords internal
build_base_tree <- function(tree, layout, angle, line_width, branch.length = "branch.length") {
  if (layout == "circular") {
    open_angle <- if (angle >= 360) 0 else 360 - angle
    ggtree::ggtree(tree, layout = "fan", open.angle = open_angle,
                   linewidth = line_width, branch.length = branch.length)
  } else {
    ggtree::ggtree(tree, layout = "rectangular", linewidth = line_width,
                   branch.length = branch.length)
  }
}

#' Convert time units (Ga -> Ma)
#' @param tree phylo object
#' @param unit Time unit "Ga" or "Ma"
#' @return Modified phylo object (copy, original unchanged)
#' @keywords internal
convert_unit <- function(tree, unit) {
  if (is.null(unit)) return(tree)
  if (unit == "Ga") {
    log_info("Input unit is Ga, converting to Ma (x1000)")
    new_tree <- tree
    new_tree$edge.length <- tree$edge.length * 1000
    return(new_tree)
  }
  return(tree)
}

#' Load internal geological timescale data
#'
#' Tries deeptime::get_scale_data() first, falls back to internal sysdata.
#' Ensures Hadean eon is included.
#'
#' @param version Geological timescale version string. Currently supported:
#'   \code{"ICS 2023/02"}. Default: \code{"ICS 2023/02"}.
#' @return List with eons, eras, periods data frames
#' @keywords internal
prepare_geo_timescales <- function(version = "ICS 2023/02") {
  if (version != "ICS 2023/02") {
    log_warning("Only 'ICS 2023/02' is currently supported. Using ICS 2023/02.",
                .module = "aaa-utils")
    version <- "ICS 2023/02"
  }

  geo_data <- tryCatch({
    list(
      eons    = deeptime::get_scale_data("eons"),
      eras    = deeptime::get_scale_data("eras"),
      periods = deeptime::get_scale_data("periods")
    )
  }, error = function(e) {
    list(eons = geo_eons, eras = geo_eras, periods = geo_periods)
  })

  # Apply version-specific adjustments
  if (version == "ICS 2023/02") {
    # Ensure Hadean is included in eons (deeptime may omit it).
    # NOTE: Hadean is an EON; the ICS does not define eras within it, so it
    # must NOT be injected into the eras table (doing so produced a duplicated
    # "Hadean" label on the era row of timescale strips).
    if (!"Hadean" %in% geo_data$eons$name) {
      Hadean <- data.frame(
        name = "Hadean", abbr = "Hadean",
        max_age = 4567, min_age = 4031,
        color = "#B41E8D", lab_color = "white",
        stringsAsFactors = FALSE
      )
      geo_data$eons <- rbind(geo_data$eons, Hadean)
    }
  }

  # Ensure numeric columns
  for (nm in c("eons", "eras", "periods")) {
    geo_data[[nm]]$max_age <- as.numeric(geo_data[[nm]]$max_age)
    geo_data[[nm]]$min_age <- as.numeric(geo_data[[nm]]$min_age)
  }

  # Add version metadata
  attr(geo_data, "ics_version") <- version
  log_info("Using geological timescale data based on %s. Note: ICS updates may change Eon boundaries.", version)

  return(geo_data)
}
