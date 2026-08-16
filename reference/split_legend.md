# Extract legend as separate grob and combine with patchwork

Extract legend as separate grob and combine with patchwork

## Usage

``` r
split_legend(p, ncol_split = 2)
```

## Arguments

- p:

  ggplot object

- ncol_split:

  Number of columns for legend splitting (used for reflow)

## Value

patchwork object. Note: This returns a patchwork object, not a ggplot
object. You cannot add ggplot2 layers with `+` after calling
`split_legend()`. Use patchwork operators like `|` and `/` for layout
composition.
