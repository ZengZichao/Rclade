# Validate user-defined custom groups for tree collapsing

Checks that every group is monophyletic and that tips do not overlap
between groups.

## Usage

``` r
validate_custom_groups(tree, groups)
```

## Arguments

- tree:

  A `phylo` object.

- groups:

  A named `list` where each element is a character vector of tip labels
  belonging to that group.

## Value

Invisibly returns `TRUE` if all checks pass. Otherwise stops with an
informative error.
