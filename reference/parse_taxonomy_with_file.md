# Parse taxonomy with external file support

Extended taxonomy parsing that can use an external taxonomy file to
supplement or override label-based parsing. Useful when:

- Tip labels lack taxonomy information

- Only some tips have taxonomy in their labels

- External taxonomy data is more complete or accurate

## Usage

``` r
parse_taxonomy_with_file(
  labels,
  rank,
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

- rank:

  Taxonomic rank (abbreviation or full name).

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

  Logical. If `TRUE`, file taxonomy takes priority over label-based
  parsing. If `FALSE`, file is used only for labels that cannot be
  parsed from the tree. Default: `TRUE`.

- table_sep:

  Character. Separator between taxonomy ranks in the second column of
  the taxonomy file. Default: `";"`.

- delimiter_mode:

  Character. Embedded parsing strategy: "reverse", "greedy", "segment".

- taxonomy_levels:

  Custom taxonomy level configuration (list with codes and names). Used
  to extend or override default rank handling. Default: `NULL`.

## Value

data.frame with columns: label, Group.
