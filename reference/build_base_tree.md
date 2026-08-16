# Create base tree plot based on layout type

Create base tree plot based on layout type

## Usage

``` r
build_base_tree(
  tree,
  layout,
  angle,
  line_width,
  branch.length = "branch.length"
)
```

## Arguments

- tree:

  phylo object

- layout:

  Layout type: "rectangular" or "circular"

- angle:

  Fan angle for circular layout

- line_width:

  Branch line width

- branch.length:

  Branch length mode passed to ggtree. Use "none" to draw a cladogram
  where all tips are aligned (ignoring original branch lengths).
  Default: "branch.length" (use original edge lengths).

## Value

ggplot object
