# Build a full-rank taxonomy data.frame in a single pass (M-D4 helper)

Used by clade-specific collapsing to avoid re-parsing every rank (and
re-reading any taxonomy file) once per search rank. Produces one
label-based full parse (format-specific parsers already compute all
ranks at once) supplemented/overridden by a single taxonomy-file read
when `taxonomy_file` is supplied.

## Usage

``` r
build_full_taxa_df(
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
  "custom_regex", "embedded".

- custom_patterns:

  Custom regex patterns (for "custom_regex" format).

- taxonomy_file:

  Character. Path to external taxonomy file. Default: NULL.

- file_sep:

  Character. Column separator for taxonomy file. Default: "auto".

- file_header:

  Logical. Whether taxonomy file has header row. Default: FALSE.

- file_priority:

  Logical. If TRUE, file taxonomy takes priority over label-based
  parsing. Default: TRUE.

- table_sep:

  Character. Separator between taxonomy ranks. Default: ";".

- delimiter_mode:

  Character. Embedded parsing strategy.

- taxonomy_levels:

  Custom taxonomy level configuration. Default: NULL.

## Value

data.frame with a `label` column plus one column per rank.
