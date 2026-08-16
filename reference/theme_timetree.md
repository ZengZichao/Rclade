# Publication-ready theme for timetree plots

Based on ggtree::theme_tree2(), customized for publication quality.
Includes `coord_cartesian(clip = "off")` to prevent collapsed clade
triangles from being clipped at the plot panel boundary — triangle
vertices (especially the MRCA node apex) often extend beyond the
tip-based y-axis range.

## Usage

``` r
theme_timetree(base_size = 12)
```

## Arguments

- base_size:

  Base font size

## Value

A `list` with components `theme` (ggplot2 theme) and `coord`
(`coord_cartesian(clip = "off")`). Callers should apply both via
`p + result$theme + result$coord`.
