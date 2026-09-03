# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Special ancestral node identifiers (LUCA, LACA, LBCA)

#' Resolve the target/expected taxonomy domains for a special ancestral identifier.
#'
#' Single source of truth for which taxonomy domains a special identifier maps
#' to. Shared by \code{resolve_special_identifier()} (to find the tips belonging
#' to the identifier) and \code{check_special_monophyly()} (to decide which
#' domains are "inside" the clade), so the two call sites cannot drift apart.
#'
#' @param identifier Character, one of \code{"ROOT"}, \code{"LUCA"},
#'   \code{"LACA"}, \code{"LBCA"}.
#' @param all_domains Character vector of domain names present in the relevant
#'   tip set (full tree for resolution, MRCA clade for monophyly checking).
#' @return Character vector of target domains.
#' @keywords internal
resolve_target_domains <- function(identifier, all_domains) {
  switch(identifier,
    "ROOT" = all_domains,
    "LUCA" = {
      if (length(all_domains) > 2) {
        log_warning("Tree contains %d domains (%s). LUCA is computed as the MRCA of all domains, which may coincide with the root node. Result may overlap with ROOT.",
                    length(all_domains), paste(all_domains, collapse = ", "),
                    .module = "special-identifiers")
      }
      all_domains
    },
    "LACA" = {
      if ("Archaea" %in% all_domains) {
        "Archaea"
      } else if (length(all_domains) == 2 && "Bacteria" %in% all_domains) {
        # In a two-domain coded tree, the non-Bacteria domain is treated as Archaea
        setdiff(all_domains, "Bacteria")
      } else {
        character(0)
      }
    },
    "LBCA" = {
      if ("Bacteria" %in% all_domains) {
        "Bacteria"
      } else if (length(all_domains) == 1) {
        # Single-domain coded tree: treat the only domain as the bacterial lineage
        all_domains
      } else {
        character(0)
      }
    },
    character(0)
  )
}

#' Resolve special ancestral node identifiers
#'
#' Handles special identifiers for key ancestral nodes in the tree of life:
#' \itemize{
#'   \item \strong{LUCA}: Last Universal Common Ancestor - MRCA of all Bacteria and Archaea
#'   \item \strong{LACA}: Last Archaeal Common Ancestor - MRCA of all Archaea
#'   \item \strong{LBCA}: Last Bacterial Common Ancestor - MRCA of all Bacteria
#' }
#'
#' @param tree A \code{phylo} object.
#' @param identifier Character. One of \code{"ROOT"}, \code{"LUCA"}, \code{"LACA"}, \code{"LBCA"}.
#'   \describe{
#'     \item{ROOT}{Root of the tree}
#'     \item{LUCA}{Last Universal Common Ancestor (MRCA of all Bacteria and Archaea)}
#'     \item{LACA}{Last Archaeal Common Ancestor (MRCA of all Archaea)}
#'     \item{LBCA}{Last Bacterial Common Ancestor (MRCA of all Bacteria)}
#'   }
#' @param format Character. Taxonomy label format. Default: \code{"auto"}.
#' @param quiet Logical. If TRUE, suppress informational messages. Default: FALSE.
#' @param delimiter_mode Character. Embedded parsing strategy: \code{"reverse"},
#'   \code{"greedy"}, or \code{"segment"}. Default: \code{"reverse"}.
#' @param taxonomy_levels Custom taxonomy level configuration (list with codes and names).
#'   Default: \code{NULL}.
#' @return A list with components:
#'   \describe{
#'     \item{node}{Integer. The node number of the MRCA, or NULL if not found.}
#'     \item{identifier}{Character. The identifier name.}
#'     \item{description}{Character. Human-readable description.}
#'     \item{n_tips}{Integer. Number of descendant tips.}
#'     \item{tip_labels}{Character vector. Labels of descendant tips.}
#'   }
#' @keywords internal
resolve_special_identifier <- function(tree, identifier, format = "auto",
                                        quiet = FALSE,
                                        delimiter_mode = "reverse",
                                        taxonomy_levels = NULL) {
  if (!inherits(tree, "phylo")) {
    stop("'tree' must be a phylo object.", call. = FALSE)
  }

  identifier <- toupper(identifier)
  valid_ids <- c("ROOT", "LUCA", "LACA", "LBCA")

  if (!identifier %in% valid_ids) {
    stop("'", identifier, "' is not a recognized special identifier. ",
         "Valid identifiers: ", paste(valid_ids, collapse = ", "), call. = FALSE)
  }

  # Handle ROOT: return the root node directly
  if (identifier == "ROOT") {
    root_node <- ape::Ntip(tree) + 1
    return(invisible(list(
      node = root_node,
      identifier = "ROOT",
      description = "Root of the tree",
      n_tips = ape::Ntip(tree),
      tip_labels = tree$tip.label,
      target_domains = character(0)
    )))
  }

  # Parse taxonomy to get domain information
  taxa_df <- parse_taxonomy(tree$tip.label, "domain", format,
                            taxonomy_levels = taxonomy_levels,
                            delimiter_mode = delimiter_mode)

  all_domains <- unique(na.omit(taxa_df$Group))

  # Determine which domains to include based on identifier (single source of truth)
  target_domains <- resolve_target_domains(identifier, all_domains)

  # Find tips belonging to target domains (case-insensitive)
  tip_mask <- tolower(taxa_df$Group) %in% tolower(target_domains) &
              !is.na(taxa_df$Group)
  tip_indices <- which(tip_mask)

  result <- list(
    node = NULL,
    identifier = identifier,
    description = switch(identifier,
      "LUCA" = "Last Universal Common Ancestor (MRCA of all Bacteria and Archaea)",
      "LACA" = "Last Archaeal Common Ancestor (MRCA of all Archaea)",
      "LBCA" = "Last Bacterial Common Ancestor (MRCA of all Bacteria)"
    ),
    n_tips = length(tip_indices),
    tip_labels = tree$tip.label[tip_indices],
    target_domains = target_domains
  )

  if (length(tip_indices) == 0) {
    if (!quiet) {
      message("No tips found for domains: ", paste(target_domains, collapse = ", "),
              ". Cannot identify ", identifier, ".")
    }
    return(invisible(result))
  }

  if (length(tip_indices) == 1) {
    if (!quiet) {
      message("Only 1 tip found for ", identifier, ". ",
              "Cannot compute MRCA for a single tip.")
    }
    return(invisible(result))
  }

  # Compute MRCA
  mrca_node <- ape::getMRCA(tree, tip_indices)

  if (is.null(mrca_node)) {
    # MRCA is the root
    mrca_node <- ape::Ntip(tree) + 1
  }

  result$node <- mrca_node

  if (!quiet) {
    message(identifier, " (", result$description, "): ",
            "Node ", mrca_node, " with ", length(tip_indices), " descendant tips.")
  }

  return(invisible(result))
}


