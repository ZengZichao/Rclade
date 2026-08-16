# Rclade

[English](README.EN.md) | [中文](README.CN.md)

<!-- badges: start -->
[![R package](https://img.shields.io/badge/R-package-blue.svg)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)]()
<!-- badges: end -->

> **Note:** Source code and issue tracking at https://github.com/zengzichao/Rclade.
> Install from the source tarball as shown below, or clone the GitHub repository.

Rclade provides a single-function pipeline for automated collapsing and visualization of large phylogenetic trees with geological timescales. It is designed for **deep-time phylogenomics** and **microbial evolution studies**, enabling researchers to visualize taxonomic relationships across geological time scales (Ga/Ma) with automatic clade collapsing based on GTDB, Silva, or NCBI taxonomy.

## Full Documentation

An online pkgdown site (function reference, articles, news) is built from the `main` branch at <https://zengzichao.github.io/Rclade>.

In addition to this quick reference, Rclade ships a complete bilingual documentation set (per-function reference, tutorials, cookbook, and FAQ) in `inst/docs/`:

- 中文文档总览：[inst/docs/cn/index.md](inst/docs/cn/index.md)
- English documentation：[inst/docs/en/index.md](inst/docs/en/index.md)
- 函数参考（中文）：[inst/docs/cn/reference/index.md](inst/docs/cn/reference/index.md)
- Function reference (EN)：[inst/docs/en/reference/index.md](inst/docs/en/reference/index.md)

## Features

- **Automatic taxonomy parsing**: Detects GTDB, Silva, NCBI, and custom label formats via heuristic prefix matching
- **Dual-format taxonomy**: Format A (embedded `_d_Bacteria_...`) with reverse matching, Format B (semicolon `d__Bacteria;...`) with value validation
- **Batch clade collapsing**: Nesting-aware depth-first ordering with automatic conflict detection
- **Clade-specific collapsing**: `--clade` option to collapse a specific clade with monophyly check
- **Geological timescale integration**: Adaptive time breaks (Ma/Ka) via deeptime with ICS 2023/02 chronostratigraphy
- **Smart legend layout**: Auto-adjusting rows/columns for any number of groups
- **Publication-ready output**: Color-blind-safe palettes (viridis default), high-resolution PDF/PNG/SVG/TIFF/EPS
- **Special ancestral node identifiers**: LUCA, LACA, LBCA, ROOT for highlighting key nodes
- **External taxonomy file support**: Read taxonomy from external file with circular dependency detection
- **Tree-sequence cross-validation**: Automatic tip label vs sequence ID matching
- **Real-time logging**: ISO 8601 timestamps with milliseconds, step tracking, log file output
- **Comprehensive input validation**: Deep tree/sequence validation, PHYLIP/Stockholm rejection
- **Cross-platform robustness**: UTF-8 encoding, BOM handling, newline normalization
- **Graceful interrupt handling**: Ctrl+C with progress report and resource cleanup
- **Adversarial input protection**: Control character/BiDi detection, empty file rejection
- **Self-test mode**: `--check` validates dependencies, parsing, and monophyly logic
- **Multiple interfaces**: R API, CLI (`run_rclade_cli()` / `inst/bin/rclade` wrapper script), and Shiny web app (`run_rclade_shiny()`)

## Installation

### From source

```r
# Install from the local source tarball
install.packages("path/to/Rclade_1.0.0.tar.gz", repos = NULL, type = "source")
```

### Using Conda

```bash
conda env create -f environment.yml
conda activate rclade
```

> **Reproducibility note**: `environment.yml` specifies minimum version bounds.
> For fully reproducible environments, export an explicit spec after creation:
> ```bash
> conda list --explicit > conda-lockfile.txt
> # Restore with: conda create --name rclade --file conda-lockfile.txt
> ```
> Alternatively, use `renv` inside R for package-level locking.

### Using Docker

```bash
# Build from Dockerfile
docker build -t rclade .

# Run analysis
docker run -v $(pwd):/data rclade -f tree.tre -r phylum -o output.pdf
```

### Verify Installation

```bash
# Run self-test
Rclade --check
```

## Pipeline Overview

```
Input Tree File
      │
      ▼
┌─────────────────┐
│  Read & Validate │  ← Format detection, bracket balance, negative branches, unit conversion
└────────┬────────┘
         ▼
┌─────────────────┐
│  Parse Taxonomy  │  ← GTDB/Silva/NCBI/Embedded format auto-detection (clade/groups/rank modes)
└────────┬────────┘
         ▼
┌─────────────────┐
│  Compute MRCA    │  ← Monophyly check + Most Recent Common Ancestor + nesting conflict detection
└────────┬────────┘
         ▼
┌─────────────────┐
│  Generate Colors │  ← Color-blind-safe palette (viridis default)
└────────┬────────┘
         ▼
┌─────────────────┐
│  Render & Collapse│  ← ggtree rendering + depth-first, nesting-aware batch collapse
└────────┬────────┘
         ▼
┌─────────────────┐
│  Timescale & Annot│  ← deeptime timescale + support/HPD/clade labels/highlight
└────────┬────────┘
         ▼
┌─────────────────┐
│  Export Output   │  ← Legend/theme/title + PDF/PNG/SVG/TIFF/EPS with overwrite control
└─────────────────┘
```

## Quick Start

```r
library(Rclade)

# Load built-in example tree (50 tips, GTDB labels)
data(example_tree)

# Plot with phylum-level collapsing
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE)

# Collapse a specific clade
p <- plot_timetree(example_tree, clade = "Cyanobacteria",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE)

# Add geological timescale
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   unit = "Ma", add_timescale = TRUE)

# Save to file
save_timetree(p, "output.pdf", width = 14, height = 10)

# One-line pipeline
plot_timetree(example_tree, rank = "phylum", output = "output.pdf")
```

## Supported Taxonomy Formats

| Format | Detection | Example |
|--------|-----------|---------|
| **GTDB** (Format B) | Prefix `d__`, `p__`, `c__`, ... | `d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria` |
| **Embedded** (Format A) | `_d_`, `_p_`, `_c_`, ... | `GB_GCA_001_d_Bacteria_p_Proteobacteria_c_Gammaproteobacteria` |
| **Silva** | Semicolon-delimited, no prefix | `Bacteria;Proteobacteria;Gammaproteobacteria` |
| **NCBI** | Starts with `cellular organisms`, `root`, ... | `cellular organisms;Bacteria;Proteobacteria` |
| **Custom regex** | User-provided patterns | `list(domain = "Domain:([^|]+)")` |

## Key Functions

| Function | Description |
|----------|-------------|
| `plot_timetree()` | Main entry point: collapse + visualize in one call |
| `rclade_options()` | Build a validated options list for `plot_timetree(opts = ...)` |
| `save_timetree()` | Export to PDF/PNG/SVG/TIFF/EPS with overwrite control |
| `batch_plot()` | Batch-plot all tree files in a directory |
| `summarize_timetree()` | Print collapse metadata |
| `summarize_taxonomy_quality()` | Report label parsing quality |
| `summarize_taxonomy_quality_with_file()` | Report quality with external file |
| `check_monophyly()` | Check if a group is monophyletic |
| `check_special_monophyly()` | Check if LUCA/LACA/LBCA is monophyletic |
| `detect_taxonomy_format()` | Detect taxonomy label format (GTDB/Silva/NCBI/embedded) |
| `parse_taxonomy()` | **Library-mode API**: parse taxonomy from tip labels, returns a data.frame |
| `read_tree_auto()` | **Library-mode API**: auto-detect format and read a tree file (for external workflows) |
| `read_taxonomy_file()` | Read taxonomy from external file |
| `validate_sequence_deep()` | Deep sequence file validation |
| `validate_sequence_file()` | Validate sequence file format |
| `validate_tree_sequence_match()` | Cross-validate tree tips vs sequence IDs |
| `theme_timetree()` | Publication-ready ggplot2 theme |
| `run_rclade_selftest()` | Run comprehensive self-test |
| `run_rclade_shiny()` | Launch interactive Shiny web app |
| `save_session_info()` | Export sessionInfo for reproducibility |
| `set_log_level()` | Set logging level (DEBUG/INFO/WARNING/ERROR/CRITICAL) |
| `set_log_file()` | Enable log file output |
| `set_log_enabled()` | Enable or disable logging |
| `rclade_logo()` | Display ASCII art logo |
| `get_supported_extensions()` | List supported file extensions |

### Internal Utility Functions

The following infrastructure helpers are **internal** (not exported) as of the
export-surface convergence; access them with `Rclade:::` if needed:

| Function | Description |
|----------|-------------|
| `batch_with_interrupt()` | Batch processing with graceful Ctrl+C handling; returns partial results list on interrupt |
| `build_path()` | Cross-platform safe path construction |
| `managed_tempdir()` / `managed_tempfile()` | Temporary resources with automatic cleanup |
| `normalize_file_newlines()` | Normalize line endings in a file |
| `log_debug()` / `log_info()` / `log_warning()` / `log_error()` / `log_critical()` | Real-time logging helpers |
| `log_section()` / `log_subsection()` / `log_keyvalue()` / `log_progress()` / `log_stats()` / `log_table()` | Formatted log output |
| `timer_start()` / `timer_stop()` | Performance timing helpers |
| `with_graceful_interrupt()` | Wrap expression with graceful SIGINT handling |
| `resolve_special_identifier()` / `resolve_group()` | Special-identifier / group resolvers |
| `validate_custom_groups()` / `validate_taxonomy_no_cycles()` | Group / taxonomy validators |
| `generate_colors()` | Color-blind-safe palette generation |
| `split_legend()` | Extract legend as separate panel |
| `detect_encoding()` | Detect file encoding (UTF-8, BOM, etc.) |

## Clade-specific Collapsing

Collapse a specific clade by name (checks monophyly first):

```r
# Collapse only Cyanobacteria (if monophyletic)
p <- plot_timetree(example_tree, clade = "Cyanobacteria",
                   taxonomy_format = "GTDB")

# Strict mode: terminate if not monophyletic
p <- plot_timetree(example_tree, clade = "Proteobacteria",
                   strict = TRUE, taxonomy_format = "GTDB")
```

CLI usage:
```bash
# Collapse specific clade
Rclade -f tree.tre --clade Cyanobacteria -o output.pdf

# Strict mode
Rclade -f tree.tre --clade Proteobacteria --strict -o output.pdf
```

### Using the wrapper script for standard exit codes

The package includes a shell wrapper at `inst/bin/rclade`:

```bash
# Add inst/bin/rclade to PATH or use the full path
export PATH="/path/to/Rclade/inst/bin:$PATH"
rclade -f tree.tre -r phylum -o output.pdf
```

Compared to `Rscript -e "Rclade::run_rclade_cli(...)"`, the wrapper:
- Correctly propagates exit codes 0/1/2/3
- Returns the standard Unix exit code **130** on Ctrl+C (SIGINT) interruption
- Uses the same CLI arguments

## Special Ancestral Node Identifiers

| Identifier | Description | Target |
|------------|-------------|--------|
| **ROOT** | Root of the tree | All tips |
| **LUCA** | Last Universal Common Ancestor | MRCA of Bacteria + Archaea |
| **LACA** | Last Archaeal Common Ancestor | MRCA of Archaea |
| **LBCA** | Last Bacterial Common Ancestor | MRCA of Bacteria |

```r
# Highlight LUCA
p <- plot_timetree(example_tree, rank = "phylum",
                   highlight = c("LUCA"), add_timescale = FALSE)

# Check monophyly
result <- check_special_monophyly(example_tree, "LBCA")
```

## Multi-tree File Handling

```r
# Use first tree
p <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "first")

# Use randomly selected tree
p <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "random")

# Analyze all trees (returns list of plots)
plots <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "all")

# split mode: same as "all" (returns multiPhylo), but signals per-tree output
# splitting to the CLI (numeric suffixes on output files)
plots <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "split")
```

## External Taxonomy File

```r
# Read taxonomy from file
taxa <- read_taxonomy_file("taxonomy.tsv")

# Use external file for collapsing
p <- plot_timetree(tree, rank = "phylum", taxonomy_file = "taxonomy.tsv")

# With custom separator
p <- plot_timetree(tree, rank = "phylum",
                   taxonomy_file = "taxonomy.csv",
                   taxonomy_file_sep = ",")
```

## Tree-Sequence Cross-Validation

```r
# Validate tree tips match sequence IDs
validate_tree_sequence_match("tree.nwk", "sequences.fasta")

# For multi-tree files, specify how to handle them (default "error")
validate_tree_sequence_match("beast.trees", "sequences.fasta",
                             multi_tree_mode = "first")

# In plot_timetree (via CLI)
# Rclade -f tree.tre --sequence_file seqs.fasta -r phylum
```

## CLI Reference

### Basic Usage

```bash
# Show help (all parameters, defaults, examples)
Rclade --help

# Show version with dependency versions
Rclade --version

# Run self-test
Rclade --check

# Basic usage with phylum-level collapsing
Rclade -f tree.tre -r phylum -o output.pdf

# With GTDB format and Ma time units
Rclade -f tree.tre -r phylum --taxonomy_format GTDB -u Ma -o output.pdf

# Collapse specific clade
Rclade -f tree.tre --clade Cyanobacteria -o output.pdf
```

### Taxonomy Options

```bash
# External taxonomy file
Rclade -f tree.tre -r phylum --taxonomy_file taxa.tsv -o output.pdf

# Taxonomy file with header row and comma separator
Rclade -f tree.tre -r phylum --taxonomy_file taxa.csv --taxonomy_file_header --taxonomy_file_sep comma

# Embedded format parsing strategy (reverse/greedy/segment)
Rclade -f tree.tre -r phylum --taxonomy_format custom_rank --taxonomy_delimiter_mode reverse

# Table taxonomy takes priority over embedded
Rclade -f tree.tre -r phylum --taxonomy_file taxa.tsv --taxonomy_source_priority table

# Custom taxonomy levels (kingdom, subspecies): code:prefix format
# Here k uses _k_ as the embedded delimiter and ss uses _ss_
Rclade -f tree.tre -r phylum --taxonomy_format custom_rank --taxonomy_levels "k:_k_,ss:_ss_"

# Custom taxonomy table separator (separator inside taxonomy strings)
Rclade -f tree.tre -r phylum --taxonomy_file taxa.tsv --taxonomy_table_sep "|"
```

### Multi-tree Options

```bash
# Use first tree
Rclade -f beast.trees --multi_tree_mode first -r phylum -o output.pdf

# Use last tree
Rclade -f beast.trees --multi_tree_mode last -r phylum -o output.pdf

# Use randomly selected tree
Rclade -f beast.trees --multi_tree_mode random -r phylum -o output.pdf

# Use specific tree by index
Rclade -f beast.trees --tree_index 42 -r phylum -o output.pdf

# Analyze all trees (output gets numeric suffixes)
Rclade -f beast.trees --multi_tree_mode all -r phylum -o output.pdf
# Generates: output_1.pdf, output_2.pdf, ...

# split mode: same as "all" but semantically signals per-tree output for
# downstream pipeline dispatch
Rclade -f beast.trees --multi_tree_mode split -r phylum -o output.pdf
```

### Sequence Validation

```bash
# Cross-validate tree tips with sequence IDs
Rclade -f tree.tre --sequence_file seqs.fasta -r phylum -o output.pdf

# Skip cross-validation
Rclade -f tree.tre --sequence_file seqs.fasta --no_cross_check -r phylum

# Specify molecule type (DNA/RNA/protein/auto)
Rclade -f tree.tre --sequence_file seqs.fasta --mol_type DNA -r phylum

# Skip alignment length check
Rclade -f tree.tre --sequence_file seqs.fasta --skip_length_check -r phylum
```

### Output Control

```bash
# Force overwrite existing output
Rclade -f tree.tre -r phylum -o output.pdf --force

# Skip if output exists (no overwrite)
Rclade -f tree.tre -r phylum -o output.pdf --no_clobber

# Skip malformed inputs instead of terminating
Rclade -f tree.tre -r phylum --ignore_malformed -o output.pdf

# Low-memory mode for large trees
Rclade -f tree.tre -r phylum --low_memory -o output.pdf

# Strip node annotations (bootstrap/NHX) to reduce output size
Rclade -f tree.nhx -r phylum --strip_annotations -o output.pdf
```

### Configuration File Support

Rclade supports YAML configuration files for supplying defaults. Precedence: **explicit CLI flags > config file > built-in defaults**. The package ships a `config.example.yaml` template listing all configurable options; access it with:

```r
system.file("extdata", "config.example.yaml", package = "Rclade")
```

```bash
# Use a config file
Rclade --config config.yaml -f tree.tre -o output.pdf

# CLI flags override the config file (here rank takes precedence)
Rclade --config config.yaml -f tree.tre -r genus -o output.pdf
```

Example config (see `inst/extdata/config.example.yaml` for the full template):

```yaml
# Any CLI long-flag name can be used as a key
rank: phylum
taxonomy_format: GTDB
unit: Ma
multi_tree_mode: error
strip_annotations: false
log_level: INFO
```

> Note: optparse cannot distinguish "user explicitly passed the default value" from "user did not pass the flag". If you explicitly pass a value equal to the built-in default, the config value will still take effect. To force a setting over the config file, pass it explicitly on the CLI.

### Logging Options

```bash
# Debug logging
Rclade -f tree.tre -r phylum --log_level DEBUG -o output.pdf

# Log to file
Rclade -f tree.tre -r phylum --log_file analysis.log -o output.pdf

# Combined
Rclade -f tree.tre -r phylum --log_level DEBUG --log_file debug.log -o output.pdf
```

### Complete CLI Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `-f, --file` | FILE | - | Input tree file (required) |
| `-o, --out` | FILE | `timetree_plot.pdf` | Output file |
| `-W, --width` | NUM | 14 | Width in inches |
| `-H, --height` | NUM | 10 | Height in inches |
| `-r, --rank` | RANK | none | Collapse rank |
| `--clade` | NAME | - | Specific clade to collapse |
| `--strict` | FLAG | FALSE | Terminate if clade not monophyletic |
| `--tree_index` | INT | - | Tree index in multi-tree file |
| `--multi_tree_mode` | MODE | error | Multi-tree handling: error/ask/first/last/random/all/split |
| `--taxonomy_format` | STR | auto | Format: auto/GTDB/Silva/NCBI/custom_rank/custom_regex |
| `--taxonomy_file` | FILE | - | External taxonomy file |
| `--taxonomy_file_sep` | STR | auto | Separator: auto/tab/comma |
| `--taxonomy_file_header` | FLAG | FALSE | File has header row |
| `--no_taxonomy_file_priority` | FLAG | FALSE | Lower file priority |
| `--taxonomy_delimiter_mode` | STR | reverse | Embedded parsing strategy: reverse/greedy/segment |
| `--taxonomy_source_priority` | STR | table | Source priority: `embedded`/`table` |
| `--taxonomy_table_sep` | STR | ; | Table value separator (rank separator within taxonomy strings) |
| `--taxonomy_levels` | STR | - | Custom rank mapping, format `code:prefix`, e.g. `k:_k_,ss:_ss_` |
| `-t, --triangle_mode` | MODE | mixed | Triangle: max/min/mixed/none |
| `-s, --space_mode` | MODE | proportional | Space: equal/proportional |
| `-l, --layout` | STR | rectangular | Layout: rectangular/circular |
| `-u, --unit` | STR | auto | Unit: auto/Ga/Ma (auto = leave tree units untouched; Ga converts x1000) |
| `--angle` | NUM | 360 | Fan angle for circular layout (10-360 degrees) |
| `--line_width` | NUM | 1 | Branch line width |
| `--ignore_branch_length` | FLAG | FALSE | Cladogram mode (ignore branch lengths) |
| `--color_palette` | STR | viridis | Palette name or hex colors |
| `--color_mapping` | STR | - | Color mapping: `Group:#FF0000` |
| `--show_tip_labels` | FLAG | FALSE | Show tip labels |
| `--tip_label_size` | NUM | 2 | Tip label font size |
| `--show_clade_label` | FLAG | FALSE | Show clade labels |
| `--no_clade_count` | FLAG | FALSE | Hide species count in clade labels |
| `--clade_label_offset` | NUM | 50 | Clade label offset |
| `--clade_label_fontsize` | NUM | 3 | Clade label font size |
| `--show_support` | FLAG | FALSE | Show node support values |
| `--support_threshold` | NUM | 0.95 | Minimum support value threshold (0-1) |
| `--show_hpd` | FLAG | FALSE | Show HPD intervals |
| `--hpd_color` | STR | firebrick | HPD bar color |
| `--legend_position` | STR | bottom | Legend position: bottom/right/left/top/none |
| `--legend_nrow` | INT | - | Number of legend rows |
| `--legend_ncol` | INT | - | Number of legend columns |
| `--no_timescale` | FLAG | FALSE | Disable timescale |
| `--timescale_levels` | STR | eras,eons | Timescale levels (comma-separated): eons/eras/periods |
| `--geo_events` | FLAG | FALSE | Show geological event bands (GOE, NOE) |
| `--highlight` | STR | - | Highlight clades (comma-separated) |
| `--highlight_alpha` | NUM | 0.2 | Highlight transparency (0-1) |
| `--main_title` | STR | - | Main plot title |
| `--sub_title` | STR | - | Plot subtitle |
| `--sequence_file` | FILE | - | Sequence file for cross-validation |
| `--mol_type` | STR | auto | Molecule type: DNA/RNA/protein/auto |
| `--skip_length_check` | FLAG | FALSE | Skip alignment length consistency check |
| `--no_cross_check` | FLAG | FALSE | Disable tree-sequence validation |
| `--force` | FLAG | FALSE | Overwrite existing output |
| `--no_clobber` | FLAG | FALSE | Skip if output exists |
| `--ignore_malformed` | FLAG | FALSE | Skip malformed inputs with a warning instead of terminating |
| `--low_memory` | FLAG | FALSE | Low-memory mode (best-effort memory reduction) |
| `--log_level` | STR | INFO | Log level: DEBUG/INFO/WARNING/ERROR/CRITICAL |
| `--log_file` | FILE | - | Log to file |
| `--check` | FLAG | FALSE | Run self-test |
| `--strip_annotations` | FLAG | FALSE | Strip node annotations (bootstrap/NHX) to reduce output size |
| `--config` | FILE | - | Path to YAML config file; CLI flags > config > defaults |
| `-v, --version` | FLAG | FALSE | Show version |

## `plot_timetree()` Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `tree` | phylo/character | - | Tree object or file path (required) |
| `tree_index` | integer | NULL | Index for multi-tree files |
| `multi_tree_mode` | character | "error" | Multi-tree handling: error/ask/first/last/random/all/split |
| `rank` | character | "none" | Collapse rank: none/kingdom/domain/phylum/class/order/family/genus/species/subspecies (abbreviations: k/d/p/c/o/f/g/s/ss) |
| `clade` | character | NULL | Specific clade name to collapse |
| `strict` | logical | FALSE | Terminate if clade not monophyletic |
| `groups` | list | NULL | Custom tip groups for collapsing |
| `triangle_mode` | character | "mixed" | Triangle mode: max/min/mixed/none |
| `space_mode` | character | "proportional" | Space allocation: equal/proportional |
| `layout` | character | "rectangular" | Layout: rectangular/circular |
| `angle` | numeric | 360 | Fan angle for circular layout |
| `color_palette` | character | "viridis" | Palette name or hex vector |
| `color_mapping` | named vector | NULL | Specific color assignments |
| `line_width` | numeric | 1 | Branch line width |
| `show_tip_labels` | logical | FALSE | Display tip labels |
| `tip_label_size` | numeric | 2 | Tip label font size |
| `add_timescale` | logical | TRUE | Add geological timescale |
| `timescale_levels` | character | c("eras","eons") | Timescale levels to show |
| `unit` | character | NULL | Time unit: Ga/Ma |
| `taxonomy_format` | character | "auto" | Format: auto/GTDB/Silva/NCBI/custom_rank/custom_regex |
| `custom_patterns` | list | NULL | Custom regex patterns |
| `taxonomy_file` | character | NULL | External taxonomy file path |
| `taxonomy_file_sep` | character | "auto" | File separator: auto/tab/comma |
| `taxonomy_file_header` | logical | FALSE | File has header row |
| `taxonomy_file_priority` | logical | TRUE | File takes priority over labels |
| `taxonomy_source_priority` | character | NULL | Source priority: `embedded`/`table` (overrides taxonomy_file_priority) |
| `taxonomy_table_sep` | character | ";" | Separator between ranks in file taxonomy strings |
| `taxonomy_delimiter_mode` | character | "reverse" | Embedded parsing strategy: reverse/greedy/segment |
| `taxonomy_levels` | list | NULL | Custom rank configuration, e.g. `list(codes = c("k", "ss"), names = c("kingdom", "subspecies"))` |
| `legend_position` | character | "bottom" | Legend position |
| `legend_title` | character | NULL | Custom legend title |
| `show_clade_label` | logical | FALSE | Show clade labels |
| `show_clade_count` | logical | TRUE | Show species count in labels |
| `clade_label_offset` | numeric | 50 | Horizontal offset for clade labels (Ma) |
| `clade_label_fontsize` | numeric | 3 | Font size for clade labels |
| `show_support` | logical | FALSE | Show node support values |
| `support_threshold` | numeric | 0.95 | Minimum support to display |
| `show_hpd` | logical | FALSE | Show HPD intervals |
| `hpd_color` | character | "firebrick" | Color for HPD bars |
| `geo_events` | data.frame/FALSE | FALSE | Geological events to annotate (GOE, NOE) |
| `timescale_version` | character | "ICS 2023/02" | Geological timescale version |
| `main_title` | character | NULL | Main plot title |
| `sub_title` | character | NULL | Plot subtitle |
| `highlight` | character | NULL | Groups to highlight |
| `highlight_alpha` | numeric | 0.2 | Highlight transparency |
| `output` | character | NULL | Save directly to file |
| `overwrite` | character | "ask" | Overwrite mode: ask/force/no-clobber |
| `width` | numeric | 14 | Output width in inches |
| `height` | numeric | 10 | Output height in inches |
| `legend_nrow` | integer | NULL | Number of rows in legend grid |
| `legend_ncol` | integer | NULL | Number of columns in legend grid |
| `theme_fun` | function | theme_timetree | Theme function to apply (NULL for default ggplot2) |
| `low_memory` | logical | FALSE | Low-memory mode (best-effort GC between steps) |
| `ignore_malformed` | logical | FALSE | Skip malformed inputs with warning instead of terminating |
| `ignore_branch_length` | logical | FALSE | Cladogram mode (ignore branch lengths) |
| `color_rank` | character | NULL | Taxonomic rank for branch coloring (independent of collapse `rank`; colors by collapse groups when NULL) |
| `timescale_mode` | character | "radial" | Timescale mode for circular layout: radial / linear (3 o'clock) |
| `timescale_position` | character | "right" | Timescale start orientation for circular layout |
| `tree_start_position` | character | "right" | Tree drawing start orientation for circular layout |

## Input/Output Formats

### Tree File Conventions

- **Node numbering**: Internal nodes are 1-indexed (root = Ntip + 1), following `ape` convention
- **Edge lengths**: Must be non-negative (CRITICAL error if negative values detected)
- **Tip labels**: Must be unique (ERROR if duplicates found)
- **Label length**: Newick labels longer than 500 characters are truncated to 400 characters + `_RCLADE_TRUNC` (with a warning) before parsing, because ape's parser aborts the whole R process on labels longer than ~512 characters on Linux. Shorten labels upstream if they must match external files exactly
- **Coordinate system**: Phylogenetic trees use branch-length coordinates (time in Ma/Ga), not sequence coordinates
- **Standard compliance**: Newick format per [Newick standard](https://evolution.genetics.washington.edu/phylip/newicktree.html), Nexus per [NEXUS standard](https://doi.org/10.1093/sysbio/46.4.590)

### Supported Tree Formats

| Format | Extensions | Description |
|--------|------------|-------------|
| Newick | `.nwk`, `.tre`, `.tree`, `.treefile`, `.newick` | Standard phylogenetic tree format |
| Nexus | `.nexus`, `.nex` | NEXUS format with metadata support |
| BEAST XML | `.xml`, `.beast` | BEAST2 output format |
| NHX | `.nhx` | New Hampshire Extended format |
| Consensus | `.con`, `.confile` | Treated as Newick (parsed with `ape::read.tree()`) |

### Supported Sequence Formats

| Format | Extensions | Description |
|--------|------------|-------------|
| FASTA | `.fasta`, `.fa`, `.fna`, `.fas`, `.faa` | Standard sequence format |
| FASTQ | `.fastq`, `.fq` | Sequencing reads with quality |

**Rejected formats** (with informative error):
- PHYLIP format
- Stockholm format

### Taxonomy File Format

External taxonomy files should have two columns:
1. Tip label (must match tree)
2. Taxonomy string in GTDB format

```
# Tab-delimited (TSV)
tip1	d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria
tip2	d__Bacteria;p__Firmicutes;c__Bacilli

# Comma-delimited (CSV)
tip1,d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria
tip2,d__Bacteria;p__Firmicutes;c__Bacilli
```

Missing ranks indicated by empty value after prefix: `s__` (species missing)

### Output Formats

| Format | Extension | Notes |
|--------|-----------|-------|
| PDF | `.pdf` | Vector format, publication-ready |
| PNG | `.png` | Raster format, 300 DPI default |
| SVG | `.svg` | Vector format, web-friendly |
| TIFF | `.tiff` | Raster format, print-ready |
| EPS | `.eps` | Vector format, LaTeX compatible |

## Standards Compliance

| Standard | Description | Reference |
|----------|-------------|-----------|
| **Newick** | Phylogenetic tree format | [Newick standard](https://evolution.genetics.washington.edu/phylip/newicktree.html) |
| **NEXUS** | Multi-purpose data format | [Maddison et al. 1997](https://doi.org/10.1093/sysbio/46.4.590) |
| **GTDB** | Genome Taxonomy Database | [GTDB](https://gtdb.ecogenomic.org/) |
| **SILVA** | Ribosomal RNA database | [SILVA](https://www.arb-silva.de/) |
| **NCBI Taxonomy** | NCBI organismal taxonomy | [NCBI Taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy) |
| **ICS Chronostratigraphy** | Geological time scale | [ICS 2023/02](https://stratigraphy.org/chart) |
| **ISO 8601** | Date/time format | [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) |

## Exit Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 0 | Success | All operations completed successfully |
| 1 | Runtime error | Dependency missing, self-test failure, internal error |
| 2 | Parameter error | Invalid command-line arguments, missing required options |
| 3 | Input data error | Malformed tree/sequence file, cross-validation failure |
| 130 | User interrupt | Ctrl+C (SIGINT) received during execution; `run_rclade_cli()` returns 130, and the `inst/bin/rclade` wrapper guarantees stable propagation to 130 in terminal sessions |

> Note: `run_rclade_cli()` now uses `tryCatch` to catch interrupts and return 130, so it should return 130 both in interactive R and when the session ends with `q(status = run_rclade_cli(...))`. However, for complex signal scenarios or plain `Rscript -e` calls, we still recommend using the provided `inst/bin/rclade` wrapper, which forwards SIGINT directly from the shell and returns 130.

## Troubleshooting

### Common Errors and Solutions

| Error | Cause | Solution |
|-------|-------|----------|
| `Input file (-f) is required` | No input file specified | Add `-f <tree_file>` |
| `Input file does not exist` | File path incorrect | Check file path and permissions |
| `CRITICAL: Empty file` | 0-byte input file | Check if file was properly transferred |
| `CRITICAL: Negative branch lengths` | Tree has negative edges | Remove or fix negative branches |
| `ERROR: Duplicate tip labels` | Same label appears twice | Make tip labels unique |
| `ERROR: Control characters detected` | Malicious characters in labels | Clean labels of control/BiDi chars (affected names are shown as `<U+XXXX>` escapes) |
| `WARNING: ... label(s) exceed 500 characters ... truncated` | ape's Newick parser crashes on labels > ~512 chars | Rclade truncated them to 400 chars + `_RCLADE_TRUNC`; shorten labels upstream if exact matching is needed |
| `Circular dependency detected` | Taxonomy has cycles (e.g., d__A;p__B and d__B;p__A) | Fix taxonomy file |
| `Clade 'X' not found` | Clade name not in taxonomy | Check spelling and format |
| `Group 'X' is NOT monophyletic` | Group scattered in tree | Use `--clade` with `--strict`, or use `--rank` |
| `Multiple trees detected` | File has >1 tree | Use `--multi_tree_mode` or `--tree_index` |
| `PHYLIP format not supported` | Wrong sequence format | Convert to FASTA first |
| `Duplicate sequence IDs` | Same ID in FASTA | Make sequence IDs unique |
| `Tree-sequence mismatch` | Labels don't match | Ensure tip labels = sequence IDs |
| `Output file already exists` | File exists | Use `--force` to overwrite or `--no_clobber` to skip |

### Performance Tips

| Tips | Recommendation |
|------|----------------|
| >5,000 tips | Use `--show_tip_labels` sparingly |
| >10,000 tips | Consider `--low_memory` mode |
| >50,000 tips | Expect high memory usage (>4GB) |
| Large trees | Use PDF output (faster than PNG) |
| Many groups | Use `--no_timescale` to disable timescale |

## Real-time Logging

```r
# Set log level
set_log_level("DEBUG")

# Log to file
set_log_file("analysis.log")

# Run analysis
p <- plot_timetree(example_tree, rank = "phylum")
```

Log format (ISO 8601 with milliseconds):
```
2026-06-13T15:30:45.123 | INFO     | Step 1/7: Input validation and reading
2026-06-13T15:30:45.125 | INFO     | Reading tree file: example.tre
2026-06-13T15:30:45.130 | DEBUG    | Memory: 45.2 MB used (approx)
```

Logging functions (`log_info()` / `log_warning()` / `log_error()`, etc.) accept an optional `.module` argument that inserts a `[MODULE/FUNCTION]` source tag into warning/error messages, making it easier to locate problems:

```r
log_warning("Skipped %d non-monophyletic group(s)", n,
            .module = "compute-mrca/compute_mrca_map")
# Output: ... | WARNING  | [compute-mrca/compute_mrca_map] | Skipped 3 non-monophyletic group(s)
```

## Self-test

```r
# Run self-test from R
run_rclade_selftest()
```

```bash
# Run self-test from CLI
Rclade --check
```

Checks: dependencies, tree parsing, taxonomy extraction (Format A & B), monophyly logic, input validation, adversarial inputs.

## Performance

| Tips | Groups | Time | Status |
|------|--------|------|--------|
| 50 | 10 | 0.5s | Pass |
| 500 | 50 | 0.3s | Pass (benchmark) |
| 1,000 | 100 | 1.9s | Pass |
| 5,000 | 200 | 38.7s | Slow |
| 10,000+ | - | - | Warning: high memory expected |

## Dependencies

**Required**: ape (>= 5.0, GPL-2+), ggtree (>= 4.0.0, Artistic-2.0), deeptime (>= 1.0, GPL-3), ggplot2 (>= 3.5.0, MIT), rlang (MIT), stringr (>= 1.5, MIT), tidytree (>= 0.4, Artistic-2.0)

**Optional**: treeio (Artistic-2.0, BEAST2/IQ-TREE support), phangorn (GPL-2+, nesting detection), viridisLite/RColorBrewer (color palettes), cowplot/patchwork (legend splitting), shiny (web UI), optparse (CLI), yaml (`--config` configuration file support)

For a complete list of third-party dependencies and their licenses, see [inst/THIRDPARTY](inst/THIRDPARTY).

## Citation

If you use Rclade in your research, please cite:

> Zeng Z (2026). Rclade: Automated Deep-Time Phylogenetic Tree Collapsing and Visualization. R package version 1.0.0.

Rclade builds on the ggtree and deeptime ecosystems. Please also cite these key dependencies:

> Yu G, Smith DK, Zhu H, Guan Y, Lam TT-Y (2017). ggtree: an R package for visualization and annotation of phylogenetic trees with their covariates and other associated data. Methods in Ecology and Evolution, 8(1), 28-36. doi:10.1111/2041-210X.12628

> Gearty W (2025). deeptime: an R package that facilitates highly customizable and reproducible visualizations of data over geological time intervals. Big Earth Data. doi:10.1080/20964471.2025.2537516

GitHub repository: https://github.com/zengzichao/Rclade  
Issue tracker: https://github.com/zengzichao/Rclade/issues

## Contributing

Contributions are welcome! Please submit via GitHub Issue or Pull Request:

```bash
git clone https://github.com/zengzichao/Rclade.git
```

See [CONTRIBUTING.EN.md](CONTRIBUTING.EN.md) for details.

## Contact & Maintainers

- **Author**: Zeng Zichao (zengzichao@sjtu.edu.cn)
- **Affiliation**: Shanghai Jiao Tong University
- **GitHub**: https://github.com/zengzichao/Rclade

## License

MIT

### Bundled Data Licenses

- **ICS geological timescale data** (`R/sysdata.rda`): based on the [ICS International Chronostratigraphic Chart 2023/02](https://stratigraphy.org/chart). Geological boundary ages are factual data.
