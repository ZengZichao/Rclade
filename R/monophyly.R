# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Monophyly checking and clade highlighting

#' Check if a taxonomic group is monophyletic
#'
#' Tests whether all tips belonging to a specified taxonomic group form a
#' monophyletic clade in the tree.
#'
#' @param tree A \code{phylo} object.
#' @param group Character. The name of the taxonomic group to check
#'   (e.g., \code{"P1"}, \code{"Mammalia"}).
#' @param rank Character. Taxonomic rank of the group. One of \code{"domain"},
#'   \code{"phylum"}, \code{"class"}, \code{"order"}, \code{"family"},
#'   \code{"genus"}, \code{"species"}, or abbreviations \code{"d"}, \code{"p"},
#'   \code{"c"}, \code{"o"}, \code{"f"}, \code{"g"}, \code{"s"}.
#' @param format Character. Taxonomy label format. One of \code{"auto"},
#'   \code{"GTDB"}, \code{"Silva"}, \code{"NCBI"}, \code{"custom_rank"},
#'   \code{"custom_regex"}. Default: \code{"auto"}.
#' @param custom_patterns Named list of regex patterns for custom format.
#'   Required when \code{format = "custom_regex"}.
#' @param quiet Logical. If \code{TRUE}, suppress informational messages.
#'   Default: \code{FALSE}.
#' @param delimiter_mode Character. Embedded (Format A) parsing strategy:
#'   \code{"reverse"} (right-to-left, default), \code{"greedy"} (left-to-right),
#'   or \code{"segment"} (delimiter-to-delimiter extraction).
#' @param taxonomy_levels Custom taxonomy level configuration (list with codes and names).
#'   Default: \code{NULL}.
#' @section Case sensitivity (L-A2):
#' Group matching is \strong{case-insensitive}.  The query \code{group} and every
#' parsed \code{Group} label are lower-cased with \code{tolower()} \emph{at
#' comparison time} (not during parsing) before matching, so
#' \code{"Proteobacteria"} and \code{"proteobacteria"} match the same clade.
#' \code{\link{parse_taxonomy}} itself preserves the original case of parsed
#' labels; the lower-casing applied here is local to this comparison and keeps
#' the two modules consistent about what a group name refers to.
#' @return A list with components:
#'   \describe{
#'     \item{is_monophyletic}{Logical. Whether the group is monophyletic.}
#'     \item{group}{Character. The group name.}
#'     \item{n_tips}{Integer. Number of tips belonging to the group.}
#'     \item{mrca_node}{Integer or NULL. The MRCA node number, or NULL if
#'       the group has fewer than 2 tips.}
#'     \item{outsiders}{Character vector. Tips in the MRCA clade that do not
#'       belong to the group (empty if monophyletic).}
#'   }
#' @export
#' @examples
#' \dontrun{
#' data(example_tree)
#'
#' # Check if phylum P1 is monophyletic
#' result <- check_monophyly(example_tree, "P1",
#'                            rank = "phylum", format = "GTDB")
#' if (result$is_monophyletic) {
#'   cat("P1 is monophyletic!\n")
#' } else {
#'   cat("P1 is NOT monophyletic.\n")
#' }
#' }
check_monophyly <- function(tree, group, rank, format = "auto",
                            custom_patterns = NULL, quiet = FALSE,
                            delimiter_mode = "reverse",
                            taxonomy_levels = NULL) {
  # Validate inputs
  if (!inherits(tree, "phylo")) {
    stop("'tree' must be a phylo object.", call. = FALSE)
  }
  if (!is.character(group) || length(group) != 1 || nchar(group) == 0) {
    stop("'group' must be a non-empty character string.", call. = FALSE)
  }

  # Parse taxonomy
  rank_std <- normalize_rank(rank)
  taxa_df <- parse_taxonomy(tree$tip.label, rank_std, format, custom_patterns,
                            taxonomy_levels = taxonomy_levels,
                            delimiter_mode = delimiter_mode)

  # Find tips belonging to the group (case-insensitive match)
  group_lower <- tolower(group)
  tip_mask <- tolower(taxa_df$Group) == group_lower & !is.na(taxa_df$Group)
  tip_indices <- which(tip_mask)

  result <- list(
    is_monophyletic = FALSE,
    group = group,
    n_tips = length(tip_indices),
    mrca_node = NULL,
    outsiders = character(0)
  )

  # Handle edge cases
  if (length(tip_indices) == 0) {
    if (!quiet) {
      message("Group '", group, "' not found in tree at rank '", rank, "'.")
    }
    return(invisible(result))
  }

  if (length(tip_indices) == 1) {
    if (!quiet) {
      message("Group '", group, "' has only 1 tip, trivially monophyletic.")
    }
    # L-A1: fill the single tip's actual node number instead of leaving
    # mrca_node NULL, so downstream callers (e.g. highlight) have a valid node.
    result$is_monophyletic <- TRUE
    result$mrca_node <- tip_indices[1]
    return(invisible(result))
  }

  # Get MRCA node
  mrca_node <- ape::getMRCA(tree, tip_indices)

  if (is.null(mrca_node)) {
    # MRCA is the root - not monophyletic unless group contains ALL tips
    if (length(tip_indices) == ape::Ntip(tree)) {
      result$is_monophyletic <- TRUE
      result$mrca_node <- ape::Ntip(tree) + 1
    } else {
      result$mrca_node <- ape::Ntip(tree) + 1
      # Find outsiders (tips in root clade not in group)
      all_tips <- seq_len(ape::Ntip(tree))
      result$outsiders <- tree$tip.label[setdiff(all_tips, tip_indices)]
    }
    return(invisible(result))
  }

  result$mrca_node <- mrca_node

  # Extract the clade rooted at MRCA and compare tips
  subtree <- ape::extract.clade(tree, mrca_node)
  descendant_tips <- subtree$tip.label
  group_tips <- tree$tip.label[tip_indices]

  if (setequal(descendant_tips, group_tips)) {
    result$is_monophyletic <- TRUE
  } else {
    result$outsiders <- setdiff(descendant_tips, group_tips)
  }

  # Print result
  if (!quiet) {
    if (result$is_monophyletic) {
      message("Group '", group, "' IS monophyletic (",
              result$n_tips, " tips, MRCA node ", result$mrca_node, ").")
    } else {
      message("Group '", group, "' is NOT monophyletic (",
              result$n_tips, " tips in group, but MRCA node ", result$mrca_node,
              " includes ", length(result$outsiders), " outsider tip(s): ",
              paste(utils::head(result$outsiders, 5), collapse = ", "),
              if (length(result$outsiders) > 5) " ..." else "", ").")
    }
  }

  return(invisible(result))
}


