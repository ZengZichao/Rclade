# Step 1: Prepare and validate inputs

Reads tree from file (if path), validates structure, converts units,
checks for large trees, and handles cladogram mode.

## Usage

``` r
pt_step1_prepare_inputs(
  tree,
  tree_index,
  multi_tree_mode,
  rank,
  unit,
  layout,
  triangle_mode,
  space_mode,
  add_timescale,
  groups,
  clade,
  overwrite,
  ignore_branch_length,
  low_memory
)
```

## Value

A named list with:

- tree:

  validated phylo object

- unit:

  resolved time unit

- branch_length_mode:

  "branch.length" or "none"

- add_timescale:

  possibly modified
