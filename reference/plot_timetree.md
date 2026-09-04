# Plot a phylogenetic tree with geological timescale and taxonomic collapsing

The main entry point of Rclade. Takes a phylogenetic tree object or file
path and produces a publication-ready visualization with automatic
taxonomic collapsing, geological timescale integration, and smart legend
layout.

## Usage

``` r
plot_timetree(
  tree,
  tree_index = NULL,
  multi_tree_mode = "error",
  rank = "none",
  triangle_mode = "mixed",
  space_mode = "proportional",
  layout = "rectangular",
  angle = 360,
  color_palette = "viridis",
  color_mapping = NULL,
  line_width = 1,
  show_tip_labels = FALSE,
  tip_label_size = 2,
  add_timescale = TRUE,
  timescale_levels = c("eras", "eons"),
  unit = NULL,
  taxonomy_format = "auto",
  custom_patterns = NULL,
  taxonomy_file = NULL,
  taxonomy_file_sep = "auto",
  taxonomy_file_header = FALSE,
  taxonomy_file_priority = TRUE,
  taxonomy_source_priority = NULL,
  taxonomy_table_sep = ";",
  taxonomy_delimiter_mode = "reverse",
  legend_position = "bottom",
  legend_nrow = NULL,
  legend_ncol = NULL,
  legend_title = NULL,
  clade = NULL,
  strict = FALSE,
  groups = NULL,
  show_clade_label = FALSE,
  show_clade_count = TRUE,
  clade_label_offset = 50,
  clade_label_fontsize = 3,
  show_support = FALSE,
  support_threshold = 0.95,
  show_hpd = FALSE,
  hpd_color = "firebrick",
  geo_events = FALSE,
  timescale_version = "ICS 2023/02",
  main_title = NULL,
  sub_title = NULL,
  highlight = NULL,
  highlight_alpha = 0.2,
  theme_fun = theme_timetree,
  output = NULL,
  overwrite = "ask",
  width = 14,
  height = 10,
  taxonomy_levels = NULL,
  low_memory = FALSE,
  ignore_malformed = FALSE,
  ignore_branch_length = FALSE,
  color_rank = NULL,
  timescale_mode = "radial",
  timescale_position = "right",
  tree_start_position = "right",
  opts = NULL
)
```

## Arguments

- tree:

  A `phylo` or `treedata` object, or a file path string pointing to a
  Newick (.nwk, .tre, .treefile) or Nexus (.nexus, .nex) file.

- tree_index:

  Integer. Index of tree to use from multiPhylo objects (e.g., BEAST
  posterior). Only used when `tree` is a file path. Default: NULL (uses
  multi_tree_mode).

- multi_tree_mode:

  Character. How to handle multiple trees in a file. Options: `"error"`
  (default), `"ask"` (interactive prompt; falls back to `"error"` in
  non-interactive sessions), `"first"`, `"last"`, `"random"`, `"all"`
  (returns a list of plots in batch mode), `"split"` (same code path as
  `"all"` but signals per-tree numbered output for pipeline
  dispatching). When `"error"`, stops with informative message asking
  user to specify.

- rank:

  Taxonomic rank to collapse at. One of: `"none"`, `"kingdom"`,
  `"domain"`, `"phylum"`, `"class"`, `"order"`, `"family"`, `"genus"`,
  `"species"`, `"subspecies"`, or abbreviations `"k"`, `"d"`, `"p"`,
  `"c"`, `"o"`, `"f"`, `"g"`, `"s"`, `"ss"`. Default: `"none"`. Mutually
  exclusive with `groups`.

- triangle_mode:

  Collapse triangle visualization mode. `"max"` shows the full clade
  range, `"min"` shows the minimal range, `"mixed"` uses adaptive
  selection, `"none"` disables triangles. Default: `"mixed"`.

- space_mode:

  Space allocation strategy for collapsed clades. `"equal"` assigns
  equal vertical space to each clade, `"proportional"` allocates space
  proportional to tip count. Default: `"proportional"`.

- layout:

  Tree layout. `"rectangular"` for standard rectangular layout,
  `"circular"` for fan/circular layout. Default: `"rectangular"`.

- angle:

  Fan angle in degrees for circular layout (0-360). Only used when
  `layout = "circular"`. Default: `360`.

- color_palette:

  Color palette specification. Can be:

  - A palette name: `"viridis"` (default), `"rainbow"`, or any
    RColorBrewer palette name (e.g., `"Set1"`, `"Paired"`)

  - A character vector of hex color codes (recycled if shorter than
    needed)

- color_mapping:

  Named character vector of specific color assignments. Takes highest
  priority over `color_palette`. Names should match group names.
  Example: `c("Proteobacteria" = "#E41A1C", "Firmicutes" = "#377EB8")`.

- line_width:

  Branch line width (passed to ggtree). Default: `1`.

