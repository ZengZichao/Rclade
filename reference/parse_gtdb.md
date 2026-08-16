# Parse GTDB format labels (wrapper for parse_semicolon_delimited)

Parse GTDB format labels (wrapper for parse_semicolon_delimited)

## Usage

``` r
parse_gtdb(labels, levels = NULL, sep = ";")
```

## Arguments

- labels:

  Character vector of tip labels

- levels:

  List with codes and names vectors.

- sep:

  Character. Separator between taxonomy ranks. Default: `";"`.

## Value

data.frame with taxonomy columns
