# Strip node annotations from a tree (§9.1.1 –strip_annotations)

Removes bootstrap/support node labels and NHX comment metadata from a
tree so they are not carried into the rendered output. Works on both
`phylo` and `treedata` objects. For `treedata` objects, data columns
whose names match common annotation patterns (support values, rates,
heights, HPD intervals, comments, NHX/taxid metadata) are dropped; the
exact matched column names are logged at INFO level.

## Usage

``` r
strip_tree_annotations(tree)
```

## Arguments

- tree:

  A phylo or treedata object.

## Value

The same tree class with annotation fields cleared.
