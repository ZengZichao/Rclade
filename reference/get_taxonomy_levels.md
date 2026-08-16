# Get taxonomy level configuration

Returns the current taxonomy level mapping. Can be customized via
`--taxonomy-levels` option.

## Usage

``` r
get_taxonomy_levels(custom_levels = NULL)
```

## Arguments

- custom_levels:

  Named list or NULL. If NULL, uses defaults.

## Value

List with codes and names vectors.
