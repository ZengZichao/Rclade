# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Shared parameter / plotting helpers (E-T1, decisions 1-3)
#
# This file is the SINGLE source of truth for:
#   * parse_plot_params()          — raw UI/CLI string -> structured plot params
#   * resolve_taxonomy_source_priority() — unify embedded/table priority parsing
#   * get_git_hash()                — git short hash (replaces duplicate impls)
#   * add_clip_off()                — the only place that applies coord clip="off"
#
# All four are @keywords internal (NOT exported).  CLI (cli.R) and Shiny
# (shiny-app.R) must call parse_plot_params() / resolve_taxonomy_source_priority()
# rather than re-implementing strsplit/setNames.  logo.R / cli.R must call
# get_git_hash() instead of their own inline implementation.  The pipeline
# must call add_clip_off() instead of unconditionally adding theme$coord.

utils::globalVariables(c("p", "layout"))

#' Parse raw UI / CLI strings into structured plot parameters
#'
#' This is the ONLY place that converts raw UI strings (comma-separated
#' highlight lists, "A:#FF0000,B:#00FF00" color mappings, "k:_k_,ss:_ss_"
#' taxonomy level specs, "auto"/"tab"/"comma" separators) into the
#' structured R objects expected by \code{plot_timetree()}.
#'
#' Both the CLI (\code{build_plot_timetree_params}) and the Shiny
#' \code{server()} must route their raw inputs through this function so that
#' parsing logic lives in exactly one location.
#'
#' @param color_mapping Character string "GroupA:#FF0000,GroupB:#00FF00", or an
#'   already-structured named vector/list. A single bare hex ("#FF0000") is
#'   returned as a length-1 color vector (M-E2 / L-D7). \code{NULL} -> \code{NULL}.
#' @param taxonomy_levels Character string "k:_k_,ss:_ss_", or a pre-built
#'   \code{list(codes=, names=)}. \code{NULL} -> \code{NULL}.
#' @param highlight Character string "LUCA, LACA", or a character vector.
#'   \code{NULL} -> \code{NULL}.
#' @param taxonomy_file_sep One of "auto", "tab", "comma", or an
#'   already-resolved separator (a literal tab, ",", or "auto").
#' @return A named list with components:
#'   \item{color_mapping}{named character vector or \code{NULL}}
#'   \item{taxonomy_levels}{list(codes, names) or \code{NULL}}
#'   \item{highlight}{character vector or \code{NULL}}
#'   \item{taxonomy_file_sep}{character scalar}
#' @keywords internal
parse_plot_params <- function(color_mapping = NULL,
                              taxonomy_levels = NULL,
                              highlight = NULL,
                              taxonomy_file_sep = "auto") {
  # ---- color_mapping ----
  if (is.null(color_mapping)) {
    parsed_color_mapping <- NULL
  } else if (is.character(color_mapping) && nchar(trimws(color_mapping)) == 0) {
    # Empty string from a UI textInput -> treat as "no mapping" (NULL)
    parsed_color_mapping <- NULL
  } else if (is.list(color_mapping) || is.character(color_mapping) && !is.null(names(color_mapping))) {
    # Already a named vector/list: return as-is
    parsed_color_mapping <- color_mapping
  } else if (is.character(color_mapping)) {
    if (grepl("^#?[0-9A-Fa-f]{6}$", trimws(color_mapping))) {
      # Single bare hex -> length-1 color vector (M-E2 / L-D7)
      parsed_color_mapping <- trimws(sub("^#", "", color_mapping))
      parsed_color_mapping <- setNames(paste0("#", parsed_color_mapping),
                                       parsed_color_mapping)
    } else if (!grepl(":", color_mapping, fixed = TRUE)) {
      # A single color name with no "group:" prefix -> treat as 1-color vector
      parsed_color_mapping <- color_mapping
    } else {
      pairs <- strsplit(color_mapping, ",")[[1]]
      if (length(pairs) == 0) {
        parsed_color_mapping <- NULL
      } else {
        names_vec <- sub(":.*$", "", pairs)
        vals_vec  <- sub("^[^:]+:", "", pairs)
        parsed_color_mapping <- setNames(trimws(vals_vec), trimws(names_vec))
      }
    }
  } else {
    parsed_color_mapping <- color_mapping
  }

  # ---- taxonomy_levels ----
  if (is.null(taxonomy_levels)) {
    parsed_taxonomy_levels <- NULL
  } else if (is.character(taxonomy_levels) && nchar(trimws(taxonomy_levels)) == 0) {
    parsed_taxonomy_levels <- NULL
  } else if (is.list(taxonomy_levels) && !is.null(taxonomy_levels$codes)) {
    parsed_taxonomy_levels <- taxonomy_levels
  } else if (is.character(taxonomy_levels)) {
    pairs <- strsplit(taxonomy_levels, ",")[[1]]
    if (length(pairs) == 0) {
      parsed_taxonomy_levels <- NULL
    } else {
      codes <- trimws(sub(":.*$", "", pairs))
      names_l <- trimws(sub("^[^:]+:", "", pairs))
      parsed_taxonomy_levels <- list(codes = codes, names = names_l)
    }
  } else {
    parsed_taxonomy_levels <- taxonomy_levels
  }

  # ---- highlight ----
  if (is.null(highlight)) {
    parsed_highlight <- NULL
  } else if (is.character(highlight)) {
    if (length(highlight) == 1 && !grepl(",", highlight, fixed = TRUE)) {
      parsed_highlight <- if (nchar(trimws(highlight)) == 0) NULL else trimws(highlight)
    } else {
      parsed_highlight <- trimws(strsplit(paste(highlight, collapse = ","), ",")[[1]])
      parsed_highlight <- parsed_highlight[nchar(parsed_highlight) > 0]
      if (length(parsed_highlight) == 0) parsed_highlight <- NULL
    }
  } else {
    parsed_highlight <- highlight
  }

  # ---- taxonomy_file_sep ----
  if (is.null(taxonomy_file_sep) || is.na(taxonomy_file_sep)) {
    parsed_sep <- "auto"
  } else if (taxonomy_file_sep %in% c("\t", ",")) {
    # already resolved
    parsed_sep <- taxonomy_file_sep
  } else {
    sep_l <- tolower(trimws(taxonomy_file_sep))
    parsed_sep <- switch(sep_l,
                         "auto" = "auto",
                         "tab"  = "\t",
                         "comma" = ",",
                         "auto")
  }

  list(
    color_mapping      = parsed_color_mapping,
    taxonomy_levels    = parsed_taxonomy_levels,
    highlight          = parsed_highlight,
    taxonomy_file_sep  = parsed_sep
  )
}

