# Step 5: Render base tree and collapse clades

Builds the ggplot tree, binds taxonomy data, collapses clades, handles
circular layout rescaling, and colors collapse branches.

## Usage

``` r
pt_step5_render_and_collapse(
  tree,
  group_vec,
  mrca_map,
  colors,
  layout,
  angle,
  line_width,
  branch_length_mode,
  triangle_mode,
  space_mode,
  low_memory,
  color_group_vec = NULL
)
```

## Value

A named list with:

- p:

  ggplot object

- actual_ntips:

  displayed tip count after collapse (or NULL)
