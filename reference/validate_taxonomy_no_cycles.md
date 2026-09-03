# Detect circular dependencies in taxonomy table

Validates full taxonomy consistency by checking for cyclical
relationships between **every pair of adjacent ranks** (coarsest to
finest), not just the canonical domain/phylum/class/order chain. For
example:

- domain \<-\> phylum, phylum \<-\> class, class \<-\> order,

- order \<-\> family, family \<-\> genus, genus \<-\> species

A circular dependency means a value appears as both a high-rank and a
low-rank member forming a loop (e.g. Row 1: `d__A;p__B`, Row 2:
`d__B;p__A`).

## Usage

``` r
validate_taxonomy_no_cycles(taxa_df, filepath = "<taxonomy>")
```

## Arguments

- taxa_df:

  data.frame with taxonomy columns (domain, phylum, class, etc.).

- filepath:

  Character. Source file for error messages.

## Value

Invisibly returns TRUE if no cycles. Aborts on detection (class
`Rclade_validate_error`).
