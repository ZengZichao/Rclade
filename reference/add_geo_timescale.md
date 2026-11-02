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
  tree_start_position = "right",
  right_pad = 0
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

- right_pad:

  Numeric. Fraction of the time span to reserve on the right of the
  panel (0 = none). Used so clade/tip labels drawn beyond the tips are
  not clipped. Default: `0`.

## Value

ggplot object
