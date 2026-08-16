# Parse raw UI / CLI strings into structured plot parameters

This is the ONLY place that converts raw UI strings (comma-separated
highlight lists, "A:#FF0000,B:#00FF00" color mappings, "k:*k*,ss:*ss*"
taxonomy level specs, "auto"/"tab"/"comma" separators) into the
structured R objects expected by
[`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md).

## Usage

``` r
parse_plot_params(
  color_mapping = NULL,
  taxonomy_levels = NULL,
  highlight = NULL,
  taxonomy_file_sep = "auto"
)
```

## Arguments

- color_mapping:

  Character string "GroupA:#FF0000,GroupB:#00FF00", or an
  already-structured named vector/list. A single bare hex ("#FF0000") is
  returned as a length-1 color vector (M-E2 / L-D7). `NULL` -\> `NULL`.

- taxonomy_levels:

  Character string "k:*k*,ss:*ss*", or a pre-built
  `list(codes=, names=)`. `NULL` -\> `NULL`.

- highlight:

  Character string "LUCA, LACA", or a character vector. `NULL` -\>
  `NULL`.

- taxonomy_file_sep:

  One of "auto", "tab", "comma", or an already-resolved separator (a
  literal tab, ",", or "auto").

## Value

A named list with components:

- color_mapping:

  named character vector or `NULL`

- taxonomy_levels:

  list(codes, names) or `NULL`

- highlight:

  character vector or `NULL`

- taxonomy_file_sep:

  character scalar

## Details

Both the CLI (`build_plot_timetree_params`) and the Shiny `server()`
must route their raw inputs through this function so that parsing logic
lives in exactly one location.
