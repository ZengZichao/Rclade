#!/usr/bin/env Rscript
# Embed a taxonomy table into tip labels and write a quoted Newick file.
# Usage: Rscript scripts/make_labeled_tree.R <tree_file> <taxonomy_tsv> <out_tree>

suppressPackageStartupMessages(library(ape))
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 3) stop("Usage: make_labeled_tree.R <tree_file> <taxonomy_tsv> <out_tree>")
tree_file <- args[1]
tax_file <- args[2]
out_file <- args[3]

tree <- read.tree(tree_file)
tax <- read.table(tax_file, sep = "\t", stringsAsFactors = FALSE,
                   col.names = c("label", "taxonomy"))
m <- match(tree[["tip.label"]], tax$label)
if (any(is.na(m))) stop("Some tip labels not found in taxonomy table")
new_labs <- paste0(tree[["tip.label"]], "|", tax$taxonomy[m])
tree[["tip.label"]] <- new_labs
write.tree(tree, out_file)
message("Labeled tree written to: ", out_file)
message("Tips: ", Ntip(tree))