- show_tip_labels:

  Logical. Whether to display tip labels. Default: `FALSE` (recommended
  for trees with \>100 tips).

- tip_label_size:

  Numeric. Tip label font size. Default: `2`.

- add_timescale:

  Logical. Whether to add a geological timescale to the x-axis. Requires
  rectangular layout and valid edge lengths. Default: `TRUE`.

- timescale_levels:

  Character vector of timescale levels to display. Options: `"eras"`,
  `"eons"`, `"periods"`. Default: `c("eras", "eons")`.

- unit:

  Time unit of input tree edge lengths: `"Ga"` (giga-annum) or `"Ma"`
  (mega-annum). **Required whenever `add_timescale = TRUE`**: the
  pipeline aborts if `unit` is `NULL`, because Rclade does not infer
  branch-length units and does not verify that the input tree is a
  time-calibrated chronogram. If `"Ga"`, edge lengths are converted to
  Ma (multiplied by 1000). `NULL` (default) leaves the tree's native
  units untouched and is only valid with `add_timescale = FALSE`. Rclade
  displays the user-supplied time calibration only; it never estimates
  divergence times. Default: `NULL`.

- taxonomy_format:

  Taxonomy label format. `"auto"` enables automatic detection via
  prefix-matching heuristic. Manual options: `"GTDB"`, `"Silva"`,
  `"NCBI"`, `"custom_rank"`, `"custom_regex"`. Default: `"auto"`.

- custom_patterns:

  Named list of regex patterns for custom format parsing. Required when
  `taxonomy_format = "custom_regex"`. Example:
  `list(domain = "Domain:([^|]+)", phylum = "Phylum:([^|]+)")`.

- taxonomy_file:

  Character. Path to an external taxonomy file. The file should have two
  columns: (1) tip labels and (2) taxonomy strings in GTDB format (e.g.,
  `d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria`). Supports
  tab-delimited or comma-delimited files. When provided, this file
  supplements or overrides label-based taxonomy parsing. Default:
  `NULL`.

- taxonomy_file_sep:

  Character. Column separator for taxonomy file. `"auto"` auto-detects
  tab or comma. Default: `"auto"`.

- taxonomy_file_header:

  Logical. Whether taxonomy file has a header row. Default: `FALSE`.

- taxonomy_file_priority:

  Logical. If `TRUE` (default), file taxonomy takes priority over
  label-based parsing. If `FALSE`, file is used only for labels that
  cannot be parsed from the tree. Default: `TRUE`. Superseded by
  `taxonomy_source_priority` if provided.

- taxonomy_source_priority:

  Character. Which taxonomy source takes priority when both embedded
  (label-based) and table (file-based) taxonomy are available:
  `"embedded"` or `"table"`. Default: `NULL` (use
  `taxonomy_file_priority`).

- taxonomy_table_sep:

  Character. Separator between taxonomy ranks in the second column of an
  external taxonomy file. Default: `";"`.

- taxonomy_delimiter_mode:

  Character. Embedded (Format A) parsing strategy: `"reverse"`
  (right-to-left, default), `"greedy"` (left-to-right), or `"segment"`
  (delimiter-to-delimiter extraction).

- legend_position:

  Legend placement. Can be a cardinal direction (`"bottom"`, `"top"`,
  `"right"`, `"left"`, `"none"`) or a length-2 numeric vector `c(x, y)`
  for inside placement (ggplot2 \>= 3.5). Default: `"bottom"`
  (horizontal layout).

- legend_nrow:

  Integer. Number of rows in legend grid. Auto-computed if NULL.

- legend_ncol:

  Integer. Number of columns in legend grid. Auto-computed if NULL.

- legend_title:

  Character. Custom legend title. If `NULL`, the rank name (e.g.,
  "Phylum", "Class") is used automatically. Default: `NULL`.

- clade:

  Character. Specific clade name to collapse (e.g., "Cyanobacteriota").
  When provided, only this clade is checked for monophyly and collapsed
  if valid. Mutually exclusive with `rank` and `groups`. Default:
  `NULL`.

- strict:

  Logical. If `TRUE`, non-monophyletic clades cause termination with
  error. If `FALSE` (default), non-monophyletic clades trigger a warning
  and are skipped. The permissive default (`FALSE`) is intentional: in
  interactive exploration of large trees with potentially inaccurate
  taxonomy, halting on the first non-monophyletic group would prevent
  the user from seeing any result. Use `TRUE` in production pipelines
  where taxonomic integrity is critical. Default: `FALSE`.

- groups:

  Named list of custom tip groups for collapsing. Each element is a
  character vector of tip labels belonging to that group. Groups must be
  monophyletic; non-monophyletic groups will raise an error. When
  `groups` is provided, `rank` is ignored (set it to `"none"`). Example:
  `list("Group_A" = c("tip1", "tip2"), "Group_B" = c("tip3"))`.

