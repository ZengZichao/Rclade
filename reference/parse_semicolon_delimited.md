# Parse Format B: Semicolon-delimited taxonomy (GTDB-style)

Parses labels like
`d__Bacteria;p__Cyanobacteriota;c__Cyanobacteriia;...` where empty
values like `s__` are parsed as NA.

## Usage

``` r
parse_semicolon_delimited(labels, levels = NULL, sep = ";")
```

## Arguments

- labels:

  Character vector of tip labels

- levels:

  List with codes and names vectors for taxonomy levels.

- sep:

  Character. Separator between taxonomy ranks. Default: `";"`.

## Value

data.frame with taxonomy columns
