# Summarize taxonomy quality with external file support

Extended version of
[`summarize_taxonomy_quality()`](https://zengzichao.github.io/Rclade/reference/summarize_taxonomy_quality.md)
that can use an external taxonomy file.

## Usage

``` r
summarize_taxonomy_quality_with_file(
  labels,
  format = "auto",
  custom_patterns = NULL,
  taxonomy_file = NULL,
  file_sep = "auto",
  file_header = FALSE,
  file_priority = TRUE,
  table_sep = ";",
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

## Arguments

- labels:

  Character vector of tip labels.

- format:

  Format: "auto", "GTDB", "Silva", "NCBI", "custom_rank",
  "custom_regex".

- custom_patterns:

  Custom regex patterns (for "custom_regex" format).

- taxonomy_file:

  Character. Path to external taxonomy file. Default: `NULL`.

- file_sep:

  Character. Column separator for taxonomy file. Default: `"auto"`.

- file_header:

  Logical. Whether taxonomy file has header row. Default: `FALSE`.

- file_priority:

  Logical. If `TRUE`, file taxonomy takes priority. Default: `TRUE`.

- table_sep:

  Character. Separator between taxonomy ranks in the second column of
  the taxonomy file. Default: `";"`.

- delimiter_mode:

  Character. Embedded parsing strategy: "reverse", "greedy", "segment".

- taxonomy_levels:

  Custom taxonomy level configuration (list with codes and names).
  Default: `NULL`.

## Value

Invisibly returns a list with parsing statistics.