- show_clade_label:

  Logical. Whether to add clade labels next to collapsed triangles
  showing group name and species count. Default: `FALSE`.

- show_clade_count:

  Logical. Whether to show species count in clade labels (e.g.,
  "Proteobacteria (n=42)"). Only used when `show_clade_label = TRUE`.
  Default: `TRUE`.

- clade_label_offset:

  Numeric. Horizontal offset for clade labels from the right edge of the
  collapsed triangle in Ma units (0-5000). Default: `50`.

- clade_label_fontsize:

  Numeric. Font size for clade labels (1-20). Default: `3`.

- show_support:

  Logical. Whether to display node support values. Requires treedata
  input with posterior/bootstrap annotations. Default: `FALSE`.

- support_threshold:

  Numeric. Minimum support value to display (0-1). Default: `0.95`.

- show_hpd:

  Logical. Whether to display HPD (Highest Posterior Density) intervals.
  Requires node data with HPD annotations. Default: `FALSE`.

- hpd_color:

  Color for HPD bars. Default: `"firebrick"`.

- geo_events:

  Data frame of geological events to annotate, with columns `name`,
  `age_min`, `age_max` (Ma), `color`. If `TRUE`, default events
  (GOE=2400–2000 Ma, NOE=800–550 Ma) are shown. Default: `FALSE`.

- timescale_version:

  Geological timescale version string. Currently only `"ICS 2023/02"` is
  supported. Default: `"ICS 2023/02"`.

- main_title:

  Character. Main title for the plot. Default: `NULL` (no title).

- sub_title:

  Character. Subtitle for the plot. Default: `NULL` (no subtitle).

- highlight:

  Character vector of group names to highlight with colored backgrounds.
  Only monophyletic groups are highlighted; non-monophyletic groups
  trigger a warning. Supports special identifiers: `"LUCA"` (Last
  Universal Common Ancestor), `"LACA"` (Last Archaeal Common Ancestor),
  `"LBCA"` (Last Bacterial Common Ancestor). Default: `NULL` (no
  highlighting).

- highlight_alpha:

  Numeric. Transparency of highlight color (0-1). Default: `0.2`.

- theme_fun:

  Theme function or NULL. Default: `theme_timetree`. Set to NULL to use
  default ggplot2 theme.

- output:

  Optional output file path. If provided, the plot is saved immediately
  (backward compatibility). Default: `NULL`.

