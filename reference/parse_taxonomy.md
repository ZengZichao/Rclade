# Unified taxonomy parsing entry point

Parses taxonomic information from tip labels using the specified format
and returns a data.frame of group assignments. Intended for use as a
stable library API by external workflows (e.g., Snakemake/Nextflow).

## Usage

``` r
parse_taxonomy(
  labels,
  rank,
  format = "auto",
  custom_patterns = NULL,
  taxonomy_levels = NULL,
  delimiter_mode = "reverse"
)
```

## Arguments

- labels:

  Character vector of tip labels

- rank:

  Taxonomic rank (abbreviation or full name)

- format:

  Format: "auto", "embedded", "GTDB", "Silva", "NCBI", "custom_rank",
  "custom_regex"

- custom_patterns:

  Custom regex patterns (required when format = "custom_regex")

- taxonomy_levels:

  Custom taxonomy level configuration (list with codes and names)

- delimiter_mode:

  Character. Embedded parsing strategy: "reverse", "greedy", "segment".

## Value

data.frame with columns: label, Group
