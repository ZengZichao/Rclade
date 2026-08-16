# Apply coordinate-system clip="off" (the only clip application point)

Collapsed-triangle vertices (especially the MRCA apex) often extend
beyond the tip-based y-axis range, so the plot panel must NOT clip them.
This helper is the single, sanctioned place to add `clip = "off"`:

- rectangular -\> `coord_cartesian(clip = "off")`

- circular/fan -\> `coord_polar(theta = "y", clip = "off")`

## Usage

``` r
add_clip_off(p, layout = "rectangular")
```

## Arguments

- p:

  A ggplot object.

- layout:

  "rectangular" or "circular".

## Value

The ggplot object with the appropriate clip-off coordinate added.

## Details

A `utils::packageVersion("ggplot2")` guard protects against ggplot2 \<
3.5.0 (which does not support `clip = "off"`): in that case we
`log_warning` and skip clip rather than silently mis-rendering.
