# Getting Started

This guide walks you through your first Rclade plot in five minutes.

## 1. Load the package and the example data

```r
library(Rclade)
data(example_tree)   # a phylo object with GTDB-style tip labels
```

`example_tree` is a small bundled tree so you can try everything without your own data.

## 2. Draw your first time tree

Collapse the tree at the **phylum** rank and add a geological timescale:

```r
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
print(p)
```

That single call:

1. detects the taxonomy format from the tip labels,
2. parses each tip's phylum,
3. finds the MRCA of each phylum and collapses it into a triangle,
4. adds the geological timescale on the x-axis,
5. assigns a color-blind-safe palette and lays out the legend.

## 3. Save the figure

```r
save_timetree(p, file = "phylum_tree.pdf", width = 12, height = 8)
```

Formats are chosen by file extension: `.pdf`, `.png`, `.tiff`, `.svg`, `.eps`.

## 4. Inspect what happened

```r
summarize_timetree(p)
```

This prints the number of tips, collapsed clades, taxonomy coverage, and more.

## 5. Try common variations

```r
# Circular / fan layout
p2 <- plot_timetree(example_tree, rank = "class", layout = "circular")

# Turn off the timescale
p3 <- plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE)

# Use a custom palette
p4 <- plot_timetree(example_tree, rank = "phylum", color_palette = "Set1")
```

## 6. Go further

- Plot many trees at once: [batch_plot](reference/core-visualization.md)
- Parse and validate your own labels: [Taxonomy Parsing](reference/taxonomy-parsing.md)
- Run from the command line: [run_rclade_cli](reference/cli-interactive.md)
- Use the graphical app: [run_rclade_shiny](reference/cli-interactive.md)

Next: read [Core concepts](core-concepts.md) to understand taxonomy formats, MRCA collapsing, and timescales.
