# Report taxonomy label parsing quality

Provides a detailed report on how well taxonomic labels can be parsed,
including per-rank parse rates and failed labels.

## Usage

``` r
summarize_taxonomy_quality(
  labels,
  format = "auto",
  custom_patterns = NULL,
  taxonomy_levels = NULL,
  delimiter_mode = "reverse"
)
```

## Arguments

- labels:

  Character vector of tip labels

- format:

  Format: "auto", "embedded", "GTDB", "Silva", "NCBI", "custom_rank",
  "custom_regex"

- custom_patterns:

  Custom regex patterns (for "custom_regex" format)

- taxonomy_levels:

  Custom taxonomy level configuration

- delimiter_mode:

  Character. Embedded parsing strategy: "reverse", "greedy", "segment".

## Value

Invisibly returns a list with parsing statistics
