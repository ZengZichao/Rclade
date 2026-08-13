# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# ASCII Logo for Rclade

#' Display Rclade ASCII art logo
#'
#' Prints a stylized ASCII art logo for Rclade to the console.
#'
#' @param show_version Logical. Whether to show version number. Default: TRUE
#' @param show_tagline Logical. Whether to show tagline. Default: TRUE
#' @return Invisible NULL
#' @export
#' @examples
#' rclade_logo()
rclade_logo <- function(show_version = TRUE, show_tagline = TRUE) {
  logo <- c(
    "",
    "  ######   ######   #####   #       #####   ######  ######",
    "  #    #   #    #  #     #  #       #    #  #       #     ",
    "  ######   ######  #        #       #    #  ####    ####  ",
    "  #   #    #   #   #        #       #    #  #       #     ",
    "  #    #   #    #   #####   ######  #####   ######  ######",
    ""
  )

  cat(logo, sep = "\n")

  if (show_version) {
    pkg_version <- tryCatch(
      as.character(utils::packageVersion("Rclade")),
      error = function(e) "2.0.0"
    )
    cat(sprintf("  Version %s | MIT License\n", pkg_version))

    # T07 / E-T1: use the shared get_git_hash() helper (replaces the inline
    # duplicate implementation that also existed in cli.R::get_version_string).
    git_hash <- get_git_hash()
    if (!is.null(git_hash) && git_hash != "unknown") {
      cat(sprintf("  Git: %s\n", git_hash))
    }

    # Third-party libraries with license summaries (academic citation compliance)
    cat("\n")
    cat("  Third-party dependencies and licenses:\n")
    cat("  --------------------------------------------------------------\n")
    cat("  ape         >= 5.0    GPL-2+        Paradis & Schliep 2019\n")
    cat("  ggtree      >= 4.0    Artistic-2.0  Yu et al. 2017\n")
    cat("  deeptime    >= 1.0    GPL (>= 3)    Gearty 2025\n")
    cat("  ggplot2     >= 3.5    MIT           Wickham 2016\n")
    cat("  rlang       >= 1.0    MIT           Wickham et al. 2024\n")
    cat("  stringr     >= 1.5    MIT           Wickham 2019\n")
    cat("  tidytree    >= 0.4    Artistic-2.0  Yu 2022\n")
    cat("  --------------------------------------------------------------\n")
    cat("  Optional: treeio (Artistic-2.0), phangorn (GPL-2+),\n")
    cat("            RColorBrewer (Apache-2.0), viridisLite (MIT)\n")
  }

  if (show_tagline) {
    cat("  Automated Deep-Time Phylogenetic Tree Visualization\n")
  }

  cat("\n")
  invisible(NULL)
}
