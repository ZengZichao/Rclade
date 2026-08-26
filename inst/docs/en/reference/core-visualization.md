# Core Visualization

Main functions for plotting, saving and summarizing phylogenetic timetrees.

This module contains the following functions:

- [`plot_timetree`](#plot_timetree) — Plot a phylogenetic tree with geological timescale and taxonomic collapsing
- [`batch_plot`](#batch_plot) — Batch plot timetrees from a directory of tree files
- [`save_timetree`](#save_timetree) — Save a timetree plot to file
- [`summarize_timetree`](#summarize_timetree) — Print a summary of a Rclade timetree plot
- [`theme_timetree`](#theme_timetree) — Publication-ready theme for timetree plots

## `plot_timetree`

The main entry point of Rclade. Takes a phylogenetic tree object or file path
and produces a publication-ready visualization with automatic taxonomic collapsing,
geological timescale integration, and smart legend layout.

**Usage:**

```r
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
  tree_start_position = "right"
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `tree` | A `phylo` or `treedata` object, or a file path string pointing to a Newick (.nwk, .tre, .treefile) or Nexus (.nexus, .nex) file. |
| `tree_index` | Integer. Index of tree to use from multiPhylo objects (e.g., BEAST posterior). Only used when `tree` is a file path. Default: NULL (uses multi_tree_mode). |
| `multi_tree_mode` | Character. How to handle multiple trees in a file. Options: `"error"` (default), `"ask"`, `"first"`, `"last"`, `"random"`, `"all"`, `"split"`. When `"error"`, stops with an informative message asking the user to specify. `"ask"` prompts interactively (falls back to `"error"` when non-interactive). `"all"` returns a list of plots (batch mode); `"split"` also returns all trees, and the CLI writes per-tree outputs with numeric suffixes. |
| `rank` | Taxonomic rank to collapse at. One of: `"none"`, `"kingdom"`, `"domain"`, `"phylum"`, `"class"`, `"order"`, `"family"`, `"genus"`, `"species"`, `"subspecies"`, or abbreviations `"k"`, `"d"`, `"p"`, `"c"`, `"o"`, `"f"`, `"g"`, `"s"`, `"ss"`. Default: `"none"`. Mutually exclusive with `groups`. |
| `triangle_mode` | Collapse triangle visualization mode. `"max"` shows the full clade range, `"min"` shows the minimal range, `"mixed"` uses adaptive selection, `"none"` disables triangles. Default: `"mixed"`. |
| `space_mode` | Space allocation strategy for collapsed clades. `"equal"` assigns equal vertical space to each clade, `"proportional"` allocates space proportional to tip count. Default: `"proportional"`. |
| `layout` | Tree layout. `"rectangular"` for standard rectangular layout, `"circular"` for fan/circular layout. Default: `"rectangular"`. |
| `angle` | Fan angle in degrees for circular layout (0-360). Only used when `layout = "circular"`. Default: `360`. |
| `color_palette` | Color palette specification. Can be:  - A palette name: `"viridis"` (default), `"rainbow"`, or any RColorBrewer palette name (e.g., `"Set1"`, `"Paired"`) - A character vector of hex color codes (recycled if shorter than needed) |
| `color_mapping` | Named character vector of specific color assignments. Takes highest priority over `color_palette`. Names should match group names. Example: `c("Proteobacteria" = "#E41A1C", "Firmicutes" = "#377EB8")`. |
| `line_width` | Branch line width (passed to ggtree). Default: `1`. |
| `show_tip_labels` | Logical. Whether to display tip labels. Default: `FALSE` (recommended for trees with >100 tips). |
| `tip_label_size` | Numeric. Tip label font size. Default: `2`. |
| `add_timescale` | Logical. Whether to add a geological timescale to the x-axis. Requires rectangular layout and valid edge lengths. Default: `TRUE`. |
| `timescale_levels` | Character vector of timescale levels to display. Options: `"eras"`, `"eons"`, `"periods"`. Default: `c("eras", "eons")`. |
| `unit` | Time unit of input tree edge lengths: `"Ga"` (giga-annum) or `"Ma"` (mega-annum). **Required whenever `add_timescale = TRUE`**: the pipeline aborts if `unit` is `NULL`, because Rclade does not infer branch-length units and does not verify that the input tree is a time-calibrated chronogram. If `"Ga"`, edge lengths are converted to Ma (multiplied by 1000). `NULL` (default) leaves the tree's native units untouched and is only valid with `add_timescale = FALSE`. Rclade displays the user-supplied time calibration only; it never estimates divergence times. Default: `NULL`. |
| `taxonomy_format` | Taxonomy label format. `"auto"` enables automatic detection via prefix-matching heuristic. Manual options: `"GTDB"`, `"Silva"`, `"NCBI"`, `"custom_rank"`, `"custom_regex"`. Default: `"auto"`. |
| `custom_patterns` | Named list of regex patterns for custom format parsing. Required when `taxonomy_format = "custom_regex"`. Example: `list(domain = "Domain:([^\|]+)", phylum = "Phylum:([^\|]+)")`. |
| `taxonomy_file` | Character. Path to an external taxonomy file. The file should have two columns: (1) tip labels and (2) taxonomy strings in GTDB format (e.g., `d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria`). Supports tab-delimited or comma-delimited files. When provided, this file supplements or overrides label-based taxonomy parsing. Default: `NULL`. |
| `taxonomy_file_sep` | Character. Column separator for taxonomy file. `"auto"` auto-detects tab or comma. Default: `"auto"`. |
| `taxonomy_file_header` | Logical. Whether taxonomy file has a header row. Default: `FALSE`. |
| `taxonomy_file_priority` | Logical. If `TRUE` (default), file taxonomy takes priority over label-based parsing. If `FALSE`, file is used only for labels that cannot be parsed from the tree. Default: `TRUE`. Superseded by `taxonomy_source_priority` if provided. |
| `taxonomy_source_priority` | Character. Which taxonomy source takes priority when both embedded (label-based) and table (file-based) taxonomy are available: `"embedded"` or `"table"`. Default: `NULL` (use `taxonomy_file_priority`). |
| `taxonomy_table_sep` | Character. Separator between taxonomy ranks in the second column of an external taxonomy file. Default: `";"`. |
| `taxonomy_delimiter_mode` | Character. Embedded (Format A) parsing strategy: `"reverse"` (right-to-left, default), `"greedy"` (left-to-right), or `"segment"` (delimiter-to-delimiter extraction). |
| `legend_position` | Legend placement. Can be a cardinal direction (`"bottom"`, `"top"`, `"right"`, `"left"`, `"none"`) or a length-2 numeric vector `c(x, y)` for inside placement (ggplot2 >= 3.5). Default: `"bottom"` (horizontal layout). |
| `legend_nrow` | Integer. Number of rows in legend grid. Auto-computed if NULL. |
| `legend_ncol` | Integer. Number of columns in legend grid. Auto-computed if NULL. |
| `legend_title` | Character. Custom legend title. If `NULL`, the rank name (e.g., "Phylum", "Class") is used automatically. Default: `NULL`. |
| `clade` | Character. Specific clade name to collapse (e.g., "Cyanobacteriota"). When provided, only this clade is checked for monophyly and collapsed if valid. Mutually exclusive with `rank` and `groups`. Default: `NULL`. |
| `strict` | Logical. If `TRUE`, non-monophyletic clades cause termination with error. If `FALSE` (default), non-monophyletic clades trigger a warning and are skipped. The permissive default (`FALSE`) is intentional: in interactive exploration of large trees with potentially inaccurate taxonomy, halting on the first non-monophyletic group would prevent the user from seeing any result. Use `TRUE` in production pipelines where taxonomic integrity is critical. Default: `FALSE`. |
| `groups` | Named list of custom tip groups for collapsing. Each element is a character vector of tip labels belonging to that group. Groups must be monophyletic; non-monophyletic groups will raise an error. When `groups` is provided, `rank` is ignored (set it to `"none"`). Example: `list("Group_A" = c("tip1", "tip2"), "Group_B" = c("tip3"))`. |
| `show_clade_label` | Logical. Whether to add clade labels next to collapsed triangles showing group name and species count. Default: `FALSE`. |
| `show_clade_count` | Logical. Whether to show species count in clade labels (e.g., "Proteobacteria (n=42)"). Only used when `show_clade_label = TRUE`. Default: `TRUE`. |
| `clade_label_offset` | Numeric. Horizontal offset for clade labels from the right edge of the collapsed triangle in Ma units (0-5000). Default: `50`. |
| `clade_label_fontsize` | Numeric. Font size for clade labels (1-20). Default: `3`. |
| `show_support` | Logical. Whether to display node support values. Requires treedata input with posterior/bootstrap annotations. Default: `FALSE`. |
| `support_threshold` | Numeric. Minimum support value to display (0-1). Default: `0.95`. |
| `show_hpd` | Logical. Whether to display HPD (Highest Posterior Density) intervals. Requires node data with HPD annotations. Default: `FALSE`. |
| `hpd_color` | Color for HPD bars. Default: `"firebrick"`. |
| `geo_events` | Data frame of geological events to annotate, with columns `name`, `age_min`, `age_max` (Ma), `color`. If `TRUE`, default events (GOE=2400–2000 Ma, NOE=800–550 Ma) are shown. Default: `FALSE`. |
| `timescale_version` | Geological timescale version string. Currently only `"ICS 2023/02"` is supported. Default: `"ICS 2023/02"`. |
| `main_title` | Character. Main title for the plot. Default: `NULL` (no title). |
| `sub_title` | Character. Subtitle for the plot. Default: `NULL` (no subtitle). |
| `highlight` | Character vector of group names to highlight with colored backgrounds. Only monophyletic groups are highlighted; non-monophyletic groups trigger a warning. Supports special identifiers: `"LUCA"` (Last Universal Common Ancestor), `"LACA"` (Last Archaeal Common Ancestor), `"LBCA"` (Last Bacterial Common Ancestor). Default: `NULL` (no highlighting). |
| `highlight_alpha` | Numeric. Transparency of highlight color (0-1). Default: `0.2`. |
| `theme_fun` | Theme function or NULL. Default: `theme_timetree`. Set to NULL to use default ggplot2 theme. |
| `output` | Optional output file path. If provided, the plot is saved immediately (backward compatibility). Default: `NULL`. |
| `overwrite` | Character. Overwrite mode when `output` file exists: `"ask"` (default, stops with error), `"force"` (overwrite), or `"no-clobber"` (skip saving). Passed to `save_timetree()`. |
| `width` | Output width in inches. Default: `14`. |
| `height` | Output height in inches. Default: `10`. |
| `taxonomy_levels` | Optional list for custom taxonomy rank codes and names, e.g. `list(codes = c("k", "ss"), names = c("kingdom", "subspecies"))`. `codes` are the abbreviation letters used in labels (e.g., `"k"`, `"ss"`); `names` are human-readable rank names used as column names in the result data frame. Used to extend or override default rank handling. Default: `NULL`. |
| `low_memory` | Logical. If `TRUE`, enable best-effort low-memory mode by triggering garbage collection between major pipeline steps. Default: `FALSE`. |
| `ignore_malformed` | Logical. If `TRUE`, malformed inputs are skipped with a warning instead of terminating. In batch mode, failed trees are returned as `NULL`. Default: `FALSE`. |
| `ignore_branch_length` | Logical. If `TRUE`, the tree is drawn as a cladogram with all tips aligned at the same x position, ignoring the original branch lengths (equivalent to ggtree's `branch.length = "none"`). This automatically disables the geological timescale. Default: `FALSE`. |
| `color_rank` | Character. Taxonomic rank for coloring, independent of `rank` (which controls collapsing). When set (e.g., `"phylum"`), branches and tips are colored by this rank, while collapsing uses `rank`. `NULL` (default) uses `rank` for both coloring and collapsing. |
| `timescale_mode` | Character. Timescale display mode for circular layout: `"radial"` (default) draws full-circle geological background bands; `"linear"` draws a rectangular geological timescale axis (via `deeptime::guide_geo()`) at the position specified by `timescale_position`, without background bands. Ignored for rectangular layout. |
| `timescale_position` | Character. Clock position of the timescale axis when `timescale_mode = "linear"`. One of `"right"` (3 o'clock, default), `"top"` (12 o'clock), `"bottom"` (6 o'clock), `"left"` (9 o'clock). Should match `tree_start_position`. Ignored when `timescale_mode = "radial"` or for rectangular layout. |
| `tree_start_position` | Character. Clock position where the tree starts expanding (the gap between the last and first tip). One of `"right"` (3 o'clock, default), `"top"` (12 o'clock), `"bottom"` (6 o'clock), `"left"` (9 o'clock). Should match `timescale_position` when `timescale_mode = "linear"`; a warning is issued if they differ. Ignored for rectangular layout. |

**Value:**

A `ggplot` object with an `rclade_info` attribute containing
metadata (tip count, group count, taxonomy format, etc.).
Can be further customized with `+` layers.

**Examples:**

```r
# From a file with phylum-level collapsing
p <- plot_timetree("my_tree.tre", rank = "phylum", unit = "Ma")

# From a phylo object with GTDB labels
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB", add_timescale = FALSE)

# With external taxonomy file
p <- plot_timetree("my_tree.tre", rank = "phylum",
                   taxonomy_file = "taxonomy.tsv")

# Handle multi-tree file: use first tree
p <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "first")

# Handle multi-tree file: analyze all trees
plots <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "all")

# Save directly
plot_timetree(tree, rank = "phylum", output = "output.pdf")
```


---

## `batch_plot`

Batch plot timetrees from a directory of tree files

**Usage:**

```r
batch_plot(
  input_dir,
  output_dir,
  pattern = "*.tre",
  format = "pdf",
  width = 14,
  height = 10,
  overwrite = "ask",
  ...
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `input_dir` | Input directory containing tree files |
| `output_dir` | Output directory for plots |
| `pattern` | File matching pattern (glob format, e.g., "*.tre") |
| `format` | Output format: "pdf", "png", "tiff", "svg", "eps" (default "pdf") |
| `width` | Output width in inches (default 14) |
| `height` | Output height in inches (default 10) |
| `overwrite` | Overwrite mode: "ask" (default), "force", or "no-clobber" |
| `...` | Additional arguments passed to plot_timetree() |

**Value:**

Invisibly returns list of success/failure status

**Examples:**

```r
# Batch-plot every .tre file in a directory, collapsing at phylum
batch_plot(input_dir = "trees/", output_dir = "plots/",
           pattern = "*.tre", rank = "phylum", unit = "Ma")
```


---

## `save_timetree`

Save a timetree plot to file

**Usage:**

```r
save_timetree(p, file, width = 14, height = 10, dpi = 300, overwrite = "ask")
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `p` | ggplot object |
| `file` | Output file path |
| `width` | Width in inches |
| `height` | Height in inches |
| `dpi` | Resolution (for PNG/TIFF only) |
| `overwrite` | Character. Overwrite mode: "ask" (default), "force", "no-clobber". |

**Value:**

Invisibly returns the ggplot object

**Examples:**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum")
save_timetree(p, file = "tree.pdf", width = 12, height = 8)
```


---

## `summarize_timetree`

Print a summary of a Rclade timetree plot

**Usage:**

```r
summarize_timetree(p)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `p` | ggplot object returned by plot_timetree() (with rclade_info attribute) |

**Value:**

Invisibly returns the info list

**Examples:**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum")
summarize_timetree(p)
```


---

## `theme_timetree`

Based on ggtree::theme_tree2(), customized for publication quality.
Includes `coord_cartesian(clip = "off")` to prevent collapsed clade
triangles from being clipped at the plot panel boundary — triangle vertices
(especially the MRCA node apex) often extend beyond the tip-based y-axis range.

**Usage:**

```r
theme_timetree(base_size = 12)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `base_size` | Base font size |

**Value:**

A `list` with components `theme` (ggplot2 theme) and
`coord` (`coord_cartesian(clip = "off")`).  Callers should apply
both via `p + result$theme + result$coord`.

**Examples:**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum")
r <- theme_timetree(base_size = 14)
print(p + r$theme + r$coord)
```


---


---

[中文](../../cn/reference/core-visualization.md) | [文档首页](../../index.md)
