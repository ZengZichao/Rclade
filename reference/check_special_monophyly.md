# Check if a special identifier corresponds to a monophyletic group

Tests whether the MRCA of the specified domains (identified by
LUCA/LACA/LBCA) contains only tips from those domains (i.e., is
monophyletic with respect to the target domains).

## Usage

``` r
check_special_monophyly(
  tree,
  identifier,
  format = "auto",
  quiet = FALSE,
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

## Arguments

- tree:

  A `phylo` object.

- identifier:

  Character. One of `"LUCA"`, `"LACA"`, `"LBCA"`.

- format:

  Character. Taxonomy label format. Default: `"auto"`.

- quiet:

  Logical. If TRUE, suppress informational messages. Default: FALSE.

- delimiter_mode:

  Character. Embedded parsing strategy: `"reverse"`, `"greedy"`, or
  `"segment"`. Default: `"reverse"`.

- taxonomy_levels:

  Custom taxonomy level configuration (list with codes and names).
  Default: `NULL`.

## Value

A list with components:

- is_monophyletic:

  Logical. Whether the group is monophyletic.

- identifier:

  Character. The identifier name.

- node:

  Integer or NULL. The MRCA node number.

- n_tips:

  Integer. Number of tips in the target domains.

- n_outsiders:

  Integer. Number of outsider tips in the MRCA clade.

- outsider_domains:

  Character vector. Domains of outsider tips.

## Examples

``` r
data(example_tree)
result <- check_special_monophyly(example_tree, "LBCA")
#> LBCA IS monophyletic (50 tips, MRCA node 51).
if (result$is_monophyletic) {
  message("LBCA is monophyletic!")
}
#> LBCA is monophyletic!
```
