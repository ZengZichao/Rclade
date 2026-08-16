# Resolve special ancestral node identifiers

Handles special identifiers for key ancestral nodes in the tree of life:

- **LUCA**: Last Universal Common Ancestor - MRCA of all Bacteria and
  Archaea

- **LACA**: Last Archaeal Common Ancestor - MRCA of all Archaea

- **LBCA**: Last Bacterial Common Ancestor - MRCA of all Bacteria

## Usage

``` r
resolve_special_identifier(
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

  Character. One of `"ROOT"`, `"LUCA"`, `"LACA"`, `"LBCA"`.

  ROOT

  :   Root of the tree

  LUCA

  :   Last Universal Common Ancestor (MRCA of all Bacteria and Archaea)

  LACA

  :   Last Archaeal Common Ancestor (MRCA of all Archaea)

  LBCA

  :   Last Bacterial Common Ancestor (MRCA of all Bacteria)

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

- node:

  Integer. The node number of the MRCA, or NULL if not found.

- identifier:

  Character. The identifier name.

- description:

  Character. Human-readable description.

- n_tips:

  Integer. Number of descendant tips.

- tip_labels:

  Character vector. Labels of descendant tips.

## Examples

``` r
if (FALSE) { # \dontrun{
data(example_tree)
root <- resolve_special_identifier(example_tree, "ROOT")
luca <- resolve_special_identifier(example_tree, "LUCA")
if (!is.null(luca$node)) {
  cat("LUCA found at node", luca$node, "\n")
}
} # }
```
