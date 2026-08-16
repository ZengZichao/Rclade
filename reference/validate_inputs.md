# Validate and preprocess tree input

Checks tree object validity, converts treedata to phylo, validates
parameters, and performs unit sanity checks.

## Usage

``` r
validate_inputs(
  tree,
  rank,
  unit,
  layout,
  triangle_mode,
  space_mode,
  add_timescale = TRUE,
  groups = NULL,
  clade = NULL,
  overwrite = "ask"
)
```

## Arguments

- tree:

  phylo or treedata object

- rank:

  Taxonomic rank

- unit:

  Time unit

- layout:

  Layout type

- triangle_mode:

  Triangle mode

- space_mode:

  Space mode

## Value

Validated phylo object (with node.data attribute if treedata input)
