# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Custom group collapsing support

#' Validate user-defined custom groups for tree collapsing
#'
#' Checks that every group is monophyletic and that tips do not overlap
#' between groups.
#'
#' @param tree A \code{phylo} object.
#' @param groups A named \code{list} where each element is a character vector
#'   of tip labels belonging to that group.
#' @return Invisibly returns \code{TRUE} if all checks pass. Otherwise stops
#'   with an informative error.
#' @keywords internal
#' @keywords internal
validate_custom_groups <- function(tree, groups) {
  if (!is.list(groups) || is.null(names(groups)) || any(names(groups) == "")) {
    stop("'groups' must be a named list. Each element should be a character vector of tip labels.",
         call. = FALSE)
  }

  # Check for empty groups
  empty_groups <- names(groups)[vapply(groups, length, integer(1)) == 0]
  if (length(empty_groups) > 0) {
    stop("Empty custom group(s) provided: ",
         paste(utils::head(empty_groups, 5), collapse = ", "),
         if (length(empty_groups) > 5) " ..." else "",
         ". Each group must contain at least one tip label.",
         call. = FALSE)
  }

  all_tips <- unlist(groups, use.names = FALSE)

  # 1. All tips must exist in the tree
  missing_tips <- setdiff(all_tips, tree$tip.label)
  if (length(missing_tips) > 0) {
    stop(length(missing_tips), " tip(s) in 'groups' not found in the tree: ",
         paste(utils::head(missing_tips, 5), collapse = ", "),
         if (length(missing_tips) > 5) " ..." else "",
         call. = FALSE)
  }

  # 2. No tip can belong to more than one group
  tip_counts <- table(all_tips)
  dups <- names(tip_counts[tip_counts > 1])
  if (length(dups) > 0) {
    stop(length(dups), " tip(s) assigned to multiple groups: ",
         paste(utils::head(dups, 5), collapse = ", "),
         if (length(dups) > 5) " ..." else "",
         call. = FALSE)
  }

  # 3. Every group with >1 tip must be monophyletic
  for (g in names(groups)) {
    tips <- groups[[g]]
    n <- length(tips)
    if (n <= 1) next  # single-tip groups are trivially monophyletic

    tip_idx <- match(tips, tree$tip.label)
    mrca_node <- ape::getMRCA(tree, tip_idx)

    if (is.null(mrca_node)) {
      # MRCA is the root — the group includes tips from every major lineage.
      # This is only monophyletic if the group contains ALL tips.
      if (n < ape::Ntip(tree)) {
        stop("Group '", g, "' is not monophyletic. Its MRCA is the root node, ",
             "but it does not include all tips in the tree.", call. = FALSE)
      }
      next
    }

    # Extract the clade rooted at the MRCA and compare its tips
    subtree <- ape::extract.clade(tree, mrca_node)
    descendant_tips <- subtree$tip.label

    if (!setequal(descendant_tips, tips)) {
      outsiders <- setdiff(descendant_tips, tips)
      stop("Group '", g, "' is not monophyletic. ",
           "MRCA node ", mrca_node, " includes ", length(outsiders),
           " non-group tip(s): ",
           paste(utils::head(outsiders, 3), collapse = ", "),
           if (length(outsiders) > 3) " ..." else "",
           call. = FALSE)
    }
  }

  invisible(TRUE)
}


#' Build a group vector from custom groups
#'
#' Converts a named list of tip vectors into the named-vector format used
#' by \code{compute_mrca_map()}.
#'
#' @param groups Named list of character vectors (tip labels per group).
#' @param tip_labels Character vector of all tip labels in the tree.
#' @return Named character vector: names = tip labels, values = group names,
#'   \code{NA} for ungrouped tips.
#' @keywords internal
#' @keywords internal
build_group_vec <- function(groups, tip_labels) {
  # L-A4: detect duplicate tip labels within / across groups up front so the
  # resulting group_vec is unambiguous (a tip mapped to two groups would be
  # silently overwritten otherwise).
  all_tips <- unlist(groups, use.names = FALSE)
  dup_tips <- unique(all_tips[duplicated(all_tips)])
  if (length(dup_tips) > 0) {
    stop("Tip(s) listed more than once across groups: ",
         paste(utils::head(dup_tips, 5), collapse = ", "),
         if (length(dup_tips) > 5) " ..." else "",
         ". Each tip must belong to exactly one group.", call. = FALSE)
  }

  # T11 / M-A4: avoid the O(n^2) `tip %in% tip_set` scan on every assignment.
  # Build a one-time name -> position map and assign via match().
  tip_idx_map <- setNames(seq_along(tip_labels), tip_labels)
  group_vec <- setNames(rep(NA_character_, length(tip_labels)), tip_labels)
  for (g in names(groups)) {
    idx <- tip_idx_map[groups[[g]]]
    missing <- is.na(idx)
    if (any(missing)) {
      stop("Tip(s) '", paste(utils::head(groups[[g]][missing], 5), collapse = ", "),
           "' in group '", g, "' not found in tree. ",
           "Call validate_custom_groups() first.", call. = FALSE)
    }
    group_vec[idx] <- g
  }
  return(group_vec)
}
