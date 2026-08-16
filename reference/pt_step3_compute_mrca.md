# Step 3: Compute MRCA and check monophyly

Computes MRCA map for each group, checks monophyly, and detects nesting
conflicts.

## Usage

``` r
pt_step3_compute_mrca(tree, group_vec, clade, strict, low_memory)
```

## Value

A named list with:

- mrca_map:

  list of MRCA nodes per group

- singleton_map:

  singleton group map (attr from compute_mrca_map)

- all_group_names:

  union of mrca and singleton names
