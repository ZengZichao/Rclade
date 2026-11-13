# Rclade 1.1.6 (2026-11-02)

Label placement, HPD rendering and a new option for labelling without
collapsing.

- **Clade and tip labels are no longer clipped.** The x range now
  reserves space based on the measured text width (new `right_pad`
  argument on
  [`add_geo_timescale()`](https://zengzichao.github.io/Rclade/reference/add_geo_timescale.md),
  and matching x-scale expansion). Previously a right-edge clade label
  was cut off by the panel boundary.
- **Circular layout: tip labels are drawn radially.** `geom_tiplab()` in
  ggtree 4.x ignores the `angle` aesthetic under polar coordinates and
  applies its own rotation, which left the left half of the circle
  upside down. Labels are now drawn with
  [`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html)
  using per-tip angles, flipped and right-aligned on the left half.
- **HPD bars only for internal nodes.** Node tables shipped with tips as
  well, so extant species received an age interval they do not have.
- **HPD bars now render in circular layouts.**
  [`ggtree::geom_range()`](https://rdrr.io/pkg/ggtree/man/geom_range.html)
  produced no visible layer under polar coordinates; bars are drawn as
  radial segments instead.
- **New `plot_timetree(groups_label_only = TRUE)`** labels the clades
  defined by `groups` without collapsing them, keeping every terminal
  branch expanded.
- [`annotate_clade()`](https://zengzichao.github.io/Rclade/reference/annotate_clade.md)
  gains `hjust` so callers can right-align wide labels.

# Rclade 1.1.5 (2026-09-15, CRAN Resubmission)

CRAN resubmission. Addresses the three issues raised by the CRAN
reviewer for 1.1.4:

- **Single quotes in Description**: Single quotes are now reserved for R
  package names only (`'ggtree'`, `'deeptime'`, `'ape'`). Quotes were
  removed around acronyms and database names (GTDB, Silva, NCBI, MRCAs,
  LUCA, LACA, LBCA); “geoscales” is now described in words as geologic
  time scales because it is not a package name.
- **Reference format in Description**: References now use the
  `authors (year) <doi:...>` form: Yu et al. (2017)
  <doi:10.1111/2041-210X.12628>, Gearty (2025)
  <doi:10.1080/20964471.2025.2537516>, and Paradis and Schliep (2019)
  <doi:10.1093/bioinformatics/bty633>.
- **Console output in R/selftest.R**:
  [`run_rclade_selftest()`](https://zengzichao.github.io/Rclade/reference/run_rclade_selftest.md)
  and its internal helpers now report via
  [`message()`](https://rdrr.io/r/base/message.html) (suppressible with
  [`suppressMessages()`](https://rdrr.io/r/base/message.html)) instead
  of [`cat()`](https://rdrr.io/r/base/cat.html). A new `verbose`
  argument (default TRUE) allows fully silent runs. The returned exit
  code and every check outcome are unchanged.

No changes to package behaviour, exports, or test outcomes relative to
1.1.4.

# Rclade 1.1.4 (2026-09-08, CRAN Resubmission)

CRAN resubmission. Fixes the 2 WARNINGs and 1 NOTE reported by the CRAN
incoming pre-test for 1.1.3:

- **Pre-built vignettes**: The package has a `VignetteBuilder: knitr`
  field in DESCRIPTION, but `inst/doc` did not exist and no pre-built
  vignette HTML files were shipped. All three vignettes are now
  pre-built as HTML and placed in `inst/doc/` alongside their `.Rmd`
  sources.
- **Possibly misspelled words in DESCRIPTION**: The flagged words
  (`Gearty`, `Paradis`, `Schliep`, `Yu`, `et`, `al`) are author surnames
  and the Latin abbreviation “et al.” from bibliographic references.
  They are not misspellings. Documented in `cran-comments.md`.

No changes to package code, exports, or behaviour relative to 1.1.3.

# Rclade 1.1.3 (2026-09-07, CRAN Resubmission)

CRAN resubmission. Fixes the issue raised by the CRAN reviewer (Uwe
Ligges) for 1.1.2:

- **Single-quoted software names in Description**: The software names
  `ggtree`, `deeptime`, and `ape` in the bibliographic reference
  paragraph of the Description field were not enclosed in single quotes.
  They have been changed to `'ggtree'`, `'deeptime'`, and `'ape'`. The
  `.mimosa/` development directory is now also excluded via
  `.Rbuildignore`.

No changes to package code, exports, or behaviour relative to 1.1.2.

# Rclade 1.1.2 (2026-09-04, CRAN Resubmission)

CRAN resubmission. Fixes the two NOTEs reported by the win-builder
incoming pre-test for 1.1.1:

- **Non-standard top-level files**: `LICENSE.md`, `MANIFEST.tsv`, and
  `REPRODUCIBILITY.md` are now excluded from the built tarball via
  `.Rbuildignore` (development/reproducibility artefacts, not for
  distribution; the standard `LICENSE` file remains).
- **Possibly misspelled words in DESCRIPTION**: the flagged words
  (`ggtree`, `deeptime`, `Yu`, `et`, `al`, `Gearty`, `Paradis`,
  `Schliep`) are R package names and author surnames from the
  methodological references cited in the Description field; they are not
  misspellings. Documented in `cran-comments.md`.

No changes to package code, exports, or behaviour relative to 1.1.1.

# Rclade 1.1.1 (2026-09-03, CRAN Resubmission)

CRAN resubmission addressing all reviewer issues from the 1.0.0 review.

- Added methodological references (DOIs) to the DESCRIPTION file.
- Added `\value` tags to 5 Rd files (`print.rclade_options`,
  `run_rclade_shiny`, `set_log_enabled`, `set_log_file`,
  `set_log_level`).
- Removed examples from unexported (`@keywords internal`) Rd files.
- Removed `\dontrun{}` wrappers from exported examples. Where examples
  referenced external files, the code was removed; where they used
  bundled `data(example_tree)`, they are now executable.
- Replaced [`cat()`](https://rdrr.io/r/base/cat.html) with
  [`message()`](https://rdrr.io/r/base/message.html) in
  [`save_session_info()`](https://zengzichao.github.io/Rclade/reference/save_session_info.md)
  and
  [`summarize_multi_trees()`](https://zengzichao.github.io/Rclade/reference/summarize_multi_trees.md)
  for suppressible console output.
- Resolved `try-error in functionTree()` by converting examples.

# Rclade 1.1.0 (2026-08-26, Revision Release)

Fixes required by the pre-submission independent review (2026-08-24).
Contains one user-visible behavior change. See NEWS.md for the full
entry (and NEWS.CN.md for the Chinese edition); summary:

- **BREAKING**: `unit` is now required when `add_timescale = TRUE` (the
  silent `Ga` default that multiplied edge lengths by 1000 is removed);
  non-finite edge lengths abort; root-to-tip dispersion warns.
- **Group-status accounting**: `rclade_info` /
  [`summarize_timetree()`](https://zengzichao.github.io/Rclade/reference/summarize_timetree.md)
  report parsed / collapsed / singleton / skipped group counts and
  names, fixing the previous “Collapsed groups” label that reported
  parsed candidates instead of the clades actually collapsed.
- **Accuracy evaluation**: scripts align positionally with cardinality
  assertions (fixes the 50-tip -\> 250-row merge inflation).
- **Portable scripts**: `run_process_level.sh` resolves `Rscript` from
  `PATH` (override with `RSCRIPT=`) instead of a machine-specific
  absolute path.
- **Honest CI description**: `deps-smoke` does not verify DESCRIPTION
  lower bounds; coverage is a monitoring metric, not an enforced gate.

# Rclade 1.0.2 (2026-08-22)

- **Refreshed benchmark results**: all benchmarks were re-run against
  the v1.0.1 code base (which includes the 2026-08-16 Newick
  bracket-balance vectorization and parsing-pipeline fixes). In-session
  rendering at 10,000 tips improved from ~1.4 s to ~0.9 s (median);
  real-data timing on the GTDB ar53 tree (10,122 tips, 25 phyla) is now
  reported: 4.3 s in-session (median of 3) and 5.6 s process-level
  including R startup. Deterministic accuracy checks are unchanged (100%
  GTDB/example parsing accuracy; zero straight-edge deviation).
- **Reproducibility scripts**: adds `scripts/benchmark_real_timing.R`
  (real-data in-session timing, manuscript Table 4 source) and
  `scripts/make_ncbi_rank_shift_example.R` (deterministic regeneration
  of `ncbi_rank_shift_example.csv`, byte-identical to the committed
  file).
- No changes to package code relative to 1.0.1; DESCRIPTION and
  `.zenodo.json` versions bumped for archival.

# Rclade 1.0.1 (2026-08-21)

- **Evaluation data**: adds the `evaluation/` directory with real-data
  parsing-accuracy results (`parsing_accuracy_real_data.csv`; complete
  GTDB R232 ar53 taxonomy table, 10,122 labels x 7 ranks: 100% non-NA
  rate and 100% exact-match agreement) and a reproducible verification
  script (`verify_gtdb_parsing_accuracy.R`), supporting the
  parsing-accuracy evaluation reported in the accompanying manuscript.
- No changes to package code. `evaluation/` is excluded from R builds
  via `.Rbuildignore`; DESCRIPTION and `.zenodo.json` versions bumped
  for archival.

# Rclade 1.0.0 (2026-07-09, First Stable Release)

## Robustness and rendering fixes (2026-08-16, released in Rclade 1.0.1)

- **Collapse-triangle alignment**: collapse triangles were horizontally
  offset from their clades when *every* tip was collapsed (e.g. all
  phyla at once). `revts()` was applied a second time after collapse;
  with all tips collapsed away, `max(x)` is the shallowest MRCA instead
  of 0, shifting the whole tree while the fixed-coordinate triangle
  polygons stayed behind. Vertical positions were unaffected. `revts()`
  is now applied exactly once; triangle apexes align with their MRCA
  again.
- **Long-label guard**: Newick labels longer than 500 characters are
  truncated to 400 characters + `_RCLADE_TRUNC` (with a warning) before
  parsing, because ape 5.8.1’s Newick parser aborts the whole R process
  (glibc “stack smashing detected”, exit 134) on labels longer than ~512
  characters on Linux. Documented in
  [`read_tree_auto()`](https://zengzichao.github.io/Rclade/reference/read_tree_auto.md)
  and
  [`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md);
  notes added to README (EN/CN).
- **Adversarial-input messages**: control characters and Unicode BiDi
  markers in node names are reported as `<U+XXXX>` escapes instead of
  raw characters, so error messages cannot corrupt terminal output.
- **Tests**: timing-ratio performance tests now measure calibrated
  blocks of repeats (\>= ~100 ms per size) instead of single
  sub-millisecond
  [`system.time()`](https://rdrr.io/r/base/system.time.html) reads,
  which made the max/min ratio pure clock-quantization noise (constant
  8x failure on macOS and CI alike).
- **CI/docs**: pkgdown site now builds and deploys (dataset topics
  indexed, site URL in DESCRIPTION, write permission granted); codecov
  upload failures no longer fail R-CMD-check (no token configured); the
  bilingual FAQ claim of “52 exported functions” corrected to 26.
- **[`theme_timetree()`](https://zengzichao.github.io/Rclade/reference/theme_timetree.md)
  now returns a list**: the return value changed from a single ggplot2
  theme object to `list(theme, coord)` where `coord` carries
  `clip = "off"` (breaking change for direct callers: use
  `p + th$theme`, then `add_clip_off(p, layout)` for clipping control).
  The rendering pipeline no longer adds the returned coord
  unconditionally —
  [`add_clip_off()`](https://zengzichao.github.io/Rclade/reference/add_clip_off.md)
  applies `coord_polar(...)` (circular) or
  `coord_cartesian(clip = "off")` (rectangular) only when no timescale
  coordinate is present, preventing the coordinate from overwriting the
  polar / deeptime geo coordinate systems (T05).

## Clean redistribution (2026-08-13)

- Removed all bundled third-party reference data (`data-external/` and
  GTDB reference files under `inst/extdata/`) and GTDB-dependent
  scripts/tests (`scripts/extract_gtdb_node_taxonomy.R`,
  `scripts/benchmark_bac120_subsample.R`,
  `scripts/evaluate_parsing_real_data.R`,
  `scripts/benchmark_real_session.R`, `tests/testthat/external/`);
  updated README, CITATION, THIRDPARTY, cran-comments, CI workflow, and
  vignettes to drop bundled GTDB references; renamed format-specific
  benchmark helpers to format-neutral names.

## License and attribution compliance (2026-08-04, Rclade 1.0.1)

- **License corrections**: the deeptime license was incorrectly listed
  as “MIT” in the logo, CLI help, and README files; it is actually GPL
  (\>= 3). The treeio license was incorrectly listed as “GPL-2+”; it is
  actually Artistic-2.0. Both have been corrected in `R/logo.R`,
  `R/cli.R`, `README.CN.md`, and `README.EN.md`.
- **Third-party notices**: a new `inst/THIRDPARTY` file now provides a
  centralized declaration of all third-party dependencies, bundled data,
  and their licenses.
- **Citation file**: `inst/CITATION` now includes recommended citations
  for ggtree (Yu et al. 2017), deeptime (Gearty 2025), and GTDB (Parks
  et al.
  2020. alongside the Rclade citation.
- **GTDB data license**: the bundled `ar53_r232.tree` is now explicitly
  declared as CC BY 4.0 in README files and `inst/THIRDPARTY`.
- **Vignette references**: all three vignettes now include a “References
  & Acknowledgments” section listing key dependencies and data sources.
- **Function documentation**:
  [`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md)
  Rd now includes a `\references{}` section with ggtree, deeptime, and
  ape citations.
- **Copyright headers**: all R source files now carry a copyright and
  license notice at the top of each file.

## Manuscript-review hardening (2026-08-03, Rclade 1.0.1)

Addresses the editor/reviewer pass over the 1.0.0 manuscript (real-data
parsing evaluation, unified benchmark protocol):

- **Format detection (M-B3)**: the GTDB detection rule now additionally
  requires a semicolon-delimiter majority. Accession-prefixed embedded
  labels with double-underscore rank separators
  (e.g. `GCA_xxx_d__Archaea_p__X`) previously matched the `[dpcofgsk]__`
  pattern and were misclassified as GTDB; they are now correctly
  detected as `embedded` (real-world case: 700-tip LACA timetree, §3.5
  of the manuscript).
- **Embedded parsing**:
  [`parse_embedded()`](https://zengzichao.github.io/Rclade/reference/parse_embedded.md)
  (all three delimiter modes) now tolerates double-underscore rank
  separators (`_p__value`), and leading underscores left over from such
  schemes are trimmed from parsed values.
- **Tests**: new `test-straight-vdiffr.R` adds vdiffr visual-regression
  snapshots of collapsed circular/rectangular renderings to guard
  against rendering drift across ggplot2/ggtree updates (executed when
  NOT_CRAN=true).
- **Scripts**: adds `evaluate_parsing_real_data.R`,
  `measure_straightness.R`, `benchmark_real_session.R`,
  `benchmark_bac120_subsample.R`, and `run_process_level.sh`;
  `benchmark_synthetic.R` unified to \>=3 replicates at every scale;
  fixes a fragile [`regexpr()`](https://rdrr.io/r/base/grep.html)
  construct in `baseline_manual_workflow.R`.

## Remediation round 2 (2026-08-01, Rclade 1.0.1)

Addresses the remaining items from the Rclade v1.0.0 revision plan:

- **API surface convergence (P0-2)**: 27 infrastructure functions
  (logging, timers, temp-file helpers, validators, etc.) moved from
  exported to internal (`@keywords internal`); NAMESPACE reduced from 52
  to 26 exports. New
  [`rclade_options()`](https://zengzichao.github.io/Rclade/reference/rclade_options.md)
  constructor provides a validated parameter object for
  `plot_timetree(opts = ...)` (route B1: backward-compatible, explicit
  args take precedence).
- **Manuscript**: supplementary “Searched alternatives” table added
  (CN/EN); §2.6.1 formalizes NCBI/Silva 0.3 threshold alongside
  GTDB/embedded 0.6; §2.6.3 computational-complexity table added;
  abstract notes single-run measurements at n \>= 5000; §2.7
  cross-references the searched-alternatives table; Chinese §4.3 adds
  O(n·k) notation.
- **Docs**:
  [`run_rclade_cli()`](https://zengzichao.github.io/Rclade/reference/run_rclade_cli.md)
  Rd documents exit-code contract with examples;
  [`run_rclade_shiny()`](https://zengzichao.github.io/Rclade/reference/run_rclade_shiny.md)
  Rd adds a Concurrency section warning about global state;
  `test-performance.R` header clarifies catastrophic-regression intent.
- **Engineering**: `environment.yml` removes `r-devtools` from runtime
  deps; README (CN/EN) adds lockfile reproducibility guidance;
  `tests/functional/` test IDs and comments fully translated to English.

## Post-review hardening (2026-07-30, Rclade 1.0.1)

A structured editor-style review of the 1.0.0 manuscript and codebase
was fully addressed (see the Rclade v1.0.0 editor review report in the
project workspace). User-visible changes:

- **Rendering/time axis**: the x-axis range is now adaptive
  ([`compute_x_min()`](https://zengzichao.github.io/Rclade/reference/compute_x_min.md)
  floors at -4567 Ma only when the tree root actually reaches into the
  Hadean); the erroneous injection of “Hadean” into the *eras* table (a
  Hadean is an eon, not an era) was removed; displayed-leaves counting
  after collapse no longer includes backbone internal nodes.
- **CLI**: `-u/--unit` default changed from `Ga` to `auto` (aligned with
  the R API; `Ga` still converts x1000); work around an optparse \>= 1.8
  prefix-collision that leaked sibling defaults into `--highlight`,
  `--clade` and `--taxonomy_file`; `--strip_annotations` now drops
  treedata columns by annotation pattern
  (support/rate/height/HPD/NHX/taxid).
- **R API**: `ignore_malformed = TRUE` is now honoured in the multiPhylo
  batch path (failed trees become NULL placeholders, as documented);
  `delimiter_mode` defaults unified to `"reverse"` across all exported
  functions; format-detection clear-majority threshold (score \>= 0.6)
  made tolerant to binary floating-point error; Newick bracket-balance
  validation vectorized (large-tree speedup).
- **Docs/metadata**: DESCRIPTION lists the embedded format; third-party
  attribution in the logo/CLI help corrected (ggtree \>= 4.0, deeptime
  Gearty 2025); withr added to Suggests; non-ASCII characters removed
  from `shiny-app.R`; Shiny no longer loads remote fonts; the Dockerfile
  installs from source (no bundled tarball), uses R 4.5.3 and propagates
  the documented Unix exit codes via `q(status = ...)`.
- **Tests/CI**: new tests for displayed-leaves counting, adaptive x_min
  and the Shiny app; stale functional-test expectations aligned with
  intentional behaviour (duplicate-tip warning, non-interactive
  overwrite=“ask”, Silva detection fallback); CI Stage B now uses
  `stop_on_failure = TRUE` and a declared-minimum-dependencies job was
  added; codecov.yml uses the standard flags + status schema.

## Overview

First stable release. Consolidates the 0.2.0 development series into a
formal release and aligns the manuscript with the project code:

- Unified version to 1.0.0 to mark the first stable release.
- All examples and result figures now use
  `FigTree_withLACA_GBM_95CI.tree.recover` (the 700-tip archaeal
  timetree published by Moody et al. 2025, Phil. Trans. R. Soc. B
  380:20240097, <doi:10.1098/rstb.2024.0097>; redistributed with
  attribution).
- Manuscript supplementary material now fully includes the
  circular-layout straight-edge technical document.
- Cleaned junk files from the project code (`.DS_Store`,
  `tests/testthat/_problems/`, `tests/functional/output/`, empty
  directories).
- Fixed path references, version wording, and bibliography citations in
  the manuscript.

## Project Housekeeping

- Removed inconsistent `benchmark_results/benchmark_synthetic.csv`; kept
  the combined benchmark data actually cited in the manuscript.
- Added `v4_config.yaml` (based on `config.example.yaml`) so the config
  example referenced in the manuscript exists.
- Ensured test outputs and debug artifacts are excluded from the package
  via `.Rbuildignore` / `.gitignore`.

## Compatibility and Documentation Fixes

- Fixed the geological timescale not rendering under ggplot2 4.x:
  `coord_geo` / `coord_geo_radial` are now applied with `clip = "off"`
  and are no longer overwritten by `coord_cartesian` when a timescale is
  enabled.
- Regenerated roxygen documentation (`man/*.Rd`) to remove
  function-signature vs. help-page mismatches (codoc).
- Declared the optional dependency `filelock` (log-file locking) in
  `Suggests`.
- Corrected the ggtree version floor (\>= 4.0.0) in `selftest` and
  `environment.yml`, added `viridisLite` to the `Dockerfile`, and synced
  parameter tables and pkgdown references across README and docs.

------------------------------------------------------------------------

# Rclade 0.2.0.9000 (Development)

## Bug Fixes

- **Circular layout rendering direction corrected (2026-07-25)**: The
  `coord_polar` parameters in
  [`add_clip_off()`](https://zengzichao.github.io/Rclade/reference/add_clip_off.md)
  for the circular branch (`start=0, direction=1`) did not match
  ggtree’s native circular layout (`start=-π/2, direction=-1`), causing
  circular trees to be mirror-flipped relative to
  `ggtree(layout="circular")`. Now fixed to
  `coord_polar(theta="y", start=-pi/2, direction=-1, clip="off")`.

- **Geological timescale ylim buffer increased (2026-07-25)**:
  [`add_geo_timescale()`](https://zengzichao.github.io/Rclade/reference/add_geo_timescale.md)
  y_max buffer increased from 2% to 8% (that 8% buffer was later reduced
  back to 1%: rectangular layouts now use a 1% `y_max` buffer and
  circular label offset 1.5%, see `R/timescale.R`), and
  [`theme_timetree()`](https://zengzichao.github.io/Rclade/reference/theme_timetree.md)
  top margin increased from 5pt to 20pt, preventing collapsed-triangle
  vertices from being clipped.

- **GOE/NOE event bands not covering full tree (2026-07-25)**:
  [`add_geo_events()`](https://zengzichao.github.io/Rclade/reference/add_geo_events.md)
  band `ymax` changed from a value computed from `p$data$y` to `Inf`,
  ensuring bands extend to the full vertical extent of the coordinate
  system.

- **Collapsed triangle top clipped (2026-07-23)**:

  - Root cause:
    [`ggtree::collapse()`](https://dplyr.tidyverse.org/reference/compute.html)
    triangle vertices (at the MRCA node) exceeded the original tip-based
    y-axis panel range, and ggplot2’s default panel clipping truncated
    the top triangle apex.
  - Fix:
    [`theme_timetree()`](https://zengzichao.github.io/Rclade/reference/theme_timetree.md)
    now returns `list(theme, coord)` where
    `coord = coord_cartesian(clip = "off")`, applied together with the
    theme in
    [`pt_step7_finalize_plot()`](https://zengzichao.github.io/Rclade/reference/pt_step7_finalize_plot.md),
    allowing collapsed geometry to render beyond the panel boundary.
  - Breaking change:
    [`theme_timetree()`](https://zengzichao.github.io/Rclade/reference/theme_timetree.md)
    return value changed from a single ggplot2 theme object to
    `list(theme, coord)`; direct callers must now use
    `p + th$theme + th$coord`.
    [`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md)
    internals are updated; ordinary users are unaffected.
  - Updated `man/theme_timetree.Rd` and `tests/testthat/test-theme.R`
    accordingly.

- **Code review fixes (2026-06-19)**:

  - **High severity (P0)**:
    - Fixed `compute_mrca_map` tip index lookup from name-based to
      position-based matching, ensuring strict alignment with tree
    - Fixed dead code in `collapse_by_groups` NA color fallback, now
      checks NA before calling `adjustcolor`
    - Fixed `validate_inputs` `valid_ranks` missing
      `kingdom`/`subspecies`/`k`/`ss`, now derived from
      `normalize_rank`’s `rank_map`
  - **Medium severity (P1+P2)**:
    - Unified clade mode case comparison to case-insensitive, resolving
      semantic contradiction between step2 exact match and step3 fuzzy
      match
    - Added defensive check to `build_group_vec`, explicitly erroring
      when tip not found in tree
    - Added empty file/missing file boundary checks to `read_file_utf8`
    - Changed `validate_collapse_plan` phangorn missing from `warning`
      to `log_warning` for better observability
  - **Low severity (P2/P3)**:
    - Fixed `save_timetree` `overwrite="ask"` to implement true
      interactive prompting (uses `readline` in interactive mode)
    - Fixed `detect_encoding` UTF-8 detection to use
      `readLines(encoding="UTF-8")` for strict validation
    - Added warning for LUCA on multi-domain trees (\>2 domains)
      indicating potential overlap with ROOT
    - Added sanity check to `add_geo_timescale` warning when tree depth
      exceeds plausible geological range
    - Added capture group protection to `parse_custom_regex`, explicitly
      erroring when no capture group found
    - Documented thread safety concerns in logger documentation
    - Changed `convert_unit` and `prepare_geo_timescales` from
      [`message()`](https://rdrr.io/r/base/message.html) to `log_info`
      for unified logging

- **Logic-closure review fixes (Round 2: 26 defects)**:

  - **Fatal (F1-F3)**: Fixed CLI single-tree mode `tryCatch` syntax
    error; removed duplicate file read in
    [`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md);
    fixed `color_palette` scope error in `_pt_step7`.
  - **Severe (S1-S7)**: Fixed clade mode duplicate parsing and incorrect
    rank grouping; fixed `parse_semicolon_delimited` multi-character
    separator escaping; fixed “unknown” format fallback data.frame
    column count mismatch; added safe color lookup with grey fallback on
    NA; unified MRCA=root judgment logic; unified duplicate tip labels
    validation (upgraded to `stop`); fixed LUCA monophyly check always
    returning TRUE.
  - **Medium (M1-M6)**: Fixed `_problems` test case capitalization;
    fixed double `revts` in `add_geo_timescale`; removed dead code in
    `detect_encoding`; fixed `read_taxonomy_file` hardcoded column names
    (now uses `intersect` for dynamic matching); removed duplicate `nhx`
    in `SUPPORTED_TREE_EXTENSIONS`; improved `convert_unit` attribute
    preservation.
  - **Round 2 new findings (R1-R5)**: Removed `scale_x_continuous()`
    conflicting with `coord_geo` in `timescale.R`; added default
    `name`/`color` columns for user-provided `geo_events`; removed
    unused `actual_ntips` parameter from `add_geo_timescale`; added
    `overwrite` parameter to `batch_plot`; fixed batch mode return type
    annotation.
  - **Remaining issues (D1-D5)**: Fixed nested interrupt handler
    `temp_files` conflict (`batch_with_interrupt` now preserves outer
    temp files when nesting detected); `batch_plot` now uses
    `batch_with_interrupt` for graceful interrupt handling; moved
    `revts.done` attribute from `p$data` to `p` object; added 22 new CLI
    parameters (`--angle`, `--line_width`, `--tip_label_size`,
    `--legend_position`, `--highlight`, `--geo_events`,
    `--timescale_levels`, etc.); `phangorn` missing now emits `warning`
    instead of silent `message`.

- **Logic-closure review fixes (batch/interrupt/taxonomy_levels)**:

  - [`batch_with_interrupt()`](https://zengzichao.github.io/Rclade/reference/batch_with_interrupt.md)
    now uses `results[i] <- list(...)` to preserve `NULL` placeholders,
    and the CLI batch path wraps each tree’s
    [`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md) +
    [`save_timetree()`](https://zengzichao.github.io/Rclade/reference/save_timetree.md)
    in `tryCatch`, so `--ignore_malformed` now works in batch mode.
  - Graceful interrupt handling removed `invokeRestart("abort")` in
    favor of `tryCatch(..., interrupt = ...)` returning partial results;
    added `on.exit(.interrupt_env$active <- FALSE)` so the state machine
    is reset on any exit path.
  - `taxonomy_levels` is now propagated through highlighting, monophyly
    checks, special identifier resolution, and
    [`resolve_group()`](https://zengzichao.github.io/Rclade/reference/resolve_group.md);
    [`parse_taxonomy_with_file()`](https://zengzichao.github.io/Rclade/reference/parse_taxonomy_with_file.md)
    and
    [`summarize_taxonomy_quality_with_file()`](https://zengzichao.github.io/Rclade/reference/summarize_taxonomy_quality_with_file.md)
    use
    [`get_taxonomy_levels()`](https://zengzichao.github.io/Rclade/reference/get_taxonomy_levels.md)
    to determine the rank list dynamically.
  - [`resolve_group()`](https://zengzichao.github.io/Rclade/reference/resolve_group.md)
    gained `delimiter_mode`, `custom_patterns`, and `taxonomy_levels`
    arguments, matching the behavior of
    [`check_monophyly()`](https://zengzichao.github.io/Rclade/reference/check_monophyly.md)
    /
    [`highlight_clades()`](https://zengzichao.github.io/Rclade/reference/highlight_clades.md).
  - `clade_label_offset` default unified to `50` (Ma), consistent
    between
    [`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md)
    (`R/plot-timetree.R`) and the CLI `--clade_label_offset`
    (`R/cli.R`);
    [`annotate_clade()`](https://zengzichao.github.io/Rclade/reference/annotate_clade.md)’s
    own `offset` parameter defaults to `0` and receives `50` from the
    caller.
  - CLI parameter parse failures now return exit code `2L` instead of
    `0L`.
  - `--ignore_malformed` now also covers save-stage errors such as
    existing output files.
  - [`validate_custom_groups()`](https://zengzichao.github.io/Rclade/reference/validate_custom_groups.md)
    now rejects empty custom groups with a clear error.
  - [`validate_tree_sequence_match()`](https://zengzichao.github.io/Rclade/reference/validate_tree_sequence_match.md)
    gained a `multi_tree_mode` argument, which the CLI passes through,
    so multi-tree files no longer error out immediately.
  - Fixed tree-sequence cross-validation failure not terminating the
    flow because `return(invisible(3L))` was inside a `tryCatch` error
    handler; cross-check failures now correctly return exit code 3.
  - Fixed
    [`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md)
    not passing `taxonomy_levels` to
    [`parse_taxonomy_with_file()`](https://zengzichao.github.io/Rclade/reference/parse_taxonomy_with_file.md),
    which broke custom levels combined with external taxonomy files.
  - Fixed
    [`validate_taxonomy_no_cycles()`](https://zengzichao.github.io/Rclade/reference/validate_taxonomy_no_cycles.md)
    false positives on adjacent-rank placeholder names
    (e.g. `phylum=SpSt-1190, class=SpSt-1190`) in real taxonomy data; it
    now stops only when a true cross-rank cycle is detected.

- **KN-004 ~ KN-010**: Fixed propagation/implementation of
  `--skip_length_check`, `--mol_type`, `--taxonomy_source_priority`,
  `--taxonomy_table_sep`, `--multi_tree_mode ask`,
  `--taxonomy_delimiter_mode greedy/segment`, `--low_memory`, and
  `--ignore_malformed`

- **KN-001 (partial)**: Added `inst/bin/rclade` shell wrapper script to
  correctly propagate SIGINT as exit code 130 in terminal sessions;
  [`run_rclade_cli()`](https://zengzichao.github.io/Rclade/reference/run_rclade_cli.md)
  now uses `tryCatch` to catch interrupts and should also return 130

## Development-spec alignment fixes (2026-07-02)

Aligned with the “Development Requirements - General” spec document;
backfilled the following missing capabilities:

- **§7 Multi-tree split mode**: `--multi_tree_mode split` behaves like
  `all` (returns multiPhylo) but semantically signals per-tree output
  splitting for downstream pipelines (Snakemake/Nextflow).
- **§8.1 Configuration file support**: Added `--config` option for YAML
  config files supplying defaults. Precedence: explicit CLI flags \>
  config file \> built-in defaults. A `config.example.yaml` template is
  shipped with the package, covering most configurable options. `yaml`
  added to DESCRIPTION Suggests.
- **§8.2 Library-mode API**: Exported
  [`parse_taxonomy()`](https://zengzichao.github.io/Rclade/reference/parse_taxonomy.md)
  and
  [`read_tree_auto()`](https://zengzichao.github.io/Rclade/reference/read_tree_auto.md)
  as stable library-mode APIs for external workflows
  (Snakemake/Nextflow) to call directly without going through
  [`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md).
- **§9.1.1 Annotation stripping**: Added `--strip_annotations` option
  and
  [`strip_tree_annotations()`](https://zengzichao.github.io/Rclade/reference/strip_tree_annotations.md)
  helper to drop bootstrap/NHX node annotations before rendering,
  reducing output size. Both batch and single-tree paths are wired up.
- **§10.1 Temp-file permissions**:
  [`managed_tempfile()`](https://zengzichao.github.io/Rclade/reference/managed_tempfile.md)
  now `Sys.chmod(mode = "0600")` immediately after creation;
  [`managed_tempdir()`](https://zengzichao.github.io/Rclade/reference/managed_tempdir.md)
  now `Sys.chmod(mode = "0700")`, meeting HPC shared-environment
  security requirements.
- **§12.1 CI coverage threshold**: Added `codecov.yml` with 85% target
  for both overall and patch coverage; core modules
  (parse-taxonomy/taxonomy-file/validate-deep/monophyly/compute-mrca/read-input)
  flagged separately. CI workflow keeps `fail_ci_if_error` at `false`
  (no CODECOV_TOKEN configured), so coverage upload failures do not fail
  the workflow and coverage is a monitoring metric, not an enforced
  quality gate (corrected in v1.1.0, reviewer issue 7).
- **§15 Error message \[MODULE/FUNCTION\] format**: logger’s
  [`log_message()`](https://zengzichao.github.io/Rclade/reference/log_message.md)
  and all public log functions
  (`log_info`/`log_warning`/`log_error`/`log_debug`/`log_critical`)
  gained an optional `.module` argument that inserts a
  `[MODULE/FUNCTION]` tag. Key
  [`stop()`](https://rdrr.io/r/base/stop.html) and
  `log_warning`/`log_error` calls now carry source tags (e.g.,
  `[validate-deep/check_name_safety]`,
  `[compute-mrca/compute_mrca_map]`).
- **Documentation sync**: README.CN.md / README.EN.md / man/\*.Rd all
  updated to document the new features.

# Rclade 0.2.0 (2026-06-12)

## New Features

### Multi-tree Handling

- **Intelligent multi-tree detection**: Automatically detects files
  containing multiple trees
- **User-controlled behavior**: When multiple trees are detected, stops
  with informative error asking user to specify handling mode
- **Flexible options**: `--tree_index N` for specific tree,
  `--multi_tree_mode` for batch processing (first/last/random/all)
- **Batch output**: When using `--multi_tree_mode all`, output files are
  automatically suffixed with tree index

### Enhanced Input Validation

- **Deep Newick syntax validation**: Bracket balance, negative branch
  length detection (CRITICAL), empty node names, duplicate node names,
  semicolon terminator check
- **Deep tree structure validation**: Self-loop detection, multi-root
  detection, negative branch lengths (CRITICAL, terminates), empty tip
  labels, duplicate tip labels, edge matrix consistency
- **Multi-tree summary**: When multiple trees detected, prints summary
  (tips/nodes per tree) before raising error
- **Sequence file validation**: FASTA/FASTQ format detection, duplicate
  ID check (ERROR, terminates), alphabet auto-detection
  (DNA/RNA/protein), invalid character localization (line numbers),
  alignment length consistency check
- **Format auto-detection**: Detects tree format (Newick/Nexus/BEAST)
  and sequence format (FASTA/FASTQ) by extension and content

### Dual-format Taxonomy Parsing

- **Format A (embedded)**: `_d_Bacteria_p_Cyanobacteriota_...` with
  `_X_` delimiters
- **Format B (semicolon-delimited)**:
  `d__Bacteria;p__Cyanobacteriota;...` with `X__` prefixes
- **Unified data structure**: Both formats map to standard
  `{domain, phylum, class, order, family, genus, species}`
- **Missing value handling**: `s__` (empty species) parsed as NA with
  DEBUG logging; missing levels handled gracefully
- **Configurable taxonomy levels**: Supports extended ranks (kingdom
  `_k_`, subspecies `_ss_`) via `--taxonomy_levels`

### Cross-platform and Encoding Robustness

- **Explicit UTF-8**: All file read/write uses `encoding="UTF-8"`, with
  fallback and WARNING on encoding issues
- **BOM handling**: Detects and removes UTF-8 BOM markers
- **Safe path construction**:
  [`build_path()`](https://zengzichao.github.io/Rclade/reference/build_path.md)
  uses [`file.path()`](https://rdrr.io/r/base/file.path.html), no string
  concatenation for paths
- **Newline normalization**: All line endings normalized to Unix style
  (`\n`)
- **Managed temp files**:
  [`managed_tempfile()`](https://zengzichao.github.io/Rclade/reference/managed_tempfile.md)
  and
  [`managed_tempdir()`](https://zengzichao.github.io/Rclade/reference/managed_tempdir.md)
  with automatic cleanup

### Graceful Interrupt Handling

- **SIGINT (Ctrl+C) support**: Catches interrupt signals, reports
  progress, cleans up resources
- **Progress reporting**: On interrupt, shows completed/total items and
  elapsed time
- **Resource cleanup**: Closes open connections, removes incomplete temp
  files
- **Batch mode**:
  [`batch_with_interrupt()`](https://zengzichao.github.io/Rclade/reference/batch_with_interrupt.md)
  provides graceful termination for multi-tree processing
- **Exit code**: Returns exit code 130 on user interrupt (standard Unix
  convention)

### Adversarial Input Protection

- **Malicious symbol injection**: Detects control characters
  (`\x00-\x1f`) and Unicode BiDi markers (`\u202E` etc.) in node names,
  rejects with ERROR
- **Zero-width character detection**: Warns about zero-width spaces
  (`\u200B`) and similar invisible characters
- **Circular dependency detection**: Identifies cycles in taxonomy
  tables (e.g., d\_\_A;p\_\_B with d\_\_B;p\_\_A)
- **Empty file rejection**: CRITICAL error and termination for 0-byte
  tree/sequence files

### Real-time Logging System

- **Timestamped output**: Every log message includes timestamp and
  elapsed time
- **Step tracking**: Shows progress as \[step/total\] for multi-step
  operations
- **Multiple log levels**: DEBUG, INFO, WARNING, ERROR, CRITICAL
- **Plain text output**: No ANSI colors or special Unicode characters
- **Performance timers**: Built-in timer functions for benchmarking

### Enhanced CLI Interface

- **Standard argument parsing**: Uses optparse library for robust
  argument handling
- **Complete help system**: -h/–help outputs all parameters, defaults,
  and usage examples
- **Version option**: -v/–version shows package version, git hash, and
  dependency versions
- **Parameter validation**: Input file existence check, enum value
  validation, numeric range checks
- **Detailed error messages**: Clear error messages for invalid
  parameters

### External Taxonomy File Support

- **File-based taxonomy**: Read taxonomy from external TSV/CSV files
- **Priority control**: Choose whether file taxonomy overrides or
  supplements label parsing
- **Quality reporting**: Extended
  [`summarize_taxonomy_quality_with_file()`](https://zengzichao.github.io/Rclade/reference/summarize_taxonomy_quality_with_file.md)
  function

### Special Ancestral Node Identifiers

- **LUCA**: Last Universal Common Ancestor (MRCA of Bacteria and
  Archaea)
- **LACA**: Last Archaeal Common Ancestor
- **LBCA**: Last Bacterial Common Ancestor
- **Monophyly checking**: Verify if these groups are monophyletic

### Monophyly Validation

- **Automatic monophyly check**: When collapsing by taxonomic rank, each
  group is checked for monophyly before collapse
- **Non-monophyletic groups skipped**: Groups that are not monophyletic
  are skipped with informative warnings
- **Outsider identification**: Warning messages include the number and
  names of outsider tips in the MRCA clade

## Improvements

- **ASCII art logo**: Stylized logo displayed at startup (no
  Unicode/emoji)
- **Better error messages**: More informative error messages for
  multi-tree files
- **CLI enhancements**: New command-line options for multi-tree handling
  and log level control
- **Example tree improvements**: Example tree now has proper
  monophyletic groups at all taxonomic levels

## Bug Fixes

- Fixed multi-tree handling to properly interrupt and request user
  specification
- Fixed the CLI `--help`/`--version` handlers calling
  [`stop()`](https://rdrr.io/r/base/stop.html) and terminating the R
  process; they now return an exit code normally
- Suppressed the `Invalid edge matrix` warnings emitted by
  [`tidytree::as_tibble()`](https://tibble.tidyverse.org/reference/as_tibble.html)

## Newly Exported Functions

- [`detect_taxonomy_format()`](https://zengzichao.github.io/Rclade/reference/detect_taxonomy_format.md):
  detects taxonomy label formats (GTDB/Silva/NCBI/embedded); now
  exported so it can be called directly

## Dependencies

**Required**: ape (\>= 5.0), ggtree (\>= 4.0.0), deeptime (\>= 1.0),
ggplot2 (\>= 3.5), stringr (\>= 1.5), tidytree (\>= 0.4)

**Optional**: treeio (BEAST2/IQ-TREE support), phangorn (nesting
detection), viridisLite/RColorBrewer (color palettes), cowplot/patchwork
(legend splitting), shiny (web UI), optparse (CLI)

------------------------------------------------------------------------

# Rclade 0.1.0 (2026-05-07)

## Initial Release

### Core Features

- **Automatic taxonomy label parsing**: Supports GTDB, Silva, NCBI,
  custom_rank, and custom_regex formats
- **Batch clade collapsing**: Nesting-aware depth-first ordering with
  automatic conflict detection
- **Geological timescale integration**: Via deeptime package with
  adaptive time breaks (Ma/Ka)
- **Smart legend layout**: Auto-adjusting rows/columns for any number of
  groups
- **Color-blind-safe palettes**: Default viridis palette with fallback
  chain (viridis -\> hcl.colors -\> rainbow)

### Visualization Features

- **Node support value display**: Compatible with BEAST2/IQ-TREE
  posterior/bootstrap values
- **HPD interval visualization**: Highest Posterior Density range
  display
- **Clade annotation labels**: Configurable offset and font size
- **Publication-ready theme**: Custom
  [`theme_timetree()`](https://zengzichao.github.io/Rclade/reference/theme_timetree.md)
  for high-quality output
- **Multiple layouts**: Rectangular and circular tree layouts

### Input/Output

- **Multiple input formats**: Newick (.nwk/.tre), Nexus (.nexus/.nex),
  treedata objects
- **Multiple output formats**: PDF, PNG, TIFF, SVG, EPS
- **Batch processing**: Process entire directories with progress
  tracking

### User Interfaces

- **CLI interface**: Full-featured command-line interface via optparse
- **Shiny web interface**: Interactive web-based visualization

### Quality & Reproducibility

- **Input validation**: Comprehensive parameter checking and unit sanity
  tests
- **Session info export**:
  [`save_session_info()`](https://zengzichao.github.io/Rclade/reference/save_session_info.md)
  for reproducibility
- **Taxonomy quality report**:
  [`summarize_taxonomy_quality()`](https://zengzichao.github.io/Rclade/reference/summarize_taxonomy_quality.md)
  for label parsing diagnostics

## Known Limitations

- NCBI taxonomy parsing uses position-based rank mapping, which may
  produce offsets in non-standard lineages

## Dependencies

**Required**: ape (\>= 5.0), ggtree (\>= 4.0.0), deeptime (\>= 1.0),
ggplot2 (\>= 3.5), stringr (\>= 1.5), tidytree (\>= 0.4)

**Optional**: treeio (BEAST2/IQ-TREE support), phangorn (nesting
detection), viridisLite/RColorBrewer (color palettes), cowplot/patchwork
(legend splitting)
