## CRAN submission comments for Rclade 2.0.0

### New submission

This is a new major version of Rclade. The key changes from 1.0.0 are:

- Removed all bundled third-party reference data (GTDB reference tree and
  associated files) from the package. The software still supports parsing
  GTDB-format taxonomy labels as a built-in feature, but no longer ships
  GTDB data files.
- Removed the `data-external/` directory (external literature-derived tree
  files) and all references to it.
- Removed the GTDB-gated external test suite (`tests/testthat/external/`)
  and the GTDB data download script.
- Renamed internal helper functions and benchmark scripts that referenced
  GTDB data to use format-neutral names.

### R CMD check results (local)

`R CMD check --no-manual --as-cran Rclade_2.0.0.tar.gz` was run on
macOS aarch64 (Apple M5) with R 4.5.3 in a micromamba-managed environment.

There were no ERRORs.

There were no WARNINGs.

There was 1 NOTE:

* **New submission**: expected for a new version.

### Test results

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
