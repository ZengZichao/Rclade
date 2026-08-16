# Batch plot timetrees from a directory of tree files

Batch plot timetrees from a directory of tree files

## Usage

``` r
batch_plot(
  input_dir,
  output_dir,
  pattern = "*.tre",
  format = "pdf",
  width = 14,
  height = 10,
  overwrite = "ask",
  ignore_malformed = FALSE,
  ...
)
```

## Arguments

- input_dir:

  Input directory containing tree files

- output_dir:

  Output directory for plots

- pattern:

  File matching pattern (glob format, e.g., "\*.tre")

- format:

  Output format: "pdf", "png", "tiff", "svg", "eps" (default "pdf")

- width:

  Output width in inches (default 14)

- height:

  Output height in inches (default 10)

- overwrite:

  Overwrite mode: "ask" (default), "force", or "no-clobber"

- ignore_malformed:

  Logical. If `TRUE`, malformed tree inputs are skipped (with a warning)
  instead of aborting the whole batch, aligned with the CLI's
  `--ignore_malformed` flag. Default: `FALSE`.

- ...:

  Additional arguments passed to plot_timetree()

## Value

Invisibly returns list of success/failure status
