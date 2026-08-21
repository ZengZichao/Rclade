# Tree & Sequence I/O and Validation

Read tree files, validate sequence files, and check monophyly.

This module contains the following functions:

- [`read_tree_auto`](#read_tree_auto) — Read tree from file with automatic format detection
- [`validate_sequence_file`](#validate_sequence_file) — Validate sequence file format
- [`validate_sequence_deep`](#validate_sequence_deep) — Deep validation of sequence files
- [`validate_tree_sequence_match`](#validate_tree_sequence_match) — Cross-validate tree tip labels against sequence IDs
- [`check_monophyly`](#check_monophyly) — Check if a taxonomic group is monophyletic
- [`check_special_monophyly`](#check_special_monophyly) — Check if a special identifier corresponds to a monophyletic group

## `read_tree_auto`

Intended for use as a stable library API by external workflows
(e.g., Snakemake/Nextflow).

> **Label length guard**: Newick labels longer than 500 characters are truncated to 400 characters + a `_RCLADE_TRUNC` suffix (with a warning) before parsing, because ape's Newick parser aborts the whole R process on labels longer than ~512 characters on Linux. Truncated labels may no longer match external taxonomy files or sequence IDs exactly; shorten labels upstream if needed.

**Usage:**

```r
read_tree_auto(filepath, tree_index = NULL, multi_tree_mode = "error")
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `filepath` | Path to tree file (.tre, .nwk, .newick, .nexus, .nex, .treefile, .xml) |
| `tree_index` | Integer. Index of tree to use from multiPhylo objects (e.g., BEAST posterior). Default: NULL (will use multi_tree_mode to determine behavior). |
| `multi_tree_mode` | Character. How to handle multiple trees in a file. Options:  - `"error"` (default): Stop with error and ask user to specify - `"ask"`: Interactively prompt the user to choose a tree or handling mode. Falls back to `"error"` in non-interactive sessions. - `"first"`: Use the first tree - `"last"`: Use the last tree - `"random"`: Use a randomly selected tree - `"all"`: Return all trees (as multiPhylo) - `"split"`: Return all trees (as multiPhylo); callers write per-tree outputs with numeric suffixes (e.g. `output_1.pdf`) |

**Value:**

phylo object (or multiPhylo if multi_tree_mode = "all" or "split")

**Examples:**

```r
tree <- read_tree_auto("my_tree.nwk")
```


---

## `validate_sequence_file`

Validate sequence file format

**Usage:**

```r
validate_sequence_file(filepath)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `filepath` | Character. Path to sequence file. |

**Value:**

Character. Detected format: "fasta", "fastq", "unknown".

**Examples:**

```r
format <- validate_sequence_file("sequences.fasta")
```


---

## `validate_sequence_deep`

Validates FASTA/FASTQ files: format detection, duplicate IDs,
alphabet detection, and alignment length consistency.

**Usage:**

```r
validate_sequence_deep(
  filepath,
  expected_alphabet = NULL,
  check_alignment = FALSE
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `filepath` | Character. Path to sequence file. |
| `expected_alphabet` | Character or NULL. Expected alphabet: "DNA", "RNA", "protein", or NULL for auto-detect. |
| `check_alignment` | Logical. If TRUE, check all sequences have equal length. |

**Value:**

List with validation results.

**Examples:**

```r
result <- validate_sequence_deep("sequences.fasta", expected_alphabet = "DNA")
```


---

## `validate_tree_sequence_match`

Checks that all tree tips have corresponding sequences and vice versa.

**Usage:**

```r
validate_tree_sequence_match(
  tree,
  sequence_file,
  quiet = FALSE,
  mol_type = NULL,
  skip_length_check = FALSE,
  multi_tree_mode = "error"
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `tree` | phylo object or path to tree file. |
| `sequence_file` | Character. Path to sequence file (FASTA/FASTQ). |
| `quiet` | Logical. If TRUE, suppress messages. |
| `mol_type` | Character. Molecule type for sequence validation: "DNA", "RNA", "protein", or "auto" (NULL). Default: `NULL`. |
| `skip_length_check` | Logical. If TRUE, skip alignment length consistency check. Default: `FALSE`. |
| `multi_tree_mode` | Character. How to handle multiple trees in a file when `tree` is a path. Default: `"error"`. |

**Value:**

List with match status and differences.

**Examples:**

```r
result <- validate_tree_sequence_match("tree.nwk", "sequences.fasta")
```


---

## `check_monophyly`

Tests whether all tips belonging to a specified taxonomic group form a
monophyletic clade in the tree.

**Usage:**

```r
check_monophyly(
  tree,
  group,
  rank,
  format = "auto",
  custom_patterns = NULL,
  quiet = FALSE,
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `tree` | A `phylo` object. |
| `group` | Character. The name of the taxonomic group to check (e.g., `"P1"`, `"Mammalia"`). |
| `rank` | Character. Taxonomic rank of the group. One of `"domain"`, `"phylum"`, `"class"`, `"order"`, `"family"`, `"genus"`, `"species"`, or abbreviations `"d"`, `"p"`, `"c"`, `"o"`, `"f"`, `"g"`, `"s"`. |
| `format` | Character. Taxonomy label format. One of `"auto"`, `"GTDB"`, `"Silva"`, `"NCBI"`, `"custom_rank"`, `"custom_regex"`. Default: `"auto"`. |
| `custom_patterns` | Named list of regex patterns for custom format. Required when `format = "custom_regex"`. |
| `quiet` | Logical. If `TRUE`, suppress informational messages. Default: `FALSE`. |
| `delimiter_mode` | Character. Embedded (Format A) parsing strategy: `"reverse"` (right-to-left, default), `"greedy"` (left-to-right), or `"segment"` (delimiter-to-delimiter extraction). |
| `taxonomy_levels` | Custom taxonomy level configuration (list with codes and names). Default: `NULL`. |

**Value:**

A list with components:

**is_monophyletic**: Logical. Whether the group is monophyletic.
**group**: Character. The group name.
**n_tips**: Integer. Number of tips belonging to the group.
**mrca_node**: Integer or NULL. The MRCA node number, or NULL if
the group has fewer than 2 tips.
**outsiders**: Character vector. Tips in the MRCA clade that do not
belong to the group (empty if monophyletic).

**Examples:**

```r
data(example_tree)

# Check if phylum P1 is monophyletic
result <- check_monophyly(example_tree, "P1",
                           rank = "phylum", format = "GTDB")
if (result$is_monophyletic) {
  cat("P1 is monophyletic!\n")
} else {
  cat("P1 is NOT monophyletic.\n")
```


---

## `check_special_monophyly`

Tests whether the MRCA of the specified domains (identified by LUCA/LACA/LBCA)
contains only tips from those domains (i.e., is monophyletic with respect to
the target domains).

**Usage:**

```r
check_special_monophyly(
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
| `identifier` | Character. One of `"LUCA"`, `"LACA"`, `"LBCA"`. |
| `format` | Character. Taxonomy label format. Default: `"auto"`. |
| `quiet` | Logical. If TRUE, suppress informational messages. Default: FALSE. |
| `delimiter_mode` | Character. Embedded parsing strategy: `"reverse"`, `"greedy"`, or `"segment"`. Default: `"reverse"`. |
| `taxonomy_levels` | Custom taxonomy level configuration (list with codes and names). Default: `NULL`. |

**Value:**

A list with components:

**is_monophyletic**: Logical. Whether the group is monophyletic.
**identifier**: Character. The identifier name.
**node**: Integer or NULL. The MRCA node number.
**n_tips**: Integer. Number of tips in the target domains.
**n_outsiders**: Integer. Number of outsider tips in the MRCA clade.
**outsider_domains**: Character vector. Domains of outsider tips.

**Examples:**

```r
data(example_tree)
result <- check_special_monophyly(example_tree, "LBCA")
if (result$is_monophyletic) {
  cat("LBCA is monophyletic!\n")
```


---


---

[中文](../../cn/reference/tree-sequence.md) | [文档首页](../../index.md)
