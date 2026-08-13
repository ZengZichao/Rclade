# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Node support labels and HPD range display

#' Add node support labels to a tree plot
#'
#' @param p ggplot object
#' @param tree phylo object (with node.data if from treedata)
#' @param threshold Minimum support value to display
#' @return ggplot object
#' @importFrom rlang .data
#' @keywords internal
add_support_labels <- function(p, tree, threshold) {
  node_data <- tree$node.data
  if (is.null(node_data)) {
    log_info("No node annotations found, skipping support label display.",
             .module = "support-labels")
    return(p)
  }

  # Detect support column name
  support_col <- NULL
  for (col in c("posterior", "UFbootstrap", "bootstrap", "support")) {
    if (col %in% names(node_data)) {
      support_col <- col
      break
    }
  }
  if (is.null(support_col)) {
    log_info("No support annotation column found.", .module = "support-labels")
    return(p)
  }

  support_vals <- as.numeric(node_data[[support_col]])
  support_df <- data.frame(
    node = node_data$node,
    support_label = ifelse(
      !is.na(support_vals) & support_vals >= threshold,
      as.character(round(support_vals, 2)),
      ""
    ),
    stringsAsFactors = FALSE
  )

  p <- p + ggtree::geom_nodelab(
    data = support_df,
    ggplot2::aes(label = .data$support_label),
    size = 2, hjust = 1.1, vjust = -0.5
  )

  return(p)
}

#' Add HPD (Highest Posterior Density) range to a tree plot
#'
#' Uses \code{ggtree::geom_range()} to display horizontal uncertainty bars
#' on internal nodes. Requires a \code{node.data} data frame attached to the
#' tree with a HPD column (list column of c(lower, upper) vectors).
#'
#' @param p ggplot object
#' @param tree phylo object (with node.data containing HPD annotations)
#' @param color Color for HPD bars. Default: "firebrick".
#' @return ggplot object
#' @keywords internal
add_hpd_range <- function(p, tree, color = "firebrick") {
  node_data <- tree$node.data
  if (is.null(node_data)) {
    log_info("No node annotations found, skipping HPD display.",
             .module = "support-labels")
    return(p)
  }

  # Find HPD column
  hpd_col <- NULL
  for (col in names(node_data)) {
    if (grepl("HPD|highest_posterior_density", col, ignore.case = TRUE)) {
      hpd_col <- col
      break
    }
  }
  if (is.null(hpd_col)) {
    log_info("No HPD annotation column found.", .module = "support-labels")
    return(p)
  }

  # Ensure node column exists
  if (!("node" %in% names(node_data))) {
    log_info("No 'node' column found in node data, skipping HPD display.",
             .module = "support-labels")
    return(p)
  }

  # Filter rows with valid HPD values (non-empty, non-NA lists)
  valid_hpd <- vapply(node_data[[hpd_col]], function(x) {
    !is.null(x) && length(x) >= 2 && !all(is.na(x))
  }, logical(1))

  hpd_df <- node_data[valid_hpd, c("node", hpd_col), drop = FALSE]

  if (nrow(hpd_df) == 0) {
    log_info("All HPD values are missing, skipping HPD display.",
             .module = "support-labels")
    return(p)
  }

  # Bind HPD data and add geom_range layer
  p <- p %<+% hpd_df +
    ggtree::geom_range(
      range = hpd_col,
      color = color,
      linewidth = 1.2,
      alpha = 0.35
    )

  return(p)
}