- overwrite:

  Character. Overwrite mode when `output` file exists: `"ask"` (default;
  prompts interactively, and in non-interactive sessions downgrades to
  skip-saving with a warning), `"force"` (overwrite), or `"no-clobber"`
  (skip saving). Passed to
  [`save_timetree()`](https://zengzichao.github.io/Rclade/reference/save_timetree.md).

- width:

  Output width in inches. Default: `14`.

- height:

  Output height in inches. Default: `10`.

- taxonomy_levels:

  Optional list for custom taxonomy rank codes and names, e.g.
  `list(codes = c("k", "ss"), names = c("kingdom", "subspecies"))`.
  `codes` are the abbreviation letters used in labels (e.g., `"k"`,
  `"ss"`); `names` are human-readable rank names used as column names in
  the result data frame. Used to extend or override default rank
  handling. Default: `NULL`.

- low_memory:

  Logical. If `TRUE`, enable best-effort low-memory mode by triggering
  garbage collection between major pipeline steps. Default: `FALSE`.

- ignore_malformed:

  Logical. If `TRUE`, malformed inputs are skipped with a warning
  instead of terminating. In batch mode, failed trees are returned as
  `NULL`. Default: `FALSE`.

- ignore_branch_length:

  Logical. If `TRUE`, the tree is drawn as a cladogram with all tips
  aligned at the same x position, ignoring the original branch lengths
  (equivalent to ggtree's `branch.length = "none"`). This automatically
  disables the geological timescale. Default: `FALSE`.

- color_rank:

  Character. Taxonomic rank for coloring, independent of `rank` (which
  controls collapsing). When set (e.g., `"phylum"`), branches and tips
  are colored by this rank, while collapsing uses `rank`. `NULL`
  (default) uses `rank` for both coloring and collapsing.

- timescale_mode:

  Character. Timescale display mode for circular layout: `"radial"`
  (default) draws full-circle geological background bands; `"linear"`
  draws a rectangular geological timescale axis (via
  [`deeptime::guide_geo()`](https://williamgearty.com/deeptime/reference/guide_geo.html))
  at the position specified by `timescale_position`, without background
  bands. Ignored for rectangular layout.

- timescale_position:

  Character. Clock position of the timescale axis when
  `timescale_mode = "linear"`. One of `"right"` (3 o'clock, default),
  `"top"` (12 o'clock), `"bottom"` (6 o'clock), `"left"` (9 o'clock).
  Should match `tree_start_position`. Ignored when
  `timescale_mode = "radial"` or for rectangular layout.

- tree_start_position:

  Character. Clock position where the tree starts expanding (the gap
  between the last and first tip). One of `"right"` (3 o'clock,
  default), `"top"` (12 o'clock), `"bottom"` (6 o'clock), `"left"` (9
  o'clock). Should match `timescale_position` when
  `timescale_mode = "linear"`; a warning is issued if they differ.
  Ignored for rectangular layout.

- opts:

  A `rclade_options` object (see
  [`rclade_options`](https://zengzichao.github.io/Rclade/reference/rclade_options.md))
  or a plain named list of parameter defaults. When supplied, values in
  `opts` serve as defaults for parameters the caller did not explicitly
  set; explicit arguments always take precedence. This is the
  recommended way to reuse a consistent parameter set across multiple
  calls.

## Value

A `ggplot` object with an `rclade_info` attribute containing metadata
(tip count, group count, taxonomy format, etc.). Can be further
customized with `+` layers.

## Details

This function orchestrates the complete Rclade pipeline:

1.  Input validation and reading (format detection, unit conversion)

2.  Taxonomy parsing (GTDB/Silva/NCBI/custom, clade/groups/rank modes)

3.  MRCA computation and monophyly check (with nesting conflict
    detection)

4.  Color generation (color-blind-safe palette)

5.  Tree rendering and batch clade collapsing (ggtree + depth-first
    collapse)

6.  Timescale integration and annotations (deeptime, support, HPD,
    labels, highlight)

7.  Plot finalization (legend, theme, title, save, metadata)

## Label length guard

When `tree` is a file path, Newick labels longer than 500 characters are
truncated to 400 characters plus a `_RCLADE_TRUNC` suffix (with a
warning) before parsing, because ape's Newick parser aborts the whole R
process on labels longer than ~512 characters on Linux. Truncated labels
may no longer match external taxonomy files or sequence IDs; shorten
labels upstream if exact matching is required. See
[`read_tree_auto()`](https://zengzichao.github.io/Rclade/reference/read_tree_auto.md).

## Parameter grouping

For complex configurations, consider organizing parameters by category:

- **Tree input:** `tree`

- **Collapsing:** `rank`, `triangle_mode`, `space_mode`

- **Layout:** `layout`, `angle`, `line_width`

- **Colors:** `color_palette`, `color_mapping`

- **Labels:** `show_tip_labels`, `tip_label_size`, `show_clade_label`,
  `clade_label_offset`

- **Timescale:** `add_timescale`, `timescale_levels`, `unit`

- **Taxonomy:** `taxonomy_format`, `custom_patterns`

- **Annotations:** `show_support`, `support_threshold`, `show_hpd`

- **Legend:** `legend_position`, `legend_nrow`, `legend_ncol`

- **Output:** `output`, `width`, `height`

## References

Yu G, Smith DK, Zhu H, Guan Y, Lam TT-Y (2017). "ggtree: an R package
for visualization and annotation of phylogenetic trees with their
covariates and other associated data." *Methods in Ecology and
Evolution*, 8(1), 28-36. doi:10.1111/2041-210X.12628

Gearty W (2025). "deeptime: an R package that facilitates highly
customizable and reproducible visualizations of data over geological
time intervals." *Big Earth Data*. doi:10.1080/20964471.2025.2537516

Paradis E, Schliep K (2019). "ape 5.0: an environment for modern
phylogenetics and evolutionary analyses in R." *Bioinformatics*, 35(3),
526-528. doi:10.1093/bioinformatics/bty633

## Examples

``` r
# Quick start with the bundled example tree (no timescale)
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB", add_timescale = FALSE)
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization         
#> ============================================================
#> 2026-09-04T14:48:28.851+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:48:28.852+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:48:28.852+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:48:28.853+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:48:28.853+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:48:28.854+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:48:28.855+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:48:28.855+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:48:28.856+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:48:28.856+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:48:28.857+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-04T14:48:28.857+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:48:28.858+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:48:28.864+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:48:28.864+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:48:28.864+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-09-04T14:48:28.865+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:48:28.865+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:48:28.867+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:48:28.868+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:48:28.868+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-04T14:48:29.599+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:48:29.605+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:48:29.606+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:48:29.771+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:48:29.793+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:48:29.794+00:00 | INFO     | Timer 'tree_rendering': 187 ms
#> 2026-09-04T14:48:29.794+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete                    
#> ============================================================
#> 2026-09-04T14:48:29.858+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:48:29.859+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:48:29.859+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:48:29.859+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:48:29.860+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:48:29.860+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:48:29.860+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:48:29.860+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:48:29.861+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:48:29.861+00:00 | INFO     | plot_timetree completed successfully
```
