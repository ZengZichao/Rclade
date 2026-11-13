# Colors & Legend

Generate color-blind-safe palettes and split legends for publication-ready plots.

This module contains the following functions:

- [`generate_colors`](#generate_colors) — Generate color mapping for taxonomic groups
- [`split_legend`](#split_legend) — Extract legend as separate grob and combine with patchwork

> Not exported (internal): `generate_colors`, `split_legend`. Call them as `Rclade:::generate_colors()`.

## `generate_colors`

Generate color mapping for taxonomic groups

Assigns a color to each group based on the group names, using a color-blind-safe
palette such as `viridis` or a custom color vector; equivalent to the coloring
logic used internally by `plot_timetree()`.

**Usage:**

```r
generate_colors(groups, palette = "viridis", color_mapping = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `groups` | Character vector of group names |
| `palette` | Palette name (e.g., "viridis", "Set1", "rainbow") or color vector |
| `color_mapping` | Named vector of specific color assignments (highest priority) |

**Value:**

Named color vector (names = groups)

**Examples:**

```r
groups <- c("Firmicutes", "Proteobacteria", "Bacteroidetes")
Rclade:::generate_colors(groups, palette = "viridis")
```


---

## `split_legend`

Extract legend as separate grob and combine with patchwork

Reflows a crowded legend into several columns and combines the result back with
the main plot; useful when there are many groups and a single legend is too long.

**Usage:**

```r
split_legend(p, ncol_split = 2)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `p` | `ggplot` object |
| `ncol_split` | Number of columns for legend splitting (used for reflow) |

**Value:**

patchwork object. Note: This returns a patchwork object, not a ggplot object.
You cannot add ggplot2 layers with `+` after calling `split_legend()`.
Use patchwork operators like `|` and `/` for layout composition.

**Examples:**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
Rclade:::split_legend(p, ncol_split = 2)
```


---


---

[中文](../../cn/reference/colors-legend.md) | [Documentation Home](../index.md)
