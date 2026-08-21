# 颜色与图例

生成色盲友好的调色板，并拆分图例以生成出版级图表。

本模块包含以下函数：

- [`generate_colors`](#generate_colors) — 为分类分组生成颜色映射
- [`split_legend`](#split_legend) — 拆分图例为独立 grob 并用 patchwork 组合

## `generate_colors`

**为分类分组生成颜色映射**

根据分组名为每个分组分配颜色，支持 viridis 等色盲友好调色板或自定义颜色，等价于 plot_timetree 内部的着色逻辑。

**用法：**

```r
generate_colors(groups, palette = "viridis", color_mapping = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `groups` | 分组名字符向量。 |
| `palette` | 调色板名称（viridis / Set1 / rainbow 等）或颜色向量。 |
| `color_mapping` | 具名颜色向量，优先级最高。 |

**返回值：**

返回分组名到颜色的具名向量。

**示例：**

```r
groups <- c("Firmicutes", "Proteobacteria", "Bacteroidetes")
generate_colors(groups, palette = "viridis")
```


---

## `split_legend`

**拆分图例为独立 grob 并用 patchwork 组合**

将拥挤的图例拆分为多列重新排布，再与主图组合，适用于分组很多、单图例过长的情况。

**用法：**

```r
split_legend(p, ncol_split = 2)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `p` | ggplot 对象。 |
| `ncol_split` | 图例拆分的列数（用于重排）。 |

**返回值：**

返回 patchwork 组合对象。

**示例：**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum")
split_legend(p, ncol_split = 2)
```


---


---

[英文](../../en/reference/colors-legend.md) | [文档首页](../../index.md)