#' Check if a special identifier corresponds to a monophyletic group
#'
#' Tests whether the MRCA of the specified domains (identified by LUCA/LACA/LBCA)
#' contains only tips from those domains (i.e., is monophyletic with respect to
#' the target domains).
#'
#' @param tree A \code{phylo} object.
#' @param identifier Character. One of \code{"LUCA"}, \code{"LACA"}, \code{"LBCA"}.
#' @param format Character. Taxonomy label format. Default: \code{"auto"}.
#' @param quiet Logical. If TRUE, suppress informational messages. Default: FALSE.
#' @param delimiter_mode Character. Embedded parsing strategy: \code{"reverse"},
#'   \code{"greedy"}, or \code{"segment"}. Default: \code{"reverse"}.
#' @param taxonomy_levels Custom taxonomy level configuration (list with codes and names).
#'   Default: \code{NULL}.
#' @return A list with components:
#'   \describe{
#'     \item{is_monophyletic}{Logical. Whether the group is monophyletic.}
#'     \item{identifier}{Character. The identifier name.}
#'     \item{node}{Integer or NULL. The MRCA node number.}
#'     \item{n_tips}{Integer. Number of tips in the target domains.}
#'     \item{n_outsiders}{Integer. Number of outsider tips in the MRCA clade.}
#'     \item{outsider_domains}{Character vector. Domains of outsider tips.}
#'   }
#' @export
#' @examples
#' data(example_tree)
#' result <- check_special_monophyly(example_tree, "LBCA")
#' if (result$is_monophyletic) {
#'   message("LBCA is monophyletic!")
#' }
check_special_monophyly <- function(tree, identifier, format = "auto",
                                     quiet = FALSE,
                                     delimiter_mode = "reverse",
                                     taxonomy_levels = NULL) {
  if (!inherits(tree, "phylo")) {
    stop("'tree' must be a phylo object.", call. = FALSE)
  }

  identifier <- toupper(identifier)

  # Get the special identifier info
  id_info <- resolve_special_identifier(tree, identifier, format, quiet = TRUE,
                                        delimiter_mode = delimiter_mode,
                                        taxonomy_levels = taxonomy_levels)

  result <- list(
    is_monophyletic = FALSE,
    identifier = identifier,
    node = id_info$node,
    n_tips = id_info$n_tips,
    n_outsiders = 0,
    outsider_domains = character(0)
  )

  if (is.null(id_info$node) || id_info$n_tips < 2) {
    if (!quiet) {
      message("Cannot check monophyly for ", identifier, ": ",
              if (id_info$n_tips == 0) "no tips found" else "insufficient tips")
    }
    return(invisible(result))
  }

  # ROOT trivially contains every tip in the tree, so it is always monophyletic.
  if (identifier == "ROOT") {
    result$is_monophyletic <- TRUE
    if (!quiet) {
      message("ROOT (", id_info$description, "): ",
              "Node ", id_info$node, " with ", id_info$n_tips, " descendant tips.")
    }
    return(invisible(result))
  }

  # Get all tips in the MRCA clade
  subtree <- ape::extract.clade(tree, id_info$node)
  clade_tips <- subtree$tip.label

  # Parse taxonomy for all clade tips
  taxa_df <- parse_taxonomy(clade_tips, "domain", format,
                            taxonomy_levels = taxonomy_levels,
                            delimiter_mode = delimiter_mode)

  # Determine expected domains (reuse the single source of truth computed for
  # the identifier resolution, so the monophyly test and tip-finding agree).
  expected_domains <- id_info$target_domains

  # Find outsiders (tips in clade not belonging to target domains)
  outsider_mask <- !tolower(taxa_df$Group) %in% tolower(expected_domains) &
                   !is.na(taxa_df$Group)
  outsider_indices <- which(outsider_mask)

  result$n_outsiders <- length(outsider_indices)
  result$outsider_domains <- unique(taxa_df$Group[outsider_indices])

  if (length(outsider_indices) == 0) {
    result$is_monophyletic <- TRUE
    if (!quiet) {
      message(identifier, " IS monophyletic (", id_info$n_tips, " tips, ",
              "MRCA node ", id_info$node, ").")
    }
  } else {
    if (!quiet) {
      message(identifier, " is NOT monophyletic (", id_info$n_tips,
              " target tips, but MRCA node ", id_info$node,
              " includes ", length(outsider_indices), " outsider tip(s) from ",
              paste(result$outsider_domains, collapse = ", "), ").")
    }
  }

  return(invisible(result))
}


