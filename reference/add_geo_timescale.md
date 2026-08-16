# Add geological timescale to a tree plot

Add geological timescale to a tree plot

## Usage

``` r
add_geo_timescale(
  p,
  tree,
  levels,
  layout,
  version = "ICS 2023/02",
  actual_ntips = NULL,
  timescale_mode = "radial",
  timescale_position = "right",
  angle = 360,
  tree_start_position = "right"
)
```

## Arguments

- p:

  ggplot object

- tree:

  phylo object (edge lengths in Ma)

- levels:

  Timescale levels vector, e.g., c("eras", "eons")

- layout:

  Layout type

- version:

  Geological timescale version. Default: "ICS 2023/02".

## Value

ggplot object
