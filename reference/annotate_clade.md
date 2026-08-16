# Add clade labels next to collapsed triangles

Supports both rectangular and circular (fan) layouts. For rectangular:
labels are at the tips' x-position, extending rightward. For circular:
labels are at the tips' x-position (outer radius), angled along the
MRCA's angular position, extending outward.

## Usage

``` r
annotate_clade(
  p,
  tree,
  mrca_map,
  colors,
  show_count = TRUE,
  offset = 0,
  fontsize = 3,
  singleton_map = NULL
)
```

## Arguments

- p:

  ggplot object

- tree:

  phylo object

- mrca_map:

  Output of compute_mrca_map()

- colors:

  Named color vector

- show_count:

  Whether to show species count

- offset:

  Offset from the tree's right edge (tips). Default 0 places labels
  right at the tip line.

- fontsize:

  Font size for labels (default 3)

- singleton_map:

  Optional named list mapping single-species group names to their tip
  label. When provided, these tips are also labeled.

## Value

ggplot object
