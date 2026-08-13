# Rclade News

## Rclade 2.0.0 (2026-08-13, Major Release)

Clean-release major version. Removes all bundled third-party reference data
to ensure clean redistribution, while preserving full software functionality.

* **Removed bundled data**: the `data-external/` directory (external
  literature-derived tree files) and all GTDB reference data files
  (`inst/extdata/ar53_r232.tree`, `inst/extdata/gtdb_sample_labels.txt`,
  `inst/extdata/download_gtdb_data.R`) are no longer included in the
  package. The software still fully supports parsing GTDB-format taxonomy
  labels as a built-in feature.
* **Removed GTDB-dependent scripts and tests**: deleted
  `scripts/extract_gtdb_node_taxonomy.R`,
  `scripts/benchmark_bac120_subsample.R`,
  `scripts/evaluate_parsing_real_data.R`,
  `scripts/benchmark_real_session.R`, and the entire
  `tests/testthat/external/` test suite (which required external GTDB
  reference data).
* **Updated documentation**: README, CITATION, THIRDPARTY, cran-comments,
  CI workflow, and vignettes updated to remove references to bundled GTDB
  data. GTDB remains listed as a supported taxonomy format.
* **Updated benchmark scripts**: renamed format-specific helper functions
  to format-neutral names; removed GTDB data-dependent benchmark sections.
* **Version bump**: 1.0.0 → 2.0.0 to reflect the clean redistribution
  scope change.

## License and attribution compliance (2026-08-04, unreleased)

* **License corrections**: the deeptime license was incorrectly listed as
  "MIT" in the logo, CLI help, and README files; it is actually GPL (>= 3).
  The treeio license was incorrectly listed as "GPL-2+"; it is actually
  Artistic-2.0. Both have been corrected in `R/logo.R`, `R/cli.R`,
  `README.CN.md`, and `README.EN.md`.
* **Third-party notices**: a new `inst/THIRDPARTY` file now provides a
  centralized declaration of all third-party dependencies, bundled data, and
  their licenses.
* **Citation file**: `inst/CITATION` now includes recommended citations for
  ggtree (Yu et al. 2017), deeptime (Gearty 2025), and GTDB (Parks et al.
  2020) alongside the Rclade citation.
* **GTDB data license**: the bundled `ar53_r232.tree` is now explicitly
  declared as CC BY 4.0 in README files and `inst/THIRDPARTY`.
* **Vignette references**: all three vignettes now include a "References &
  Acknowledgments" section listing key dependencies and data sources.
* **Function documentation**: `plot_timetree()` Rd now includes a
  `\references{}` section with ggtree, deeptime, and ape citations.
* **Copyright headers**: all R source files now carry a copyright and license
  notice at the top of each file.

## Manuscript-review hardening (2026-08-03, unreleased)

Addresses the editor/reviewer pass over the 1.0.0 manuscript (real-data
parsing evaluation, unified benchmark protocol):

* **Format detection (M-B3)**: the GTDB detection rule now additionally
  requires a semicolon-delimiter majority. Accession-prefixed embedded labels
  with double-underscore rank separators (e.g. `GCA_xxx_d__Archaea_p__X`)
  previously matched the `[dpcofgsk]__` pattern and were misclassified as
  GTDB; they are now correctly detected as `embedded` (real-world case:
  700-tip LACA timetree, §3.5 of the manuscript).
* **Embedded parsing**: `parse_embedded()` (all three delimiter modes) now
  tolerates double-underscore rank separators (`_p__value`), and leading
  underscores left over from such schemes are trimmed from parsed values.
* **Tests**: new `test-straight-vdiffr.R` adds vdiffr visual-regression
  snapshots of collapsed circular/rectangular renderings to guard against
  rendering drift across ggplot2/ggtree updates (executed when NOT_CRAN=true).
* **Scripts**: adds `evaluate_parsing_real_data.R`, `measure_straightness.R`,
  `benchmark_real_session.R`, `benchmark_bac120_subsample.R`, and
  `run_process_level.sh`; `benchmark_synthetic.R` unified to >=3 replicates
  at every scale; fixes a fragile `regexpr()` construct in
  `baseline_manual_workflow.R`.

## Remediation round 2 (2026-08-01, unreleased)

Addresses remaining items from `修改计划_Rclade_v1.0.0.md`:

