# Find circular dependencies between two rank columns

Find circular dependencies between two rank columns

## Usage

``` r
find_rank_cycles(taxa_df, rank_high, rank_low)
```

## Arguments

- taxa_df:

  data.frame with taxonomy columns.

- rank_high:

  Character. Higher rank column name.

- rank_low:

  Character. Lower rank column name.

## Value

Character vector of cycle descriptions (empty if none).
