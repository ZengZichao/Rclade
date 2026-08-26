# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# MRCA computation and collapse planning

#' Compute MRCA node mapping for each taxonomic group
#'
#' @param tree phylo object
#' @param group_vec Named vector (names = tip labels, values = group names, NA = ungrouped)
#' @param check_monophyly Logical. If TRUE (default), check if each group is
#'   monophyletic before adding to collapse plan. Non-monophyletic groups will
#'   be skipped with a warning.
#' @param strict Logical. If TRUE, non-monophyletic groups cause an error instead
#'   of a warning. Default: FALSE.
#' @return Named list: each element is list(node = integer, tip_count = integer)
#' @keywords internal
compute_mrca_map <- function(tree, group_vec, check_monophyly = TRUE, strict = FALSE) {
  unique_groups <- unique(group_vec[!is.na(group_vec)])
  mrca_map <- list()
  singleton_map <- list()
  root_node <- ape::Ntip(tree) + 1
  skipped_groups <- character(0)
  non_monophyletic_groups <- character(0)
  zero_tip_groups <- character(0)

  # T11 / M-A3: gv_aligned (group_vec aligned to tree$tip.label order) is the
  # same for every group, so compute it ONCE before the loop instead of
  # re-slicing on every iteration (was O(n_groups * n_tips)).
  gv_aligned <- group_vec[tree$tip.label]

  for (grp in unique_groups) {
    tip_indices <- which(!is.na(gv_aligned) & gv_aligned == grp)
    if (length(tip_indices) == 0) {
      # T11 / M-A2: a group with 0 aligned tips should not abort the whole
      # pipeline.  Warn and skip it (matches the single-group-fail -> skip
      # contract used elsewhere), rather than calling stop().
      zero_tip_groups <- c(zero_tip_groups, grp)
      log_warning("Group '%s' has 0 tips in the tree; skipping collapse.",
                  grp, .module = "compute-mrca/compute_mrca_map")
      next
    } else if (length(tip_indices) > 1) {
      node <- ape::getMRCA(tree, tip_indices)

      if (is.null(node)) {
        skipped_groups <- c(skipped_groups, grp)
        log_warning("Group '%s' has NULL MRCA, skipping collapse. Consider checking your rank selection.",
                    grp, .module = "compute-mrca/compute_mrca_map")
        next
      }

      if (node == root_node) {
        if (length(tip_indices) == ape::Ntip(tree)) {
          skipped_groups <- c(skipped_groups, grp)
          log_warning("Group '%s' includes all tips (MRCA = root), skipping collapse. Consider checking your rank selection.",
                      grp, .module = "compute-mrca/compute_mrca_map")
          next
        }
      }

      # Check monophyly if requested
      if (check_monophyly) {
        if (node == root_node) {
          non_monophyletic_groups <- c(non_monophyletic_groups, grp)
          msg <- paste0("Group '", grp, "' has MRCA at the root node but does not include all tips. ",
                        "It is NOT monophyletic (other tips share the same root MRCA). ",
                        "Cannot collapse.")
          if (strict) {
            stop("ERROR (strict mode): ", msg, call. = FALSE)
          } else {
            log_warning(msg, .module = "compute-mrca/compute_mrca_map")
          }
          next
        }

        subtree <- ape::extract.clade(tree, node)
        descendant_tips <- subtree$tip.label
        group_tips <- tree$tip.label[tip_indices]

        if (!setequal(descendant_tips, group_tips)) {
          outsiders <- setdiff(descendant_tips, group_tips)
          non_monophyletic_groups <- c(non_monophyletic_groups, grp)
          msg <- paste0("Group '", grp, "' is NOT monophyletic. ",
                        "MRCA node ", node, " includes ", length(outsiders),
                        " outsider tip(s): ",
                        paste(utils::head(outsiders, 3), collapse = ", "),
                        if (length(outsiders) > 3) " ..." else "",
                        ". Cannot collapse non-monophyletic groups by name.")
          if (strict) {
            stop("ERROR (strict mode): ", msg, call. = FALSE)
          } else {
            log_warning(msg, .module = "compute-mrca/compute_mrca_map")
          }
          next
        }
      } else if (node == root_node) {
        skipped_groups <- c(skipped_groups, grp)
        log_warning("Group '%s' has MRCA at the root node, skipping collapse. Consider checking your rank selection.",
                    grp, .module = "compute-mrca/compute_mrca_map")
        next
      }

      mrca_map[[grp]] <- list(node = node, tip_count = length(tip_indices))
    } else if (length(tip_indices) == 1) {
      singleton_map[[grp]] <- tree$tip.label[tip_indices]
      log_warning("Group '%s' has only 1 species, skipping collapse. It will still be labeled if show_clade_label = TRUE.",
                  grp, .module = "compute-mrca/compute_mrca_map")
    }
  }

  # Summary logging
  if (length(skipped_groups) > 0) {
    log_info("Skipped %d group(s) with MRCA at root: %s",
             length(skipped_groups),
             paste(skipped_groups, collapse = ", "))
  }
  if (length(non_monophyletic_groups) > 0) {
    log_warning("Skipped %d non-monophyletic group(s): %s",
                length(non_monophyletic_groups),
                paste(non_monophyletic_groups, collapse = ", "),
                .module = "compute-mrca/compute_mrca_map")
  }
  if (length(mrca_map) > 0) {
    log_info("Valid groups for collapse: %d out of %d total groups",
             length(mrca_map), length(unique_groups))
  }
  if (length(singleton_map) > 0) {
    log_info("Single-species groups: %d", length(singleton_map))
  }

  attr(mrca_map, "singleton_map") <- singleton_map
  # E-T4: record skipped groups on the return object so batch callers can
  # inspect what was skipped without parsing log output (Snakemake/Nextflow
  # friendly — never aborts the whole batch on a single bad group).
  #
  # v1.1.0 (reviewer issues 2/8): expose the skip reasons SEPARATELY so
  # results tables can report parsed/eligible/collapsed/singleton/skipped
  # counts instead of the previously misleading single "collapsed" total.
  attr(mrca_map, "non_monophyletic") <- non_monophyletic_groups
  attr(mrca_map, "skipped_root") <- skipped_groups
  attr(mrca_map, "skipped_zero_tip") <- zero_tip_groups
  attr(mrca_map, "skipped") <- unique(c(skipped_groups, non_monophyletic_groups, zero_tip_groups))
  return(mrca_map)
}

