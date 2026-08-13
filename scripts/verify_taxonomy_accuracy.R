#!/usr/bin/env Rscript
# Verify taxonomy parsing accuracy for the built-in example_tree
# Compares Rclade::parse_taxonomy() output against ground-truth labels
# extracted directly from semicolon-delimited tip names.

suppressPackageStartupMessages({
  library(Rclade)
})

data("example_tree")
labels <- example_tree$tip.label
n_tips <- length(labels)
cat("example_tree:", n_tips, "tips\n\n")

# ------------------------------------------------------------------
# Helper: extract ground truth from semicolon-delimited labels (d__X;p__Y;c__Z;o__W;...)
# ------------------------------------------------------------------
extract_rank <- function(labels, prefix) {
  pattern <- paste0("(?<=", prefix, ")[^;]+")
  regmatches(labels, gregexpr(pattern, labels, perl = TRUE)) |>
    vapply(function(x) if (length(x)) x[[1]] else NA_character_, character(1))
}

ground_truth <- data.frame(
  label = labels,
  phylum_true = extract_rank(labels, "p__"),
  class_true  = extract_rank(labels, "c__"),
  order_true  = extract_rank(labels, "o__"),
  stringsAsFactors = FALSE
)

# Check if order-level info exists (some labels may not have o__)
cat("Labels with order-level taxonomy:", sum(!is.na(ground_truth$order_true)), "/", n_tips, "\n\n")

# ------------------------------------------------------------------
# Run Rclade parsing at each rank and compare
# ------------------------------------------------------------------
verify_rank <- function(rank_name, rank_level) {
  col_true <- paste0(rank_level, "_true")
  cat("=== Rank:", rank_name, "(", rank_level, ") ===\n")
  
  parsed <- Rclade::parse_taxonomy(labels, rank = rank_level, format = "auto")
  
  # Merge ground truth with parsed results
  merged <- merge(
    ground_truth[, c("label", col_true)],
    parsed[, c("label", "Group")],
    by = "label",
    all = TRUE
  )
  
  # Cases where Rclade parsed a group (non-NA) and we have ground truth
  valid <- !is.na(merged[[col_true]]) & !is.na(merged$Group)
  n_total <- nrow(merged)
  n_valid <- sum(valid)
  n_correct <- sum(merged[[col_true]] == merged$Group, na.rm = TRUE)
  n_missing_truth <- sum(is.na(merged[[col_true]]))
  n_missing_parsed <- sum(is.na(merged$Group))
  n_wrong <- sum(valid & merged[[col_true]] != merged$Group)
  
  cat("  Total tips:           ", n_total, "\n")
  cat("  Ground truth present:  ", n_total - n_missing_truth, "\n")
  cat("  Rclade parsed:         ", n_total - n_missing_parsed, "\n")
  cat("  Correct:               ", n_correct, "\n")
  cat("  Wrong:                 ", n_wrong, "\n")
  cat("  Accuracy (of parsed):  ", sprintf("%.1f%%", 100 * n_correct / (n_total - n_missing_parsed)), "\n")
  cat("  Accuracy (of all):     ", sprintf("%.1f%%", 100 * n_correct / n_total), "\n")
  
  if (n_wrong > 0) {
    cat("\n  Mismatches:\n")
    wrong_cases <- merged[valid & merged[[col_true]] != merged$Group, ]
    for (i in seq_len(nrow(wrong_cases))) {
      cat(sprintf("    Tip %s: true=%s, parsed=%s\n",
                  wrong_cases$label[i], wrong_cases[[col_true]][i], wrong_cases$Group[i]))
    }
  }
  
  cat("\n")
  
  data.frame(
    rank = rank_name,
    n_tips = n_total,
    n_truth_available = n_total - n_missing_truth,
    n_parsed = n_total - n_missing_parsed,
    n_correct = n_correct,
    n_wrong = n_wrong,
    accuracy_parsed = n_correct / (n_total - n_missing_parsed),
    accuracy_all = n_correct / n_total,
    stringsAsFactors = FALSE
  )
}

phylum_result <- verify_rank("phylum", "phylum")
class_result  <- verify_rank("class", "class")
order_result  <- verify_rank("order", "order")

all_results <- rbind(phylum_result, class_result, order_result)
cat("=== Summary ===\n")
print(all_results)

write.csv(all_results, 
          file.path("benchmark_results", "taxonomy_accuracy_example_tree.csv"),
          row.names = FALSE)
cat("\nResults saved to benchmark_results/taxonomy_accuracy_example_tree.csv\n")

# Also test embedded format strategies if labels support it
cat("\n=== Embedded format strategy comparison ===\n")
embedded_labels <- paste0(
  sapply(strsplit(labels, ";"), function(x) paste(rev(x), collapse = "_")),
  "_s__Species"
)
# Only test if labels are parseable with embedded format
detected <- Rclade::detect_taxonomy_format(embedded_labels)
cat("Format detection on embedded-style labels:", detected, "\n")

if (detected == "embedded") {
  for (strategy in c("reverse", "greedy", "segment")) {
    cat("\nStrategy:", strategy, "\n")
    tryCatch({
      p <- Rclade::parse_taxonomy(embedded_labels, rank = "phylum", 
                                  format = "embedded", embedded_strategy = strategy)
      cat("  Parsed", nrow(p), "tips,", length(unique(p$Group)), "unique phyla\n")
    }, error = function(e) cat("  Error:", e$message, "\n"))
  }
}
