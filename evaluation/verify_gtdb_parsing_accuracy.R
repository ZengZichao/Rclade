#!/usr/bin/env Rscript
# Verify GTDB real-data parsing accuracy claimed in manuscript section 3.5.
# Reproduces parsing_accuracy_real_data.csv with Rclade >= 1.0.0.
#
# Usage: Rscript verify_gtdb_parsing_accuracy.R <ar53_taxonomy.tsv> <out_csv>

suppressPackageStartupMessages(library(Rclade))

args <- commandArgs(trailingOnly = TRUE)
tax_file <- if (length(args) >= 1) args[1] else "ar53_r232_taxonomy.tsv"
out_file <- if (length(args) >= 2) args[2] else "parsing_accuracy_real_data.csv"

tax <- read.table(tax_file, sep = "\t", stringsAsFactors = FALSE,
                  col.names = c("label", "taxonomy"))
ranks <- c("domain", "phylum", "class", "order", "family", "genus", "species")

out <- data.frame(rank = ranks, n_labels = nrow(tax),
                  non_na_rate = NA_real_, exact_match_rate = NA_real_)
for (i in seq_along(ranks)) {
  rk <- ranks[i]
  p <- parse_taxonomy(tax$taxonomy, rank = rk, format = "GTDB")
  # Cardinality assertion (v1.1.0, reviewer issue 5): exactly one prediction
  # per input label; comparisons below are positional.
  stopifnot(nrow(p) == nrow(tax))
  v <- p$Group
  pre <- substr(rk, 1, 1)
  truth <- if (rk == "domain") {
    sub("^d__([^;]+).*$", "\\1", tax$taxonomy)
  } else {
    sub(paste0("^.*;", pre, "__([^;]+).*$"), "\\1", tax$taxonomy)
  }
  out$non_na_rate[i] <- round(mean(!is.na(v)), 6)
  out$exact_match_rate[i] <- round(mean(v == truth, na.rm = TRUE), 6)
}
write.csv(out, out_file, row.names = FALSE)
print(out)
