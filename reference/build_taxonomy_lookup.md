# Build taxonomy lookup from file

Creates a lookup table from a taxonomy file that can be used to
supplement or override label-based taxonomy parsing.

## Usage

``` r
build_taxonomy_lookup(file, sep = "auto", header = FALSE, table_sep = ";")
```

## Arguments

- file:

  Character. Path to the taxonomy table file.

- sep:

  Character. Column separator. Default: `"auto"`.

- header:

  Logical. Whether the file has a header row. Default: `FALSE`.

- table_sep:

  Character. Separator between taxonomy ranks in the second column.
  Default: `";"`.

## Value

A named list where names are tip labels and values are data.frame rows
with taxonomy information.
