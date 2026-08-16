# Add HPD (Highest Posterior Density) range to a tree plot

Uses
[`ggtree::geom_range()`](https://rdrr.io/pkg/ggtree/man/geom_range.html)
to display horizontal uncertainty bars on internal nodes. Requires a
`node.data` data frame attached to the tree with a HPD column (list
column of c(lower, upper) vectors).

## Usage

``` r
add_hpd_range(p, tree, color = "firebrick")
```

## Arguments

- p:

  ggplot object

- tree:

  phylo object (with node.data containing HPD annotations)

- color:

  Color for HPD bars. Default: "firebrick".

## Value

ggplot object