#' Sort groups by MRCA node depth (deepest first)
#'
#' @param groups Character vector of group names
#' @param mrca_map Output of compute_mrca_map()
#' @param tree phylo object
#' @return Sorted character vector
#' @keywords internal
sort_by_depth <- function(groups, mrca_map, tree) {
  depths <- ape::node.depth(tree)
  group_depths <- vapply(groups, function(g) depths[mrca_map[[g]]$node], numeric(1))
  return(groups[order(group_depths, decreasing = TRUE)])
}

#' Detect nesting conflicts in a collapse plan
#'
#' @param mrca_map Output of compute_mrca_map()
#' @param tree phylo object
#' @return Invisibly returns warning message vector
#' @keywords internal
validate_collapse_plan <- function(mrca_map, tree) {
  if (!requireNamespace("phangorn", quietly = TRUE)) {
    log_warning("phangorn not installed; skipping nesting conflict detection. Nested clades may collapse in unexpected order. Install with: install.packages('phangorn')",
                .module = "compute-mrca/validate_collapse_plan")
    return(invisible(character(0)))
  }

  nodes <- vapply(mrca_map, function(x) x$node, integer(1))
  if (length(nodes) < 2) return(invisible(character(0)))

  # Pre-compute descendants for all nodes at once
  # type = "all" returns all descendant nodes (both tips and internal nodes)
  all_descendants <- phangorn::Descendants(tree, nodes, type = "all")
  names(all_descendants) <- names(mrca_map)

  # Sort nodes by depth (tipward first, rootward last) for nesting detection
  # In ape::node.depth(), tips have higher depth values than internal nodes.
  # With decreasing=TRUE, sorted_nodes[1] is the most tipward MRCA and
  # sorted_nodes[n] is the most rootward MRCA (closest to root).
  depths <- ape::node.depth(tree)
  node_order <- order(depths[nodes], decreasing = TRUE)
  sorted_nodes <- nodes[node_order]
  sorted_names <- names(mrca_map)[node_order]

  warnings <- character(0)
  # Check nesting: for each rootward MRCA (i), check if any tipward MRCA (j)
  # is a descendant. Nodes are sorted by depth descending (tipward first),
  # so i > j means i is more rootward than j.
  # Correct direction: tipward node (j) should be checked as descendant of
  # rootward node (i).
  for (i in seq_along(sorted_nodes)) {
    if (i < 2L) next
    for (j in seq_len(i - 1L)) {
      if (sorted_nodes[j] %in% all_descendants[[sorted_names[i]]]) {
        warnings <- c(warnings, paste0(
          "'", sorted_names[j], "' (node ", sorted_nodes[j],
          ") is nested within '", sorted_names[i], "' (node ", sorted_nodes[i],
          "). Collapse order will be auto-adjusted."
        ))
      }
    }
  }

  if (length(warnings) > 0) {
    log_warning("Nesting conflicts detected in collapse plan:\n%s",
                paste(warnings, collapse = "\n"),
                .module = "compute-mrca/validate_collapse_plan")
  }

  return(invisible(warnings))
}
