# Tutorials

End-to-end workflows. Each tutorial is self-contained; copy and adapt.

## Tutorial 1 — Plot a tree from a file

```r
library(Rclade)

# Read any Newick / Nexus file (format auto-detected)
tree <- read_tree_auto("my_tree.nwk")

# Collapse at phylum and draw
p <- plot_timetree(tree, rank = "phylum", unit = "Ma")

# Save
save_timetree(p, file = "my_tree_phylum.pdf", width = 14, height = 10)
```

If the tree has multiple trees (e.g. a BEAST `.trees` file), choose one:

```r
p <- plot_timetree("beast.trees", rank = "phylum",
                   multi_tree_mode = "first", unit = "Ma")
```

## Tutorial 2 — Validate and use custom groups

```r
library(Rclade)
data(example_tree)

# Define a custom group (must be monophyletic)
groups <- list(MyGroup = c("tip_A", "tip_B", "tip_C"))

# Check it is monophyletic before plotting
validate_custom_groups(example_tree, groups)

# Collapse by the custom group
p <- plot_timetree(example_tree, groups = groups, unit = "Ma")
```

## Tutorial 3 — Publication-ready circular tree

```r
library(Rclade)
data(example_tree)

p <- plot_timetree(example_tree,
                   rank = "phylum",
                   layout = "circular",
                   angle = 320,
                   add_timescale = FALSE,
                   color_palette = "viridis") +
     theme_timetree(base_size = 12)

save_timetree(p, file = "circular.pdf", width = 10, height = 10, dpi = 300)
```

## Tutorial 4 — Use an external taxonomy file

When tip labels lack taxonomy, provide a two-column file:

```r
library(Rclade)

# taxonomy.tsv:  col1 = tip label, col2 = "d__...;p__...;c__..."
df <- read_taxonomy_file("taxonomy.tsv", sep = "\t", header = FALSE)

# Plot, prioritizing the file
p <- plot_timetree("my_tree.nwk", rank = "phylum",
                   taxonomy_file = "taxonomy.tsv",
                   taxonomy_file_priority = TRUE, unit = "Ma")
```

Inspect coverage first with [summarize_taxonomy_quality_with_file](reference/taxonomy-parsing.md).

## Tutorial 5 — Batch-process a directory

```r
library(Rclade)

batch_plot(input_dir = "trees/",
           output_dir = "plots/",
           pattern = "*.tre",
           rank = "phylum",
           unit = "Ma",
           format = "pdf")
```

`batch_plot` calls `plot_timetree` on every matching file. Use `overwrite = "force"` to replace existing outputs.

## Tutorial 6 — Run from the command line

Create a small YAML or pass arguments directly:

```bash
Rscript -e 'Rclade::run_rclade_cli()' -- \
  -f my_tree.nwk -r phylum -u Ma -o out.pdf
```

Use `Rscript -e 'Rclade::run_rclade_cli(c("--help"))'` to list options, or launch the GUI with `run_rclade_shiny()`.

## Next

- [Cookbook](cookbook.md) for more copy-paste recipes.
- [Reference index](reference/index.md) for every function.
