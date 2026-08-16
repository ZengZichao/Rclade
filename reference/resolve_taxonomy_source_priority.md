# Resolve taxonomy source priority (embedded vs table)

Unifies the `no_taxonomy_file_priority` flag (CLI) and the explicit
`taxonomy_source_priority` value (CLI / Shiny) into a single canonical
`"embedded"` / `"table"` string. Replaces the inline `if` previously
duplicated in `cli.R` and
[`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md).

## Usage

``` r
resolve_taxonomy_source_priority(
  no_taxonomy_file_priority = FALSE,
  taxonomy_source_priority = "table"
)
```

## Arguments

- no_taxonomy_file_priority:

  Logical. When `TRUE`, file taxonomy is only used as a fallback
  (embedded takes priority).

- taxonomy_source_priority:

  Character "embedded" or "table". Ignored when
  `no_taxonomy_file_priority` is `TRUE`.

## Value

Character: `"embedded"` or `"table"`.
