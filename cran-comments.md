## CRAN submission comments for Rclade 1.1.0

### Update from 1.0.2

This update implements the fixes required by the pre-submission
independent review. Key changes:

- BREAKING (fail-safe): `unit` is now required whenever
  `add_timescale = TRUE`. The previous silent default (unit = NULL
  interpreted as "Ga", multiplying edge lengths by 1000) has been
  removed; the pipeline aborts with an informative error instead.
  Added: non-finite edge-length check and an auditable root-to-tip
  dispersion warning.
- Group-status accounting: `rclade_info` and `summarize_timetree()`
  now report parsed / collapsed / singleton / skipped group counts
  and names (non-monophyletic groups are skipped with a warning by
  default).
- Benchmark protocol unified: 5 replicates per configuration with an
  identical fully-rendered measurement boundary; all benchmark
  artifacts refreshed (archived with the GitHub release / Zenodo
  snapshot, excluded from R builds via `.Rbuildignore`).
- Reproducibility: REPRODUCIBILITY.md and MANIFEST.tsv added; the
  Moody et al. 2025 700-tip timetree (CC BY 4.0, author-reformatted
  labels) is now shipped in `inst/extdata/`.
- Accuracy evaluation scripts now align predictions positionally with
  cardinality assertions (fixes a merge inflation in the built-in
  example evaluation).
- CI described honestly: the former `min-deps` job is renamed
  `deps-smoke` (DESCRIPTION lower bounds are not exercised by CI);
  coverage upload remains best-effort.
- New tests: test-unit-contract.R and test-group-accounting.R
  (241 test blocks total, all passing).

## CRAN submission comments for Rclade 1.0.2

### Update from 1.0.1

This is a minor update of Rclade. The key changes from 1.0.1 are:

- Refreshed benchmark results re-run against the v1.0.1 code base
  (which includes the 2026-08-16 Newick bracket-balance vectorization
  and parsing-pipeline fixes): in-session rendering at 10,000 tips
  improved from ~1.4 s to ~0.9 s (median); real-data timing on the GTDB
  ar53 tree (10,122 tips, 25 phyla) is now reported (4.3–6.4 s
  in-session and 5.6–9.3 s process-level across phylum/class/order).
  Benchmark artifacts live in `benchmark_results/` and `scripts/`, both
  excluded from R builds via `.Rbuildignore` and archived with the
  GitHub release / Zenodo snapshot instead.
- Adds reproducibility scripts `scripts/benchmark_real_timing.R`
  (real-data in-session timing) and
  `scripts/make_ncbi_rank_shift_example.R` (deterministic regeneration
  of the NCBI rank-shift example); both excluded from R builds.
- No changes to package code, exports, or behaviour relative to 1.0.1.

### R CMD check results (local)

`R CMD check --no-manual --as-cran Rclade_1.0.2.tar.gz` was run on
macOS aarch64 (Apple M5) with R 4.5.3 in a micromamba-managed environment.

There were 0 ERRORs and 0 WARNINGs. The only NOTE was the standard
incoming-feasibility NOTE for a CRAN submission; the tarball contains
no non-standard files (benchmark artifacts, backup directories, and OS
detritus are excluded via `.Rbuildignore`).

In addition, the GitHub Actions workflow (`R-CMD-check.yaml`) runs
`R CMD check` on ubuntu-latest (R release/oldrel/devel), macos-latest
(R release) and windows-latest (R release); all pass for the v1.0.2 tag.

### Test results (unchanged from 1.0.1; no code changes)

- `R CMD check` tests (testthat, summary reporter):
  **PASS 451 / FAIL 0 / SKIP 8 (459 total)** — the 8 skips are the
  tests marked `skip_on_cran()`, expected under `--as-cran`;
  vdiffr visual-regression snapshots run under `NOT_CRAN=true` in CI.