#' Resolve group name or special identifier to MRCA node
#'
#' Unified function that handles both regular group names and special identifiers
#' (LUCA, LACA, LBCA).
#'
#' @param tree A \code{phylo} object.
#' @param group Character. Group name or special identifier.
#' @param rank Character. Taxonomic rank (ignored for special identifiers).
#' @param format Character. Taxonomy label format. Default: \code{"auto"}.
#' @param quiet Logical. If TRUE, suppress messages. Default: FALSE.
#' @param delimiter_mode Character. Embedded parsing strategy: \code{"reverse"},
#'   \code{"greedy"}, or \code{"segment"}. Default: \code{"reverse"}.
#' @param custom_patterns Named list of regex patterns for custom format.
#'   Required when \code{format = "custom_regex"}.
#' @param taxonomy_levels Custom taxonomy level configuration (list with codes and names).
#'   Default: \code{NULL}.
#' @return A list with components:
#'   \describe{
#'     \item{is_monophyletic}{Logical. Whether the group is monophyletic.}
#'     \item{group}{Character. The group name or identifier.}
#'     \item{is_special}{Logical. Whether this is a special identifier.}
#'     \item{node}{Integer or NULL. The MRCA node number.}
#'     \item{n_tips}{Integer. Number of tips in the group.}
#'     \item{outsiders}{Character vector. Tips in MRCA not belonging to group.}
#'   }
#' @keywords internal
resolve_group <- function(tree, group, rank = "domain", format = "auto",
                           quiet = FALSE,
                           delimiter_mode = "reverse",
                           custom_patterns = NULL,
                           taxonomy_levels = NULL) {
  if (!inherits(tree, "phylo")) {
    stop("'tree' must be a phylo object.", call. = FALSE)
  }

  # Check if this is a special identifier (ROOT is a valid special identifier)
  special_ids <- c("ROOT", "LUCA", "LACA", "LBCA")
  is_special <- toupper(group) %in% special_ids

  if (is_special) {
    # Use special identifier resolution
    id_result <- check_special_monophyly(tree, group, format, quiet,
                                         delimiter_mode = delimiter_mode,
                                         taxonomy_levels = taxonomy_levels)

    return(list(
      is_monophyletic = id_result$is_monophyletic,
      group = group,
      is_special = TRUE,
      node = id_result$node,
      n_tips = id_result$n_tips,
      outsiders = if (id_result$n_outsiders > 0) {
        paste0(id_result$n_outsiders, " tip(s) from ",
               paste(id_result$outsider_domains, collapse = ", "))
      } else {
        character(0)
      }
    ))
  } else {
    # Use regular group resolution
    mono_result <- check_monophyly(tree, group, rank, format,
                                   custom_patterns = custom_patterns,
                                   quiet = quiet,
                                   delimiter_mode = delimiter_mode,
                                   taxonomy_levels = taxonomy_levels)

    return(list(
      is_monophyletic = mono_result$is_monophyletic,
      group = group,
      is_special = FALSE,
      node = mono_result$mrca_node,
      n_tips = mono_result$n_tips,
      outsiders = mono_result$outsiders
    ))
  }
}
