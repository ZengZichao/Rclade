## CRAN submission comments for Rclade 1.0.1

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
