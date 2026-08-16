# Parse NCBI format labels

Parse NCBI format labels

## Usage

``` r
parse_ncbi(labels, quiet = FALSE)
```

## Arguments

- labels:

  Character vector of tip labels

- quiet:

  Logical. If TRUE, suppress the positional mapping warning.

## Value

data.frame with columns: domain, phylum, class, order, family, genus,
species
