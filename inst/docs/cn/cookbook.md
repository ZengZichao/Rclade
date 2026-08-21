# 示例集锦

常见任务的即拷即用配方。所有示例均使用内置的 `example_tree`。

## 以不同于折叠的阶元着色

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   color_rank = "class", unit = "Ma")
```

## 高亮特殊祖先节点

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   highlight = "LUCA", unit = "Ma")
```

## 使用精确的自定义颜色

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   color_mapping = c("Firmicutes" = "#E41A1C",
                                     "Proteobacteria" = "#377EB8"),
                   unit = "Ma")
```

## 图例置于顶部并分两列

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   legend_position = "top", legend_ncol = 2, unit = "Ma")
```

## 大树隐藏末端标签

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   show_tip_label = FALSE, unit = "Ma")
```

## 按 cladogram 绘制（忽略枝长）

```r
p <- plot_timetree(example_tree, rank = "phylum",
                   ignore_branch_length = TRUE, unit = "Ma")
```

## 绘图前检测标签格式

```r
labels <- example_tree$tip.label
detect_taxonomy_format(labels)
```

## 交叉校验树与序列文件

```r
validate_tree_sequence_match(example_tree, "seqs.fasta", mol_type = "DNA")
```

## 检查分组的单系性

```r
check_monophyly(example_tree, group = "Firmicutes", rank = "phylum")
```

## 为自己的分组生成调色板

```r
groups <- c("Firmicutes", "Proteobacteria", "Bacteroidetes")
generate_colors(groups, palette = "viridis")
```

## 为某次运行开启详细日志

```r
set_log_level("DEBUG")
set_log_file("rclade_run.log")
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
```

## 为流程阶段计时

```r
timer_start("collapse")
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
timer_stop("collapse")
```

## 保存可复现的会话记录

```r
save_session_info("session_info.txt")
```

另见[参考手册索引](reference/index.md)。
