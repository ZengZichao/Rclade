# Cookbook

Copy-paste recipes for common tasks. All examples use the bundled `example_tree`.

## Color by a rank different from the collapse rank

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   color_rank = "class", unit = "Ma")
```

## Highlight a special ancestral node

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   highlight = "LUCA", unit = "Ma")
```

## Use exact custom colors

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   color_mapping = c("Firmicutes" = "#E41A1C",
                                     "Proteobacteria" = "#377EB8"),
                   unit = "Ma")
```

## Put the legend on top with two columns

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   legend_position = "top", legend_ncol = 2, unit = "Ma")
```

## Hide tip labels on a large tree

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   show_tip_label = FALSE, unit = "Ma")
```

## Draw as a cladogram (ignore branch lengths)

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   ignore_branch_length = TRUE, unit = "Ma")
```

## Detect label format before plotting

```r
labels <- example_tree$tip.label
detect_taxonomy_format(labels)
```

## Cross-validate a tree against a sequence file

```r
validate_tree_sequence_match(example_tree, "seqs.fasta", mol_type = "DNA")
```

## Check monophyly of a group

```r
check_monophyly(example_tree, group = "Firmicutes", rank = "phylum")
```

## Generate a palette for your own groups

```r
groups <- c("Firmicutes", "Proteobacteria", "Bacteroidetes")
generate_colors(groups, palette = "viridis")
```

## Enable detailed logging for a run

```r
set_log_level("DEBUG")
set_log_file("rclade_run.log")
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
```

## Time a pipeline stage

```r
timer_start("collapse")
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
timer_stop("collapse")
```

## Save a reproducible session record

```r
save_session_info("session_info.txt")
```

See also [Reference index](reference/index.md).