#' Highlight monophyletic clades on a tree plot
#'
#' Adds colored highlighting for specified taxonomic groups. Only monophyletic
#' groups are highlighted; non-monophyletic groups trigger a warning.
#' Supports special identifiers LUCA, LACA, LBCA for ancestral nodes.
#'
#' @param p A \code{ggplot} object (from \code{plot_timetree()}).
#' @param tree A \code{phylo} object.
#' @param groups Character vector of group names to highlight.
#'   Can include special identifiers: \code{"LUCA"}, \code{"LACA"}, \code{"LBCA"}.
#' @param rank Character. Taxonomic rank of the groups (ignored for special identifiers).
#' @param format Character. Taxonomy label format. Default: \code{"auto"}.
#' @param colors Named character vector of colors for each group.
#'   If \code{NULL}, colors are auto-generated.
#' @param alpha Numeric. Transparency of the highlight. Default: \code{0.2}.
#' @param custom_patterns Named list of regex patterns for custom format.
#' @param taxonomy_levels Custom taxonomy level configuration (list with codes and names).
#'   Default: \code{NULL}.
#' @return A \code{ggplot} object with highlights added.
#' @keywords internal
highlight_clades <- function(p, tree, groups, rank, format = "auto",
                             colors = NULL, alpha = 0.2,
                             custom_patterns = NULL,
                             delimiter_mode = "reverse",
                             taxonomy_levels = NULL) {
  if (length(groups) == 0) return(p)

  # Auto-generate colors if not provided
  if (is.null(colors)) {
    colors <- generate_colors(groups, palette = "Set1")
  }

  # Identify special identifiers (ROOT is a valid special identifier too)
  special_ids <- c("ROOT", "LUCA", "LACA", "LBCA")

  for (grp in groups) {
    # Check if this is a special identifier
    is_special <- toupper(grp) %in% special_ids

    if (is_special) {
      # Use special identifier resolution
      result <- check_special_monophyly(tree, grp, format, quiet = TRUE,
                                        delimiter_mode = delimiter_mode,
                                        taxonomy_levels = taxonomy_levels)

      if (!result$is_monophyletic) {
        log_warning("Special identifier '%s' is not monophyletic. Cannot highlight. Found %d outsider tip(s) from domains: %s.",
                    grp, result$n_outsiders,
                    paste(result$outsider_domains, collapse = ", "),
                    .module = "monophyly")
        next
      }

      if (result$n_tips < 2) {
        log_warning("Special identifier '%s' has fewer than 2 tips. Skipping highlight.",
                    grp, .module = "monophyly")
        next
      }

      # Get the color for this group
      grp_color <- if (grp %in% names(colors)) colors[grp] else "#FF0000"

      # Add highlight using geom_hilight from ggtree
      p <- p + ggtree::geom_hilight(
        node = result$node,
        fill = grp_color,
        alpha = alpha
      )
    } else {
      # Regular group - use standard monophyly check
      result <- check_monophyly(tree, grp, rank, format, custom_patterns,
                                quiet = TRUE, delimiter_mode = delimiter_mode,
                                taxonomy_levels = taxonomy_levels)

      if (!result$is_monophyletic) {
        log_warning("Group '%s' is not monophyletic. Cannot highlight. Found %d outsider tip(s) in MRCA clade.",
                    grp, length(result$outsiders), .module = "monophyly")
        next
      }

      if (result$n_tips < 2) {
        log_warning("Group '%s' has fewer than 2 tips. Skipping highlight.",
                    grp, .module = "monophyly")
        next
      }

      # Get the color for this group
      grp_color <- if (grp %in% names(colors)) colors[grp] else "#FF0000"

      # Add highlight using geom_hilight from ggtree
      p <- p + ggtree::geom_hilight(
        node = result$mrca_node,
        fill = grp_color,
        alpha = alpha
      )
    }
  }

  return(p)
}
