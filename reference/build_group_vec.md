# Build a group vector from custom groups

Converts a named list of tip vectors into the named-vector format used
by
[`compute_mrca_map()`](https://zengzichao.github.io/Rclade/reference/compute_mrca_map.md).

## Usage

``` r
build_group_vec(groups, tip_labels)
```

## Arguments

- groups:

  Named list of character vectors (tip labels per group).

- tip_labels:

  Character vector of all tip labels in the tree.

## Value

Named character vector: names = tip labels, values = group names, `NA`
for ungrouped tips.
