#!/usr/bin/env Rscript
# Reproduce benchmark_results/ncbi_rank_shift_example.csv deterministically.
#
# Demonstrates the positional rank shift of Rclade's NCBI parser on a
# virus-style lineage. parse_ncbi() splits on ';', strips the LEADING
# skip-prefix token ("Viruses"), then maps the remaining tokens POSITIONALLY
# to domain..species. Because viral lineages insert realm/kingdom levels that
# GTDB omits, every parsed rank lands 1-2 levels above its true biological
# rank -- the offset recorded in the `true_rank` column (curated biological
# rank of each token, which Rclade cannot know).
#
# Output schema is identical to the committed CSV, so this file is fully
# reproducible (no hand-editing). See 基准测试完整流程.md, section on the
# 6 CSVs / ncbi gap.
#
# Usage: Rscript scripts/make_ncbi_rank_shift_example.R [out_csv]
#   [out_csv]  output CSV (default benchmark_results/ncbi_rank_shift_example.csv)

suppressPackageStartupMessages(library(Rclade))

args <- commandArgs(trailingOnly = TRUE)
out_csv <- if (length(args) >= 1) args[1] else "benchmark_results/ncbi_rank_shift_example.csv"

# 8-token NCBI viral lineage. "Viruses" is a leading skip-prefix stripped by
# parse_ncbi(); the remaining 7 tokens map positionally to domain..species.
lineage <- "Viruses; Riboviria; Orthornavirae; Negarnaviricota; Haploviricotina; Monjiviricetes; Mononegavirales; Filoviridae"

# The exported parse_taxonomy(format = "NCBI") is rank-scoped (returns
# label + Group for one rank). The 7-column positional mapping that this
# example demonstrates lives in the internal helper parse_ncbi(), which is
# exactly what produced the committed CSV.
parsed <- Rclade:::parse_ncbi(lineage)

rank_names <- c("domain", "phylum", "class", "order", "family", "genus", "species")
# Biological (true) rank of each positional token.
true_ranks <- c("realm", "kingdom", "phylum", "class", "subclass", "order", "family")

out <- data.frame(
  parsed_rank  = rank_names,
  parsed_value = unname(unlist(parsed[1, rank_names])),
  true_rank    = true_ranks,
  stringsAsFactors = FALSE
)

write.csv(out, out_csv, row.names = FALSE)
cat("NCBI rank-shift example saved ->", out_csv, "\n")
print(out)
