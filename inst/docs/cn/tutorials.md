# 教程

端到端工作流。每个教程均可独立运行，复制后按需修改。

## 教程 1 — 从文件绘制树

```r
library(Rclade)

# 读取任意 Newick / Nexus 文件（自动检测格式）
tree <- read_tree_auto("my_tree.nwk")

# 按门折叠并绘制
p <- plot_timetree(tree, rank = "phylum", unit = "Ma")

# 保存
save_timetree(p, file = "my_tree_phylum.pdf", width = 14, height = 10)
```

若文件包含多棵树（如 BEAST 的 `.trees`），选择其中一棵：

```r
p <- plot_timetree("beast.trees", rank = "phylum",
                   multi_tree_mode = "first", unit = "Ma")
```

## 教程 2 — 校验并使用自定义分组

```r
library(Rclade)
data(example_tree)

# 定义自定义分组（必须单系）
groups <- list(MyGroup = c("tip_A", "tip_B", "tip_C"))

# 绘图前先检查是否单系
validate_custom_groups(example_tree, groups)

# 按自定义分组折叠
p <- plot_timetree(example_tree, groups = groups, unit = "Ma")
```

## 教程 3 — 出版级环形树

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

## 教程 4 — 使用外部分类文件

当末端标签缺少分类时，提供两列表格：

```r
library(Rclade)

# taxonomy.tsv: 第1列=末端标签，第2列="d__...;p__...;c__..."
df <- read_taxonomy_file("taxonomy.tsv", sep = "\t", header = FALSE)

# 绘图，优先使用文件
p <- plot_timetree("my_tree.nwk", rank = "phylum",
                   taxonomy_file = "taxonomy.tsv",
                   taxonomy_file_priority = TRUE, unit = "Ma")
```

先用 [summarize_taxonomy_quality_with_file](reference/taxonomy-parsing.md) 检查覆盖率。

## 教程 5 — 批量处理目录

```r
library(Rclade)

batch_plot(input_dir = "trees/",
           output_dir = "plots/",
           pattern = "*.tre",
           rank = "phylum",
           unit = "Ma",
           format = "pdf")
```

`batch_plot` 对每一个匹配文件调用 `plot_timetree`。使用 `overwrite = "force"` 覆盖已有输出。

## 教程 6 — 从命令行运行

```bash
Rscript -e 'Rclade::run_rclade_cli()' -- \
  -f my_tree.nwk -r phylum -u Ma -o out.pdf
```

用 `Rscript -e 'Rclade::run_rclade_cli(c("--help"))'` 查看所有选项，或用 `run_rclade_shiny()` 启动图形界面。

## 下一步

- [示例集锦](cookbook.md) 获取更多即拷即用配方。
- [参考手册索引](reference/index.md) 查看每个函数。
