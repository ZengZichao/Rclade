# Single-tree plotting pipeline

Orchestrates all pipeline steps for a single phylo object. This is the
internal counterpart to
[`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md)
that handles one tree after batch / file-path resolution has already
occurred.

## Usage

``` r
pt_single_tree(
  tree,
  rank,
  clade,
  strict,
  groups,
  triangle_mode,
  space_mode,
  layout,
  angle,
  color_palette,
  color_mapping,
  line_width,
  show_tip_labels,
  tip_label_size,
  add_timescale,
  timescale_levels,
  unit,
  taxonomy_format,
  custom_patterns,
  taxonomy_file,
  taxonomy_file_sep,
  taxonomy_file_header,
  taxonomy_file_priority,
  taxonomy_source_priority,
  taxonomy_table_sep,
  taxonomy_delimiter_mode,
  legend_position,
  legend_nrow,
  legend_ncol,
  legend_title,
  show_clade_label,
  show_clade_count,
  clade_label_offset,
  clade_label_fontsize,
  show_support,
  support_threshold,
  show_hpd,
  hpd_color,
  geo_events,
  timescale_version,
  main_title,
  sub_title,
  highlight,
  highlight_alpha,
  theme_fun,
  output,
  overwrite,
  width,
  height,
  taxonomy_levels,
  low_memory,
  ignore_malformed,
  ignore_branch_length,
  color_rank = NULL,
  timescale_mode = "radial",
  timescale_position = "right",
  tree_start_position = "right"
)
```

## Value

A ggplot object with `rclade_info` attribute.
