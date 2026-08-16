# Compute MRCA node mapping for each taxonomic group

Compute MRCA node mapping for each taxonomic group

## Usage

``` r
compute_mrca_map(tree, group_vec, check_monophyly = TRUE, strict = FALSE)
```

## Arguments

- tree:

  phylo object

- group_vec:

  Named vector (names = tip labels, values = group names, NA =
  ungrouped)

- check_monophyly:

  Logical. If TRUE (default), check if each group is monophyletic before
  adding to collapse plan. Non-monophyletic groups will be skipped with
  a warning.

- strict:

  Logical. If TRUE, non-monophyletic groups cause an error instead of a
  warning. Default: FALSE.

## Value

Named list: each element is list(node = integer, tip_count = integer)
