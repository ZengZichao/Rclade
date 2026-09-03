# Resolve group name or special identifier to MRCA node

Unified function that handles both regular group names and special
identifiers (LUCA, LACA, LBCA).

## Usage

``` r
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

## Arguments

- tree:

  A `phylo` object.

- group:

  Character. Group name or special identifier.

- rank:

  Character. Taxonomic rank (ignored for special identifiers).

- format:

  Character. Taxonomy label format. Default: `"auto"`.

- quiet:

  Logical. If TRUE, suppress messages. Default: FALSE.

- delimiter_mode:

  Character. Embedded parsing strategy: `"reverse"`, `"greedy"`, or
  `"segment"`. Default: `"reverse"`.

- custom_patterns:

  Named list of regex patterns for custom format. Required when
  `format = "custom_regex"`.

- taxonomy_levels:

  Custom taxonomy level configuration (list with codes and names).
  Default: `NULL`.

## Value

A list with components:

- is_monophyletic:

  Logical. Whether the group is monophyletic.

- group:

  Character. The group name or identifier.

- is_special:

  Logical. Whether this is a special identifier.

- node:

  Integer or NULL. The MRCA node number.

- n_tips:

  Integer. Number of tips in the group.

- outsiders:

  Character vector. Tips in MRCA not belonging to group.
