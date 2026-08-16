# Construct a validated options list for `plot_timetree()`

`rclade_options()` returns a named list of commonly used rendering
parameters that can be passed to `plot_timetree(opts = ...)` as a single
object. Explicit arguments supplied directly to
[`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md)
always take precedence over values in `opts`.

## Usage

``` r
rclade_options(
  rank = "none",
  layout = "rectangular",
  color_palette = "viridis",
  taxonomy_format = "auto",
  add_timescale = TRUE,
  timescale_mode = "radial",
  unit = NULL,
  legend_position = "bottom",
  line_width = 1,
  show_tip_labels = FALSE,
  width = 14,
  height = 10,
  ...
)
```

## Arguments

- rank:

  Character. Collapsing rank (e.g. "phylum", "class", "none").

- layout:

  Character. "rectangular" or "circular".

- color_palette:

  Character. Palette name (e.g. "viridis", "plasma", "Set1").

- taxonomy_format:

  Character. One of "auto", "GTDB", "Silva", "NCBI", "embedded",
  "custom_regex".

- add_timescale:

  Logical. Whether to add a geological timescale.

- timescale_mode:

  Character. "radial", "linear", "none".

- unit:

  Character or NULL. "Ma", "Ga", or NULL (auto / native units).

- legend_position:

  Character. Legend placement (e.g. "bottom", "right", "none").

- line_width:

  Numeric. Branch line width.

- show_tip_labels:

  Logical. Whether to display tip labels.

- width:

  Numeric. Output width in inches.

- height:

  Numeric. Output height in inches.

- ...:

  Additional named parameters to include in the options list. These are
  passed through without validation.

## Value

A named list of class `"rclade_options"` suitable for the `opts`
argument of
[`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md).

## Details

This constructor is the first step toward parameter-surface convergence:
it provides a single validated source of truth for parameter defaults,
reducing the risk of drift between the
[`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md)
signature, internal forwarding lists, and documentation.

## Examples

``` r
# Create a reusable options object
opts <- rclade_options(rank = "phylum", layout = "circular",
                       color_palette = "plasma", add_timescale = TRUE)

# Use with plot_timetree (explicit args override opts)
if (FALSE) { # \dontrun{
plot_timetree(tree, opts = opts)
plot_timetree(tree, opts = opts, layout = "rectangular")  # overrides layout
} # }
```
