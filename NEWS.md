# Rclade News

## Rclade 1.0.1 (2026-08-21)

* **Evaluation data**: adds the `evaluation/` directory with real-data
  parsing-accuracy results (`parsing_accuracy_real_data.csv`; complete GTDB
  R232 ar53 taxonomy table, 10,122 labels x 7 ranks: 100% non-NA rate and
  100% exact-match agreement) and a reproducible verification script
  (`verify_gtdb_parsing_accuracy.R`), supporting the parsing-accuracy
  evaluation reported in the accompanying manuscript.
* No changes to package code. `evaluation/` is excluded from R builds via
  `.Rbuildignore`; DESCRIPTION and `.zenodo.json` versions bumped for
  archival.

## Robustness and rendering fixes (2026-08-16, unreleased)

* **Collapse-triangle alignment**: collapse triangles were horizontally
  offset from their clades when *every* tip in the tree was collapsed
  (e.g. collapsing all phyla at once). The cause was `revts()` (time-axis
  reversal) being applied a second time after collapse — with all tips
  collapsed away, `max(x)` is the shallowest MRCA instead of 0, so the
  second application shifted the whole tree while the fixed-coordinate
  triangle polygons stayed behind. Vertical positions were unaffected.
  `revts()` is now applied exactly once; triangle apexes align with their
  MRCA again.
* **Long-label guard**: Newick labels longer than 500 characters are now
  truncated to 400 characters + `_RCLADE_TRUNC` (with a warning) before
  parsing, because ape 5.8.1's Newick parser aborts the whole R process
  (glibc "stack smashing detected", exit 134) on labels longer than ~512
  characters on Linux. Documented in `read_tree_auto()` and
  `plot_timetree()`; truncate-aware notes added to README (EN/CN).
* **Adversarial-input messages**: control characters and Unicode BiDi
  markers detected in node names are now reported as `<U+XXXX>` escapes
  instead of raw characters, so error messages can no longer corrupt
  terminal output (and no longer trip C-level formatting).
* **Tests**: the two timing-ratio performance tests now measure calibrated
  blocks of repeats (>= ~100 ms per size) instead of single sub-millisecond
  `system.time()` reads, which made the max/min ratio pure clock-quantization
  noise (constant 8x failure on macOS and CI alike).
* **CI/docs**: pkgdown site now builds and deploys (dataset topics indexed,
  site URL added to DESCRIPTION, write permission granted); codecov upload
  failures no longer fail R-CMD-check (no token configured); the bilingual
  FAQ claim of "52 exported functions" corrected to 26.
* **`theme_timetree()` now returns a list**: the return value changed from a
  single ggplot2 theme object to `list(theme, coord)` where `coord` carries
  `clip = "off"` (breaking change for direct callers: use `p + th$theme`,
  then `add_clip_off(p, layout)` for clipping control). The rendering
  pipeline no longer adds the returned coord unconditionally —
  `add_clip_off()` applies `coord_polar(...)` (circular) or
  `coord_cartesian(clip = "off")` (rectangular) only when no timescale
  coordinate is present, preventing the coordinate from overwriting the
  polar / deeptime geo coordinate systems (T05).

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

## 1.0.0 Clean redistribution (2026-08-13)

* **Clean redistribution (2026-08-13)**: removed all bundled third-party reference data (`data-external/` and GTDB reference files under `inst/extdata/`) and GTDB-dependent scripts/tests (`scripts/extract_gtdb_node_taxonomy.R`, `scripts/benchmark_bac120_subsample.R`, `scripts/evaluate_parsing_real_data.R`, `scripts/benchmark_real_session.R`, `tests/testthat/external/`); updated README, CITATION, THIRDPARTY, cran-comments, CI workflow, and vignettes to drop bundled GTDB references; renamed format-specific benchmark helpers to format-neutral names.


See the language-specific release notes for full historical details:

- [English](https://github.com/zengzichao/Rclade/blob/main/NEWS.EN.md)
- [中文](https://github.com/zengzichao/Rclade/blob/main/NEWS.CN.md)
