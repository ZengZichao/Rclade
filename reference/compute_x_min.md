# Compute x-axis minimum from tree depth

Calculates the leftmost x-axis value by finding the maximum tree depth
and applying a 5% margin extension for visual clarity. The axis range is
**adaptive**: for trees whose root is younger than the end of the Hadean
eon (4031 Ma), the axis starts slightly beyond the root so the tree
occupies the full panel width. Only when the root reaches into the
Hadean is the axis floored at -4567 Ma, so the entire Hadean eon is
shown exactly when it is relevant.

## Usage

``` r
compute_x_min(tree)
```

## Arguments

- tree:

  phylo object with edge lengths

## Value

Negative x_min value (in same units as edge lengths, typically Ma)
