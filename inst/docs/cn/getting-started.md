# 入门指南

本指南带你在五分钟内画出第一张 Rclade 图。

## 1. 加载包与示例数据

```r
library(Rclade)
data(example_tree)   # 带有 GTDB 风格末端标签的 phylo 对象
```

`example_tree` 是一个内置的小树，便于在无需自有数据的情况下尝试全部功能。

## 2. 画出第一张时间树

按**门（phylum）**阶元折叠并添加地质时间轴：

```r
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
print(p)
```

这一次调用完成了：

1. 从末端标签检测分类格式；
2. 解析每个末端的门；
3. 找到每个门的 MRCA 并将其折叠为三角形；
4. 在 x 轴添加地质时间轴；
5. 分配色盲友好调色板并排布图例。

## 3. 保存图形

```r
save_timetree(p, file = "phylum_tree.pdf", width = 12, height = 8)
```

输出格式由文件扩展名决定：`.pdf`、`.png`、`.tiff`、`.svg`、`.eps`。

## 4. 查看发生了什么

```r
summarize_timetree(p)
```

打印末端数量、折叠分支数、分类覆盖率等信息。

## 5. 尝试常见变体

```r
# 环形 / 扇形布局
p2 <- plot_timetree(example_tree, rank = "class", layout = "circular")

# 关闭时间轴
p3 <- plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE)

# 使用自定义调色板
p4 <- plot_timetree(example_tree, rank = "phylum", color_palette = "Set1")
```

## 6. 更进一步

- 一次绘制多棵树：[batch_plot](reference/core-visualization.md)
- 解析并校验你自己的标签：[分类学解析](reference/taxonomy-parsing.md)
- 从命令行运行：[run_rclade_cli](reference/cli-interactive.md)
- 使用图形界面：[run_rclade_shiny](reference/cli-interactive.md)

下一步：阅读[核心概念](core-concepts.md)，理解分类格式、MRCA 折叠与时间轴。
