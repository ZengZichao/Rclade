# Deep tree validation after parsing

Validates a parsed phylo object for structural integrity including
self-loops, multi-root, negative branch lengths, and node consistency.

## Usage

``` r
validate_tree_deep(tree, filepath = "<object>")
```

## Arguments

- tree:

  phylo object.

- filepath:

  Character. Source file path for messages.

## Value

Invisibly returns TRUE if valid.
