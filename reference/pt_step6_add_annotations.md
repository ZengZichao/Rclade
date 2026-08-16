# Step 6: Add annotations (tip labels, timescale, support, HPD, clade labels, highlight)

Step 6: Add annotations (tip labels, timescale, support, HPD, clade
labels, highlight)

## Usage

``` r
pt_step6_add_annotations(
  p,
  tree,
  layout,
  add_timescale,
  timescale_levels,
  actual_ntips,
  timescale_version,
  show_tip_labels,
  tip_label_size,
  show_support,
  support_threshold,
  show_hpd,
  hpd_color,
  geo_events,
  show_clade_label,
  show_clade_count,
  clade_label_offset,
  clade_label_fontsize,
  mrca_map,
  singleton_map,
  highlight,
  highlight_alpha,
  rank,
  taxonomy_format,
  custom_patterns,
  taxonomy_delimiter_mode,
  taxonomy_levels,
  ignore_branch_length,
  colors,
  timescale_mode = "radial",
  timescale_position = "right",
  angle = 360,
  tree_start_position = "right"
)
```

## Value

Updated ggplot object.