* **API surface convergence (P0-2)**: 27 infrastructure functions (logging,
  timers, temp-file helpers, validators, etc.) moved from exported to internal
  (`@keywords internal`); NAMESPACE reduced from 52 to 26 exports. New
  `rclade_options()` constructor provides a validated parameter object for
  `plot_timetree(opts = ...)` (route B1: backward-compatible, explicit args
  take precedence).
* **Manuscript**: supplementary "Searched alternatives" table added (CN/EN);
  §2.6.1 formalizes NCBI/Silva 0.3 threshold alongside GTDB/embedded 0.6;
  §2.6.3 computational-complexity table added; abstract notes single-run
  measurements at n >= 5000; §2.7 cross-references the searched-alternatives
  table; Chinese §4.3 adds O(n·k) notation.
* **Docs**: `run_rclade_cli()` Rd documents exit-code contract with examples;
  `run_rclade_shiny()` Rd adds a Concurrency section warning about global
  state; `test-performance.R` header clarifies catastrophic-regression intent.
* **Engineering**: `environment.yml` removes `r-devtools` from runtime deps;
  README (CN/EN) adds lockfile reproducibility guidance; `tests/functional/`
  test IDs and comments fully translated to English.

## Post-review hardening (2026-07-30, unreleased)

A structured editor-style review of the 1.0.0 manuscript and codebase was
fully addressed (see `主编审阅报告_Rclade_v1.0.0.md` in the project workspace).
User-visible changes:

* **Rendering/time axis**: the x-axis range is now adaptive (`compute_x_min()`
  floors at -4567 Ma only when the tree root actually reaches into the
  Hadean); the erroneous injection of "Hadean" into the *eras* table
  (a Hadean is an eon, not an era) was removed; displayed-leaves counting
  after collapse no longer includes backbone internal nodes.
* **CLI**: `-u/--unit` default changed from `Ga` to `auto` (aligned with the
  R API; `Ga` still converts x1000); work around an optparse >= 1.8
  prefix-collision that leaked sibling defaults into `--highlight`,
  `--clade` and `--taxonomy_file`; `--strip_annotations` now drops treedata
  columns by annotation pattern (support/rate/height/HPD/NHX/taxid).
* **R API**: `ignore_malformed = TRUE` is now honoured in the multiPhylo
  batch path (failed trees become NULL placeholders, as documented);
  `delimiter_mode` defaults unified to `"reverse"` across all exported
  functions; format-detection clear-majority threshold (score >= 0.6) made
  tolerant to binary floating-point error; Newick bracket-balance
  validation vectorized (large-tree speedup).
* **Docs/metadata**: DESCRIPTION lists the embedded format; third-party
  attribution in the logo/CLI help corrected (ggtree >= 4.0, deeptime
  Gearty 2025); withr added to Suggests; non-ASCII characters removed from
  `shiny-app.R`; Shiny no longer loads remote fonts; the Dockerfile installs
  from source (no bundled tarball), uses R 4.5.3 and propagates the
  documented Unix exit codes via `q(status = ...)`.
* **Tests/CI**: new tests for displayed-leaves counting, adaptive x_min and
  the Shiny app; stale functional-test expectations aligned with intentional
  behaviour (duplicate-tip warning, non-interactive overwrite="ask",
  Silva detection fallback); CI Stage B now uses `stop_on_failure = TRUE`
  and a declared-minimum-dependencies job was added; codecov.yml uses the
  standard flags + status schema.

## Rclade 1.0.0 (2026-07-09, First Stable Release)

First stable release. Consolidates the 0.2.0 development series into a formal release and aligns the manuscript with the project code.

* Unified version to 1.0.0 to mark the first stable release.
* All examples and result figures now use `FigTree_withLACA_GBM_95CI.tree.recover` (the 700-tip archaeal timetree published by Moody et al. 2025, Phil. Trans. R. Soc. B 380:20240097, doi:10.1098/rstb.2024.0097; redistributed with attribution).
* Manuscript supplementary material now fully includes the circular-layout straight-edge technical document.
* Cleaned junk files from the project code (`.DS_Store`, `tests/testthat/_problems/`, `tests/functional/output/`, empty directories).
* Fixed path references, version wording, and bibliography citations in the manuscript.
* Fixed geological timescale rendering under ggplot2 4.x, regenerated roxygen documentation, and synced dependency declarations and docs.

See the language-specific release notes for full historical details:

- [English](NEWS.EN.md)
- [中文](NEWS.CN.md)
