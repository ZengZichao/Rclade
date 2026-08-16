# Highlight monophyletic clades on a tree plot

Adds colored highlighting for specified taxonomic groups. Only
monophyletic groups are highlighted; non-monophyletic groups trigger a
warning. Supports special identifiers LUCA, LACA, LBCA for ancestral
nodes.

## Usage

``` r
highlight_clades(
  p,
  tree,
  groups,
  rank,
  format = "auto",
  colors = NULL,
  alpha = 0.2,
  custom_patterns = NULL,
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

## Arguments

- p:

  A `ggplot` object (from
  [`plot_timetree()`](https://zengzichao.github.io/Rclade/reference/plot_timetree.md)).

- tree:

  A `phylo` object.

- groups:

  Character vector of group names to highlight. Can include special
  identifiers: `"LUCA"`, `"LACA"`, `"LBCA"`.

- rank:

  Character. Taxonomic rank of the groups (ignored for special
  identifiers).

- format:

  Character. Taxonomy label format. Default: `"auto"`.

- colors:

  Named character vector of colors for each group. If `NULL`, colors are
  auto-generated.

- alpha:

  Numeric. Transparency of the highlight. Default: `0.2`.

- custom_patterns:

  Named list of regex patterns for custom format.

- taxonomy_levels:

  Custom taxonomy level configuration (list with codes and names).
  Default: `NULL`.

## Value

A `ggplot` object with highlights added.
