# Benchmark Results

This directory contains raw benchmark and evaluation data for Rclade.

## Test Environment

- Hardware: MacBook Pro (Mac17,2; Apple M5, 32 GB unified memory)
- OS: macOS 26.6 (aarch64-apple-darwin)
- R: 4.5.3 (micromamba `r-4.5.3` environment)
- ggtree: 4.0.4, ggplot2: 4.0.3 (development environment)
- Complete environment: `sessionInfo.txt`

## File Descriptions

### benchmark_synthetic_rendered.csv

In-session rendering benchmarks on synthetic trees (200–10,000 tips),
`bench::mark` medians/means/sd for Rclade versus a core-collapsing-only ggtree
baseline (5 replicates for n < 5,000; 3 replicates for n >= 5,000).
Reproduce with `scripts/benchmark_synthetic.R`.

### process_level_metrics.csv

Process-level wall-clock time and peak RSS memory measured with
`/usr/bin/time -l` (single run per configuration), including R startup and
package loading, for the synthetic series.
Reproduce with `scripts/run_process_level.sh` (which drives
`scripts/benchmark_synthetic_once.R`).

### benchmark_split_cost_1000.csv

Split-stage timing at n = 1,000 (3 replicates, proc.time protocol): format
detection/parsing, MRCA + monophyly, collapse/render, full Rclade pipeline,
and the ggtree baseline. Reproduce with `scripts/benchmark_split_cost.R`.

### ncbi_rank_shift_example.csv

Quantified positional rank shift of the NCBI parser on a 9-token virus-style
lineage (parsed columns shift by 1–2 true ranks).

### straightness_deviation.csv

Maximum perpendicular deviation of collapsed-triangle edges from the ideal
straight chord in npc space, measured on the Figure 3 tree
(ggtree coord_munch pipeline vs Rclade vertex-only pipeline).
Reproduce with `scripts/measure_straightness.R`.

### taxonomy_accuracy_example_tree.csv

Phylum/class parsing validation on the built-in 50-tip `example_tree`
(100% correctness at both ranks).
Reproduce with `scripts/verify_taxonomy_accuracy.R`.

## Notes

- All benchmark random seeds are fixed (`set.seed(42)`).
- In-session columns report `bench::mark` medians because replicate
  distributions are right-skewed at large n.
- Memory values are peak RSS from `/usr/bin/time -l` and are subject to macOS
  memory compression and system caching.
- The ggtree baseline measures only MRCA computation + `scaleClade` +
  `ggtree::collapse()` (mode = "mixed"); it excludes Rclade's automation
  features. Comparisons quantify the cost of automation, not like-for-like
  speed.
