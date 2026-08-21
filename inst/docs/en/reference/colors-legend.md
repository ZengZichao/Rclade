# Colors & Legend

Generate color-blind-safe palettes and split legends for publication-ready plots.

This module contains the following functions:

- [`generate_colors`](#generate_colors) — Generate color mapping for taxonomic groups
- [`split_legend`](#split_legend) — Extract legend as separate grob and combine with patchwork

## `generate_colors`

Generate color mapping for taxonomic groups

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
generate_colors(groups, palette = "viridis")
```


---

## `split_legend`

Extract legend as separate grob and combine with patchwork

**Usage:**

```r
split_legend(p, ncol_split = 2)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `p` | ggplot object |
| `ncol_split` | Number of columns for legend splitting (used for reflow) |

**Value:**

patchwork object. Note: This returns a patchwork object, not a ggplot object.
You cannot add ggplot2 layers with `+` after calling `split_legend()`.
Use patchwork operators like `|` and `/` for layout composition.

**Examples:**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum")
split_legend(p, ncol_split = 2)
```


---


---

[中文](../../cn/reference/colors-legend.md) | [文档首页](../../index.md)
