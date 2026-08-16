# Read tree from file with automatic format detection

Intended for use as a stable library API by external workflows (e.g.,
Snakemake/Nextflow).

## Usage

``` r
read_tree_auto(filepath, tree_index = NULL, multi_tree_mode = "error")
```

## Arguments

- filepath:

  Path to tree file (.tre, .nwk, .newick, .nexus, .nex, .treefile, .xml)

- tree_index:

  Integer. Index of tree to use from multiPhylo objects (e.g., BEAST
  posterior). Default: NULL (will use multi_tree_mode to determine
  behavior).

- multi_tree_mode:

  Character. How to handle multiple trees in a file. Options:

  - `"error"` (default): Stop with error and ask user to specify

  - `"ask"`: Interactively prompt the user to choose a tree or handling
    mode. Falls back to `"error"` in non-interactive sessions.

  - `"first"`: Use the first tree

  - `"last"`: Use the last tree

  - `"random"`: Use a randomly selected tree

  - `"all"`: Return all trees (as multiPhylo)

  - `"split"`: Return all trees (as multiPhylo); callers write per-tree
    outputs with numeric suffixes (e.g. `output_1.pdf`)

## Value

phylo object (or multiPhylo if multi_tree_mode = "all" or "split")

## Details

Newick labels longer than 500 characters are automatically truncated to
400 characters plus a `_RCLADE_TRUNC` suffix (with a warning), because
ape's Newick parser aborts the whole R process on labels longer than
~512 characters on Linux. Truncated labels may no longer match external
taxonomy files or sequence IDs; shorten labels upstream if exact
matching is required.
