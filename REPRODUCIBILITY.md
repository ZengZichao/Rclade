# Rclade Reproducibility Guide (v1.1.0)

This document maps every quantitative result reported in the manuscript to
its exact inputs, scripts, and outputs, per the pre-submission review
(reviewer issues 6/7). All paths are relative to the archived snapshot
(tag `v1.1.0`, commit `69dde83`; archived at Zenodo, version-specific DOI
[10.5281/zenodo.22106523](https://doi.org/10.5281/zenodo.22106523),
all versions: [10.5281/zenodo.22043060](https://doi.org/10.5281/zenodo.22043060)).

## 1. Computational environment

- Recorded **after loading Rclade and every benchmark dependency** in
  `benchmark_results/sessionInfo.txt` (fixes the previous base-only
  record).
- Hardware: MacBook Pro (Mac17,2), Apple M5, 32 GB unified memory,
  macOS 26.6; R 4.5.3 (micromamba `r-4.5.3` environment).
- Key versions: Rclade 1.1.0, ggplot2 4.0.3, ggtree 4.0.4, ape 5.8-1,
  deeptime 2.4.0, bench 1.1.4, testthat 3.3.1.

## 2. Unified measurement protocol (v1.1.0, reviewer issue 3)

All in-session timings use `bench::mark` with **5 replicates at every
scale**, and every timed expression forces full rendering
(`ggplot2::ggplotGrob()` inside each iteration) for both Rclade and the
baseline. Process-level wall-clock / peak RSS use
`/usr/bin/time -l` over **5 independent processes per configuration**.
Both pipelines run in their default configuration
(`low_memory = FALSE`; rectangular layout; `mixed` triangle mode).
The reported statistics are medians with min/max; full per-replicate
values are in the raw CSVs below.

Synthetic trees (`ape::rcoal`) are computational workloads only: their
branch lengths are coalescent units, not geological ages, and the
explicit `unit = "Ma"` required by the v1.1.0 unit contract serves only
to exercise the timescale code path.

## 3. Table / Figure mapping

| Manuscript item | Script | Raw output | Notes |
|---|---|---|---|
| Table 3 (synthetic, in-session) | `scripts/benchmark_synthetic.R` | `benchmark_results/benchmark_synthetic_rendered.csv` | 5 replicates; grob forced per iteration |
| Table 3 (process-level) | `scripts/run_process_level.sh` + `scripts/benchmark_synthetic_once.R` | `benchmark_results/process_level_metrics.csv` | 5 process runs per config; columns `config,rep,wall_s,max_rss_mb` |
| Table 4 (ar53, in-session) | `scripts/benchmark_real_timing.R` | `benchmark_results/ar53_benchmark.csv` | reports `groups_total / groups_collapsed / groups_singleton / groups_skipped_*`; 5 replicates |
| Table 4 (ar53, process-level) | `scripts/benchmark_real_once.R` under `/usr/bin/time -l` | `benchmark_results/ar53_process_metrics.csv` | 5 process runs per rank |
| Table 4 (GBM 700-tip row) | `inst/extdata/moody2025_gbm_laca_timetree.nwk` + `plot_timetree(..., taxonomy_format = "custom_regex")` | archived tree shipped with the package | see §4 |
| Accuracy, built-in example | `scripts/verify_taxonomy_accuracy.R` | `benchmark_results/taxonomy_accuracy_example_tree.csv` | positional alignment + cardinality assertions (fixes the 50→250 merge inflation) |
| Accuracy, GTDB R232 | `evaluation/verify_gtdb_parsing_accuracy.R` | `evaluation/parsing_accuracy_real_data.csv` | positional comparison with cardinality assertion; internal-consistency evidence, not independent ground truth |
| §3.5 embedded evaluation (Moody 700-tip) | `inst/extdata/moody2025_gbm_laca_timetree.nwk` + `parse_taxonomy()` (reverse/greedy/segment/custom_regex) | `benchmark_results/embedded_evaluation_moody700.csv` | coverage and exact-match per strategy and rank; author-reformatted labels of a published topology (derived test set) |
| Figure 2 group-to-colour mapping | generated from the same custom_regex parse + viridis palette | `benchmark_results/gbm_phylum_color_mapping.csv` | 125 candidate phyla with status (collapsed/singleton/skipped) and hex colour |
| Figure 3 / §3.4 straightness | `scripts/measure_straightness.R` | `benchmark_results/straightness_deviation.csv` | 15-tip reference example |
| Straightness (extended, issue 9) | `scripts/measure_straightness_extended.R` | `benchmark_results/straightness_deviation_extended.csv` + `benchmark_results/straightness_extended_figs/` | 3 seeds × 3 sizes × 2 clades; 54 renders across pdf/png/svg at 2 sizes |

## 4. External inputs (fixed identifiers)

| Input | Source | Licence | SHA-256 | Redistribution |
|---|---|---|---|---|
| `ar53_r232.tree` | GTDB Release 232 (R11-RS232), https://gtdb.ecogenomic.org | CC BY-SA 4.0 | `e55e24b4c3b0b62b45ff351ed0257ed6d7067c7e7c4aa25fff486efdfe00ef79` | not redistributed (large external file); download by exact file name and verify checksum |
| `ar53_r232_taxonomy.tsv` | GTDB Release 232 (R11-RS232) | CC BY-SA 4.0 | `897be230163fc8ad87b65e70a4dfa9f3a5b1270c62215c07786a1812a160a336` | not redistributed; verify checksum |
| `inst/extdata/moody2025_gbm_laca_timetree.nwk` | Moody et al. 2025 700-tip archaeal timetree (BEAST export) | CC BY 4.0 | `6cfe92c28b8533c8177c748f14fddb1173325118c39afb5f2e50b3536ef9df8f` | **redistributed with attribution** in `inst/extdata/`; topology, branch lengths, and node annotations unchanged; tip labels carry author-reformatted embedded GTDB-style lineages as described in manuscript §3.5 |

## 5. How to reproduce end-to-end

```bash
# 1. Install the archived package (tag v1.1.0)
R CMD INSTALL Rclade_1.1.0.tar.gz

# 2. Unit / contract suite (241 blocks + new unit-contract and
#    group-accounting tests)
Rscript -e 'Sys.setenv(NOT_CRAN="true"); library(testthat); library(Rclade); test_dir("tests/testthat")'

# 3. Benchmarks (unified protocol; ~30 min total)
Rscript scripts/benchmark_synthetic.R
bash scripts/run_process_level.sh          # uses Rscript from PATH; override with RSCRIPT=
Rscript scripts/benchmark_real_timing.R <ar53_tree> <ar53_taxonomy> phylum
Rscript scripts/verify_taxonomy_accuracy.R
Rscript evaluation/verify_gtdb_parsing_accuracy.R <ar53_taxonomy> evaluation/parsing_accuracy_real_data.csv
Rscript scripts/measure_straightness.R
Rscript scripts/measure_straightness_extended.R
```

All scripts resolve interpreters and inputs from arguments or `PATH`; no
machine-specific absolute paths remain (reviewer issue 6).

## 6. Known boundaries (honest scope statements)

- The CI `deps-smoke` job verifies installation and the pure unit suite
  against the **current** resolvable dependency set; the DESCRIPTION
  version lower bounds are **not** exercised by CI.
- Coverage upload is best-effort (`fail_ci_if_error: false`, no token)
  and is a monitoring metric, not an enforced quality gate.
- GTDB parsing accuracy compares predictions against fields extracted
  from the same lineage strings (internal consistency); SILVA/NCBI
  evaluations in the manuscript are derived format-conversion test sets,
  not native-database samples.