- `testthat::test_dir("tests/testthat")` (Junit count): 459 cases / 0 fail / 7 skip.
- Functional suite: smoke 57/57 pass, full 67/67 pass.
- `run_rclade_selftest()`: all checks pass.

### ggtree version compatibility

ggtree `>= 4.0.0` is declared in DESCRIPTION. Development and testing were
conducted with ggtree 4.0.4 (tested range: ggtree 4.0.0–4.0.4,
ggplot2 3.5.0–4.0.3). The package has not been tested with ggtree 3.x and may
rely on behaviors specific to ggtree 4.x. A CI job (`min-deps`) smoke-tests
the declared CRAN minimum versions (ggplot2 3.5.0, deeptime 1.0.0,
stringr 1.5.0, ape 5.0); Bioconductor packages cannot be version-pinned and
are exercised at the current release.

### URL/BugReports field

`URL` (https://github.com/zengzichao/Rclade) and `BugReports`
(https://github.com/zengzichao/Rclade/issues) fields are set in
DESCRIPTION. The GitHub repository is public.

### Configuration files

`config.example.yaml` and `manuscript_config.yaml` are shipped in `inst/extdata/` so
they are accessible via `system.file("extdata", ..., package = "Rclade")`.

### Downstream dependencies

There are no downstream dependencies.

---

## CRAN submission comments for Rclade 1.0.1 (previous submission)

### Update from 1.0.0

This is a minor update of Rclade. The key changes from 1.0.0 are:

- Adds an `evaluation/` directory (excluded from R builds via
  `.Rbuildignore`) containing real-data parsing-accuracy results
  (`parsing_accuracy_real_data.csv`; complete GTDB R232 ar53 taxonomy
  table, 10,122 labels x 7 ranks: 100% non-NA rate and 100% exact-match
  agreement) and a reproducible verification script
  (`verify_gtdb_parsing_accuracy.R`), supporting the parsing-accuracy
  evaluation reported in the accompanying manuscript.
- No changes to package code, exports, or behaviour.

### R CMD check results (local)

`R CMD check --no-manual --as-cran Rclade_1.0.1.tar.gz` was run on
macOS aarch64 (Apple M5) with R 4.5.3 in a micromamba-managed environment.

There were no ERRORs, WARNINGs or NOTEs.

In addition, the GitHub Actions workflow (`R-CMD-check.yaml`) runs
`R CMD check` on ubuntu-latest (R release/oldrel/devel), macos-latest
(R release) and windows-latest (R release); all pass.

### Test results (unchanged from 1.0.0; `evaluation/` adds no tests)

- `R CMD check` tests (testthat, canonical summary reporter):
  **451 pass / 0 fail / 7 skip (458 total)**.
- `testthat::test_dir("tests/testthat")` (Junit count): 459 cases / 0 fail / 7 skip.
- Functional suite: smoke 57/57 pass, full 67/67 pass.
- `run_rclade_selftest()`: all checks pass.

### ggtree version compatibility

ggtree `>= 4.0.0` is declared in DESCRIPTION. Development and testing were
conducted with ggtree 4.0.4 (tested range: ggtree 4.0.0–4.0.4,
ggplot2 3.5.0–4.0.3). The package has not been tested with ggtree 3.x and may
rely on behaviors specific to ggtree 4.x. A CI job (`min-deps`) smoke-tests
the declared CRAN minimum versions (ggplot2 3.5.0, deeptime 1.0.0,
stringr 1.5.0, ape 5.0); Bioconductor packages cannot be version-pinned and
are exercised at the current release.

### URL/BugReports field

`URL` (https://github.com/zengzichao/Rclade) and `BugReports`
(https://github.com/zengzichao/Rclade/issues) fields are set in
DESCRIPTION. The GitHub repository is public.

### Configuration files

`config.example.yaml` and `manuscript_config.yaml` are shipped in `inst/extdata/` so
they are accessible via `system.file("extdata", ..., package = "Rclade")`.

### Downstream dependencies

There are no downstream dependencies.
