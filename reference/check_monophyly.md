# Check if a taxonomic group is monophyletic

Tests whether all tips belonging to a specified taxonomic group form a
monophyletic clade in the tree.

## Usage

``` r
check_monophyly(
  tree,
  group,
  rank,
  format = "auto",
  custom_patterns = NULL,
  quiet = FALSE,
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

## Arguments

- tree:

  A `phylo` object.

- group:

  Character. The name of the taxonomic group to check (e.g., `"P1"`,
  `"Mammalia"`).

- rank:

  Character. Taxonomic rank of the group. One of `"domain"`, `"phylum"`,
  `"class"`, `"order"`, `"family"`, `"genus"`, `"species"`, or
  abbreviations `"d"`, `"p"`, `"c"`, `"o"`, `"f"`, `"g"`, `"s"`.

- format:

  Character. Taxonomy label format. One of `"auto"`, `"GTDB"`,
  `"Silva"`, `"NCBI"`, `"custom_rank"`, `"custom_regex"`. Default:
  `"auto"`.

- custom_patterns:

  Named list of regex patterns for custom format. Required when
  `format = "custom_regex"`.

- quiet:

  Logical. If `TRUE`, suppress informational messages. Default: `FALSE`.

- delimiter_mode:

  Character. Embedded (Format A) parsing strategy: `"reverse"`
  (right-to-left, default), `"greedy"` (left-to-right), or `"segment"`
  (delimiter-to-delimiter extraction).

- taxonomy_levels:

  Custom taxonomy level configuration (list with codes and names).
  Default: `NULL`.

## Value

A list with components:

- is_monophyletic:

  Logical. Whether the group is monophyletic.

- group:

  Character. The group name.

- n_tips:

  Integer. Number of tips belonging to the group.

- mrca_node:

  Integer or NULL. The MRCA node number, or NULL if the group has fewer
  than 2 tips.

- outsiders:

  Character vector. Tips in the MRCA clade that do not belong to the
  group (empty if monophyletic).

## Case sensitivity (L-A2)

Group matching is **case-insensitive**. The query `group` and every
parsed `Group` label are lower-cased with
[`tolower()`](https://rdrr.io/r/base/chartr.html) *at comparison time*
(not during parsing) before matching, so `"Proteobacteria"` and
`"proteobacteria"` match the same clade.
[`parse_taxonomy`](https://zengzichao.github.io/Rclade/reference/parse_taxonomy.md)
itself preserves the original case of parsed labels; the lower-casing
applied here is local to this comparison and keeps the two modules
consistent about what a group name refers to.

## Examples

``` r
if (FALSE) { # \dontrun{
data(example_tree)

# Check if phylum P1 is monophyletic
result <- check_monophyly(example_tree, "P1",
                           rank = "phylum", format = "GTDB")
if (result$is_monophyletic) {
  cat("P1 is monophyletic!\n")
} else {
  cat("P1 is NOT monophyletic.\n")
}
} # }
```
