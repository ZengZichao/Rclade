# Read taxonomy information from a table file

Reads taxonomy information from a two-column table file where:

- Column 1: Tip labels (must match tree tip labels)

- Column 2: Taxonomy strings in GTDB format (e.g.,
  `d__Archaea;p__Thermoproteota;c__Korarchaeia`)

## Usage

``` r
read_taxonomy_file(file, sep = "auto", header = FALSE, table_sep = ";")
```

## Arguments

- file:

  Character. Path to the taxonomy table file.

- sep:

  Character. Column separator. `"auto"` auto-detects tab or comma.
  Default: `"auto"`.

- header:

  Logical. Whether the file has a header row. Default: `FALSE`.

- table_sep:

  Character. Separator between taxonomy ranks in the second column (the
  taxonomy string). Default: `";"`.

## Value

A data.frame with columns:

- label:

  Character. Tip labels from column 1.

- domain:

  Character. Domain (d\_\_).

- phylum:

  Character. Phylum (p\_\_).

- class:

  Character. Class (c\_\_).

- order:

  Character. Order (o\_\_).

- family:

  Character. Family (f\_\_).

- genus:

  Character. Genus (g\_\_).

- species:

  Character. Species (s\_\_).

Missing ranks are `NA`.

## Details

Supports tab-delimited or comma-delimited files. Missing ranks are
indicated by empty values after the rank prefix (e.g., `s__` for missing
species).
