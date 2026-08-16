# Step 2: Resolve taxonomy / collapsing mode

Determines whether we are in clade-specific, custom-groups, or
rank-based mode and parses the taxonomy accordingly.

## Usage

``` r
pt_step2_resolve_taxonomy(
  tree,
  clade,
  strict,
  groups,
  rank,
  taxonomy_format,
  custom_patterns,
  taxonomy_file,
  taxonomy_file_sep,
  taxonomy_file_header,
  taxonomy_file_priority,
  taxonomy_table_sep,
  taxonomy_delimiter_mode,
  taxonomy_levels,
  low_memory
)
```

## Value

A named list with:

- group_vec:

  named vector mapping tip labels to groups

- detected_format:

  resolved taxonomy format string
