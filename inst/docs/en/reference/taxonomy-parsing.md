# Taxonomy Parsing

Detect formats, parse taxonomic labels, resolve groups to MRCAs, and validate custom groups.

This module contains the following functions:

- [`detect_taxonomy_format`](#detect_taxonomy_format) — Detect taxonomy format from tip labels
- [`parse_taxonomy`](#parse_taxonomy) — Unified taxonomy parsing entry point
- [`resolve_group`](#resolve_group) — Resolve group name or special identifier to MRCA node
- [`resolve_special_identifier`](#resolve_special_identifier) — Resolve special ancestral node identifiers
- [`build_group_vec`](#build_group_vec) — Build a group vector from custom groups
- [`validate_custom_groups`](#validate_custom_groups) — Validate user-defined custom groups for tree collapsing
- [`summarize_taxonomy_quality`](#summarize_taxonomy_quality) — Report taxonomy label parsing quality
- [`summarize_taxonomy_quality_with_file`](#summarize_taxonomy_quality_with_file) — Summarize taxonomy quality with external file support
- [`read_taxonomy_file`](#read_taxonomy_file) — Read taxonomy information from a table file
- [`validate_taxonomy_no_cycles`](#validate_taxonomy_no_cycles) — Detect circular dependencies in taxonomy table

## `detect_taxonomy_format`

Detects Format A (embedded: `_d_Bacteria_p_...`) or
Format B (semicolon-delimited: `d__Bacteria;p__...`).

**Usage:**

```r
detect_taxonomy_format(labels)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `labels` | Character vector of tip labels |

**Value:**

Format name: "embedded", "GTDB", "Silva", "NCBI", or "unknown"

**Examples:**

```r
labels <- c("d__Bacteria;p__Firmicutes",
              "d__Bacteria;p__Proteobacteria")
detect_taxonomy_format(labels)
```


---

## `parse_taxonomy`

Parses taxonomic information from tip labels using the specified format and
returns a data.frame of group assignments. Intended for use as a stable
library API by external workflows (e.g., Snakemake/Nextflow).

**Usage:**

```r
parse_taxonomy(
  labels,
  rank,
  format = "auto",
  custom_patterns = NULL,
  taxonomy_levels = NULL,
  delimiter_mode = "reverse"
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `labels` | Character vector of tip labels |
| `rank` | Taxonomic rank (abbreviation or full name) |
| `format` | Format: "auto", "embedded", "GTDB", "Silva", "NCBI", "custom_rank", "custom_regex" |
| `custom_patterns` | Custom regex patterns (required when format = "custom_regex") |
| `taxonomy_levels` | Custom taxonomy level configuration (list with codes and names) |
| `delimiter_mode` | Character. Embedded parsing strategy: "reverse", "greedy", "segment". |

**Value:**

data.frame with columns: label, Group

**Examples:**

```r
labels <- c("d__Bacteria;p__Firmicutes;c__Bacilli",
              "d__Bacteria;p__Proteobacteria")
parse_taxonomy(labels, rank = "phylum", format = "GTDB")
```


---

## `resolve_group`

Unified function that handles both regular group names and special identifiers
(LUCA, LACA, LBCA).

**Usage:**

```r
resolve_group(
  tree,
  group,
  rank = "domain",
  format = "auto",
  quiet = FALSE,
  delimiter_mode = "reverse",
  custom_patterns = NULL,
  taxonomy_levels = NULL
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `tree` | A `phylo` object. |
| `group` | Character. Group name or special identifier. |
| `rank` | Character. Taxonomic rank (ignored for special identifiers). |
| `format` | Character. Taxonomy label format. Default: `"auto"`. |
| `quiet` | Logical. If TRUE, suppress messages. Default: FALSE. |
| `delimiter_mode` | Character. Embedded parsing strategy: `"reverse"`, `"greedy"`, or `"segment"`. Default: `"reverse"`. |
| `custom_patterns` | Named list of regex patterns for custom format. Required when `format = "custom_regex"`. |
| `taxonomy_levels` | Custom taxonomy level configuration (list with codes and names). Default: `NULL`. |

**Value:**

A list with components:

**is_monophyletic**: Logical. Whether the group is monophyletic.
**group**: Character. The group name or identifier.
**is_special**: Logical. Whether this is a special identifier.
**node**: Integer or NULL. The MRCA node number.
**n_tips**: Integer. Number of tips in the group.
**outsiders**: Character vector. Tips in MRCA not belonging to group.

**Examples:**

```r
data(example_tree)

# Regular group
result1 <- resolve_group(example_tree, "P1", rank = "phylum")

# Special identifier
result2 <- resolve_group(example_tree, "LUCA")
```


---

## `resolve_special_identifier`

Handles special identifiers for key ancestral nodes in the tree of life:

- **LUCA**: Last Universal Common Ancestor - MRCA of all Bacteria and Archaea
- **LACA**: Last Archaeal Common Ancestor - MRCA of all Archaea
- **LBCA**: Last Bacterial Common Ancestor - MRCA of all Bacteria

**Usage:**

```r
resolve_special_identifier(
  tree,
  identifier,
  format = "auto",
  quiet = FALSE,
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `tree` | A `phylo` object. |
| `identifier` | Character. One of `"ROOT"`, `"LUCA"`, `"LACA"`, `"LBCA"`.  **ROOT**: Root of the tree **LUCA**: Last Universal Common Ancestor (MRCA of all Bacteria and Archaea) **LACA**: Last Archaeal Common Ancestor (MRCA of all Archaea) **LBCA**: Last Bacterial Common Ancestor (MRCA of all Bacteria) |
| `format` | Character. Taxonomy label format. Default: `"auto"`. |
| `quiet` | Logical. If TRUE, suppress informational messages. Default: FALSE. |
| `delimiter_mode` | Character. Embedded parsing strategy: `"reverse"`, `"greedy"`, or `"segment"`. Default: `"reverse"`. |
| `taxonomy_levels` | Custom taxonomy level configuration (list with codes and names). Default: `NULL`. |

**Value:**

A list with components:

**node**: Integer. The node number of the MRCA, or NULL if not found.
**identifier**: Character. The identifier name.
**description**: Character. Human-readable description.
**n_tips**: Integer. Number of descendant tips.
**tip_labels**: Character vector. Labels of descendant tips.

**Examples:**

```r
data(example_tree)
root <- resolve_special_identifier(example_tree, "ROOT")
luca <- resolve_special_identifier(example_tree, "LUCA")
if (!is.null(luca$node)) {
  cat("LUCA found at node", luca$node, "\n")
```


---

## `build_group_vec`

Converts a named list of tip vectors into the named-vector format used
by `compute_mrca_map()`.

**Usage:**

```r
build_group_vec(groups, tip_labels)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `groups` | Named list of character vectors (tip labels per group). |
| `tip_labels` | Character vector of all tip labels in the tree. |

**Value:**

Named character vector: names = tip labels, values = group names,
`NA` for ungrouped tips.

**Examples:**

```r
tips <- c("A", "B", "C", "D")
groups <- list(g1 = c("A", "B"), g2 = c("C", "D"))
build_group_vec(groups, tips)
```


---

## `validate_custom_groups`

Checks that every group is monophyletic and that tips do not overlap
between groups.

**Usage:**

```r
validate_custom_groups(tree, groups)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `tree` | A `phylo` object. |
| `groups` | A named `list` where each element is a character vector of tip labels belonging to that group. |

**Value:**

Invisibly returns `TRUE` if all checks pass. Otherwise stops
with an informative error.

**Examples:**

```r
data(example_tree)
validate_custom_groups(example_tree,
     list(Group1 = c("tip1", "tip2")))
```


---

## `summarize_taxonomy_quality`

Provides a detailed report on how well taxonomic labels can be parsed,
including per-rank parse rates and failed labels.

**Usage:**

```r
summarize_taxonomy_quality(
  labels,
  format = "auto",
  custom_patterns = NULL,
  taxonomy_levels = NULL,
  delimiter_mode = "reverse"
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `labels` | Character vector of tip labels |
| `format` | Format: "auto", "embedded", "GTDB", "Silva", "NCBI", "custom_rank", "custom_regex" |
| `custom_patterns` | Custom regex patterns (for "custom_regex" format) |
| `taxonomy_levels` | Custom taxonomy level configuration |
| `delimiter_mode` | Character. Embedded parsing strategy: "reverse", "greedy", "segment". |

**Value:**

Invisibly returns a list with parsing statistics

**Examples:**

```r
labels <- c("d__Bacteria;p__Firmicutes",
              "d__Archaea;p__Euryarchaeota")
summarize_taxonomy_quality(labels, format = "GTDB")
```


---

## `summarize_taxonomy_quality_with_file`

Extended version of `summarize_taxonomy_quality()` that can use an
external taxonomy file.

**Usage:**

```r
summarize_taxonomy_quality_with_file(
  labels,
  format = "auto",
  custom_patterns = NULL,
  taxonomy_file = NULL,
  file_sep = "auto",
  file_header = FALSE,
  file_priority = TRUE,
  table_sep = ";",
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `labels` | Character vector of tip labels. |
| `format` | Format: "auto", "GTDB", "Silva", "NCBI", "custom_rank", "custom_regex". |
| `custom_patterns` | Custom regex patterns (for "custom_regex" format). |
| `taxonomy_file` | Character. Path to external taxonomy file. Default: `NULL`. |
| `file_sep` | Character. Column separator for taxonomy file. Default: `"auto"`. |
| `file_header` | Logical. Whether taxonomy file has header row. Default: `FALSE`. |
| `file_priority` | Logical. If `TRUE`, file taxonomy takes priority. Default: `TRUE`. |
| `table_sep` | Character. Separator between taxonomy ranks in the second column of the taxonomy file. Default: `";"`. |
| `delimiter_mode` | Character. Embedded parsing strategy: "reverse", "greedy", "segment". |
| `taxonomy_levels` | Custom taxonomy level configuration (list with codes and names). Default: `NULL`. |

**Value:**

Invisibly returns a list with parsing statistics.

**Examples:**

```r
# Report quality with external file
summarize_taxonomy_quality_with_file(labels, format = "auto",
                                      taxonomy_file = "taxonomy.tsv")
```


---

## `read_taxonomy_file`

Reads taxonomy information from a two-column table file where:

- Column 1: Tip labels (must match tree tip labels)
- Column 2: Taxonomy strings in GTDB format
(e.g., `d__Archaea;p__Thermoproteota;c__Korarchaeia`)

**Usage:**

```r
read_taxonomy_file(file, sep = "auto", header = FALSE, table_sep = ";")
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `file` | Character. Path to the taxonomy table file. |
| `sep` | Character. Column separator. `"auto"` auto-detects tab or comma. Default: `"auto"`. |
| `header` | Logical. Whether the file has a header row. Default: `FALSE`. |
| `table_sep` | Character. Separator between taxonomy ranks in the second column (the taxonomy string). Default: `";"`. |

**Value:**

A data.frame with columns:

**label**: Character. Tip labels from column 1.
**domain**: Character. Domain (d__).
**phylum**: Character. Phylum (p__).
**class**: Character. Class (c__).
**order**: Character. Order (o__).
**family**: Character. Family (f__).
**genus**: Character. Genus (g__).
**species**: Character. Species (s__).

Missing ranks are `NA`.

**Examples:**

```r
# Read a tab-delimited taxonomy file
taxa <- read_taxonomy_file("taxonomy.tsv")

# Read a comma-delimited file with header
taxa <- read_taxonomy_file("taxonomy.csv", sep = ",", header = TRUE)
```


---

## `validate_taxonomy_no_cycles`

Checks for cases like:

- Row 1: d__A;p__B
- Row 2: d__B;p__A
where domain/phylum relationships form a cycle.

**Usage:**

```r
validate_taxonomy_no_cycles(taxa_df, filepath = "<taxonomy>")
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `taxa_df` | data.frame with taxonomy columns (domain, phylum, class, etc.). |
| `filepath` | Character. Source file for error messages. |

**Value:**

Invisibly returns TRUE if no cycles. Stops on detection.

**Examples:**

```r
taxa <- read_taxonomy_file("taxonomy.tsv")
validate_taxonomy_no_cycles(taxa, "taxonomy.tsv")
```


---


---

[中文](../../cn/reference/taxonomy-parsing.md) | [文档首页](../../index.md)