#' Resolve taxonomy source priority (embedded vs table)
#'
#' Unifies the \code{no_taxonomy_file_priority} flag (CLI) and the explicit
#' \code{taxonomy_source_priority} value (CLI / Shiny) into a single canonical
#' \code{"embedded"} / \code{"table"} string.  Replaces the inline \code{if}
#' previously duplicated in \code{cli.R} and \code{plot_timetree()}.
#'
#' @param no_taxonomy_file_priority Logical. When \code{TRUE}, file taxonomy is
#'   only used as a fallback (embedded takes priority).
#' @param taxonomy_source_priority Character "embedded" or "table". Ignored when
#'   \code{no_taxonomy_file_priority} is \code{TRUE}.
#' @return Character: \code{"embedded"} or \code{"table"}.
#' @keywords internal
resolve_taxonomy_source_priority <- function(no_taxonomy_file_priority = FALSE,
                                             taxonomy_source_priority = "table") {
  if (isTRUE(no_taxonomy_file_priority)) "embedded" else taxonomy_source_priority
}

#' Get the current git short hash of the installed package source
#'
#' Consolidates the previously duplicated git-hash detection found in
#' \code{cli.R::get_version_string()} and \code{logo.R::rclade_logo()}.
#' Returns \code{"unknown"} when not running from a git working tree or when
#' git is unavailable / errors.
#'
#' @return Character: short git hash (7 chars) or \code{"unknown"}.
#' @keywords internal
get_git_hash <- function() {
  desc_path <- tryCatch(system.file("DESCRIPTION", package = "Rclade"),
                        error = function(e) "")
  if (!is.character(desc_path) || nchar(desc_path) == 0) return("unknown")
  pkg_dir <- dirname(desc_path)
  if (!dir.exists(file.path(pkg_dir, ".git"))) return("unknown")
  hash <- tryCatch(
    suppressWarnings(
      system2("git", args = c("-C", pkg_dir, "rev-parse", "--short", "HEAD"),
              stdout = TRUE, stderr = FALSE)
    ),
    error = function(e) "unknown"
  )
  if (is.null(attr(hash, "status")) || attr(hash, "status") == 0) hash else "unknown"
}

#' Apply coordinate-system clip="off" (the only clip application point)
#'
#' Collapsed-triangle vertices (especially the MRCA apex) often extend beyond
#' the tip-based y-axis range, so the plot panel must NOT clip them.  This
#' helper is the single, sanctioned place to add \code{clip = "off"}:
#'   * rectangular -> \code{coord_cartesian(clip = "off")}
#'   * circular/fan -> \code{coord_polar(theta = "y", clip = "off")}
#'
#' A \code{utils::packageVersion("ggplot2")} guard protects against ggplot2
#' < 3.5.0 (which does not support \code{clip = "off"}): in that case we
#' \code{log_warning} and skip clip rather than silently mis-rendering.
#'
#' @param p A ggplot object.
#' @param layout "rectangular" or "circular".
#' @return The ggplot object with the appropriate clip-off coordinate added.
#' @keywords internal
add_clip_off <- function(p, layout = "rectangular") {
  if (utils::packageVersion("ggplot2") < "3.5.0") {
    log_warning("ggplot2 < 3.5.0 does not support coord clip='off'; collapsed triangle vertices may be clipped at the panel edge.")
    return(p)
  }
  if (layout == "circular") {
    # Match ggtree's native circular coord_polar parameters (start = -pi/2,
    # direction = -1) so Rclade's circular output has the same orientation as
    # ggtree's layout="circular".  Only adding clip = "off".
    p + ggplot2::coord_polar(theta = "y", start = -pi/2, direction = -1, clip = "off")
  } else {
    p + ggplot2::coord_cartesian(clip = "off")
  }
}
