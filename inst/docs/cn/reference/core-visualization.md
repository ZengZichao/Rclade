# 核心可视化

用于绘制、保存与汇总系统发育时间树的主函数。

本模块包含以下函数：

- [`plot_timetree`](#plot_timetree) — 绘制带地质时间轴与分类学折叠的系统发育时间树
- [`batch_plot`](#batch_plot) — 批量绘制目录下所有树文件
- [`save_timetree`](#save_timetree) — 将时间树图保存到文件
- [`summarize_timetree`](#summarize_timetree) — 打印时间树图的摘要信息
- [`theme_timetree`](#theme_timetree) — 时间树图的出版级主题

## `plot_timetree`

**绘制带地质时间轴与分类学折叠的系统发育时间树**

Rclade 的核心函数。自动解析分类学标签、识别最近共同祖先（MRCA）、按指定阶元折叠分支、集成地质时间轴并智能排布图例，生成出版级时间树图。

**用法：**

```r
plot_timetree(
  tree,
  tree_index = NULL,
  multi_tree_mode = "error",
  rank = "none",
  triangle_mode = "mixed",
  space_mode = "proportional",
  layout = "rectangular",
  angle = 360,
  color_palette = "viridis",
  color_mapping = NULL,
  line_width = 1,
  show_tip_labels = FALSE,
  tip_label_size = 2,
  add_timescale = TRUE,
  timescale_levels = c("eras", "eons"),
  unit = NULL,
  taxonomy_format = "auto",
  custom_patterns = NULL,
  taxonomy_file = NULL,
  taxonomy_file_sep = "auto",
  taxonomy_file_header = FALSE,
  taxonomy_file_priority = TRUE,
  taxonomy_source_priority = NULL,
  taxonomy_table_sep = ";",
  taxonomy_delimiter_mode = "reverse",
  legend_position = "bottom",
  legend_nrow = NULL,
  legend_ncol = NULL,
  legend_title = NULL,
  clade = NULL,
  strict = FALSE,
  groups = NULL,
  show_clade_label = FALSE,
  show_clade_count = TRUE,
  clade_label_offset = 50,
  clade_label_fontsize = 3,
  show_support = FALSE,
  support_threshold = 0.95,
  show_hpd = FALSE,
  hpd_color = "firebrick",
  geo_events = FALSE,
  timescale_version = "ICS 2023/02",
  main_title = NULL,
  sub_title = NULL,
  highlight = NULL,
  highlight_alpha = 0.2,
  theme_fun = theme_timetree,
  output = NULL,
  overwrite = "ask",
  width = 14,
  height = 10,
  taxonomy_levels = NULL,
  low_memory = FALSE,
  ignore_malformed = FALSE,
  ignore_branch_length = FALSE,
  color_rank = NULL,
  timescale_mode = "radial",
  timescale_position = "right",
  tree_start_position = "right"
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `tree` | phylo / treedata 对象，或指向 Newick / Nexus 文件的路径字符串。 |
| `tree_index` | 多树对象（如 BEAST 后验）中使用的树索引；仅当 tree 为文件路径时生效。 |
| `multi_tree_mode` | 多树文件的处理方式：error（默认，提示用户指定）/ ask（交互式选择，非交互时回退为 error）/ first / last / random / all（批量模式，返回图对象列表）/ split（返回全部树，CLI 按序号输出每棵树）。 |
| `rank` | 折叠所依据的分类阶元，可选 none / kingdom / domain / phylum / class / order / family / genus / species / subspecies，或缩写 k / d / p / c / o / f / g / s / ss；与 groups 互斥。 |
| `triangle_mode` | 折叠三角形的可视化模式：max / min / mixed / none。 |
| `space_mode` | 折叠分支的纵向空间分配策略：equal / proportional。 |
| `layout` | 树形布局：rectangular（矩形）或 circular（环形）。 |
| `angle` | 环形布局的扇形角度（0–360）。 |
| `color_palette` | 调色板名称（如 viridis / rainbow 或 RColorBrewer 名称）或颜色向量。 |
| `color_mapping` | 具名颜色向量，优先级最高，名称需与分组名一致。 |
| `line_width` | 分支线宽。 |
| `show_tip_labels` | 是否显示末端标签。 |
| `tip_label_size` | 末端标签字体大小。 |
| `add_timescale` | 是否在 x 轴添加地质时间轴。 |
| `timescale_levels` | 要显示的时间尺度层级：eras / eons / periods。 |
| `unit` | 输入树枝长的时间单位：Ga 或 Ma。`"Ga"` 时枝长自动转换为 Ma（×1000）。`NULL`（默认）保持树原生单位不变；`add_timescale = TRUE` 时流水线按 Ma 处理，并在中位枝长疑似不一致时发出单位合理性警告（无自动单位检测——请显式指定单位以获得正确时间轴）。 |
| `taxonomy_format` | 分类标签格式：auto / GTDB / Silva / NCBI / custom_rank / custom_regex。 |
| `custom_patterns` | custom_regex 格式所需的具名正则列表。 |
| `taxonomy_file` | 外部分类学文件路径（两列：末端标签与 GTDB 格式分类串）。 |
| `taxonomy_file_sep` | 分类文件的列分隔符；auto 自动检测。 |
| `taxonomy_file_header` | 分类文件是否含表头。 |
| `taxonomy_file_priority` | 为 TRUE 时文件分类优先于标签解析。 |
| `taxonomy_source_priority` | 当两种方法都可用时，优先使用 embedded 还是 table。 |
| `taxonomy_table_sep` | 外部分类文件中阶元间的分隔符，默认分号。 |
| `taxonomy_delimiter_mode` | 嵌入标签的解析策略：reverse / greedy / segment。 |
| `legend_position` | 图例位置：方位词或 c(x,y) 数值向量。 |
| `legend_nrow` | 图例网格的行数；NULL 自动计算。 |
| `legend_ncol` | 图例网格的列数；NULL 自动计算。 |
| `legend_title` | 自定义图例标题；NULL 时自动使用阶元名。 |
| `clade` | 需折叠的特定分支名；与 rank/group 互斥。 |
| `strict` | 为 TRUE 时非单系分支报错终止；FALSE 时警告并跳过。 |
| `groups` | 用于折叠的具名自定义末端分组列表。 |
| `show_clade_label` | 是否在折叠三角形旁显示分支名与物种数。 |
| `show_clade_count` | 是否在分支标签中显示物种数。 |
| `clade_label_offset` | 分支标签相对三角形右边缘的水平偏移（Ma）。 |
| `clade_label_fontsize` | 分支标签字体大小。 |
| `show_support` | 是否显示节点支持率。 |
| `support_threshold` | 显示支持率的最小阈值（0–1）。 |
| `show_hpd` | 是否显示 HPD 区间。 |
| `hpd_color` | HPD 柱的颜色。 |
| `geo_events` | 用于标注地质事件的数据框，列需含 name、age_min、age_max（Ma）、color；为 TRUE 时显示默认事件（GOE=2400–2000 Ma，NOE=800–550 Ma）。默认 FALSE。 |
| `timescale_version` | 地质时间轴版本，目前仅支持 ICS 2023/02。 |
| `main_title` | 图主标题。 |
| `sub_title` | 图副标题。 |
| `highlight` | 需用彩色背景高亮的分组名向量。 |
| `highlight_alpha` | 高亮颜色透明度（0–1）。 |
| `theme_fun` | 主题函数；NULL 使用 ggplot2 默认主题。 |
| `output` | 可选输出文件路径；提供则立即保存。 |
| `overwrite` | output 文件存在时的覆盖模式：ask / force / no-clobber。 |
| `width` | 输出宽度（英寸）。 |
| `height` | 输出高度（英寸）。 |
| `taxonomy_levels` | 自定义分类阶元代码与名称的配置列表。 |
| `low_memory` | 为 TRUE 时在主要步骤间触发垃圾回收以节省内存。 |
| `ignore_malformed` | 为 TRUE 时畸形输入仅警告跳过而非终止。 |
| `ignore_branch_length` | 为 TRUE 时忽略枝长，按 cladogram 绘制。 |
| `color_rank` | 着色所用的分类阶元，独立于折叠所用的 rank。 |
| `timescale_mode` | 环形布局的时间轴模式：radial / linear。 |
| `timescale_position` | linear 模式时间轴所在时钟位置。 |
| `tree_start_position` | 环形布局中树展开的起始时钟位置。 |

**返回值：**

返回带有 rclade_info 属性的 ggplot 对象，可用于进一步修改或保存。

**示例：**

```r
# 加载内置示例树
data(example_tree)

# 按门(phylum)阶元折叠并绘制时间树
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
print(p)

# 关闭时间轴、使用自定义调色板
p2 <- plot_timetree(example_tree, rank = "class",
                    add_timescale = FALSE, color_palette = "Set1")
```


---

## `batch_plot`

**批量绘制目录下所有树文件**

遍历输入目录中的树文件，对每个文件调用 plot_timetree 并保存到输出目录，支持通配符匹配与覆盖模式控制。

**用法：**

```r
batch_plot(
  input_dir,
  output_dir,
  pattern = "*.tre",
  format = "pdf",
  width = 14,
  height = 10,
  overwrite = "ask",
  ...
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `input_dir` | 包含树文件的输入目录。 |
| `output_dir` | 图表输出目录。 |
| `pattern` | 文件匹配模式（glob 格式，如 "*.tre"）。 |
| `format` | 输出格式：pdf / png / tiff / svg / eps，默认 pdf。 |
| `width` | 输出宽度（英寸），默认 14。 |
| `height` | 输出高度（英寸），默认 10。 |
| `overwrite` | 覆盖模式：ask（默认）/ force / no-clobber。 |
| `...` | 传递给 plot_timetree() 的额外参数。 |

**返回值：**

在输出目录为每个树生成图表文件，并不可见地返回成功/失败状态列表（list of success/failure status）。

**示例：**

```r
# 批量绘制目录下所有 .tre 文件，按门折叠
batch_plot(input_dir = "trees/", output_dir = "plots/",
           pattern = "*.tre", rank = "phylum", unit = "Ma")
```


---

## `save_timetree`

**将时间树图保存到文件**

将 plot_timetree 返回的 ggplot 对象保存为磁盘文件，自动按扩展名选择设备并支持覆盖模式。

**用法：**

```r
save_timetree(p, file, width = 14, height = 10, dpi = 300, overwrite = "ask")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `p` | ggplot 对象（由 plot_timetree 返回）。 |
| `file` | 输出文件路径。 |
| `width` | 宽度（英寸），默认 14。 |
| `height` | 高度（英寸），默认 10。 |
| `dpi` | 分辨率（仅 PNG/TIFF 生效），默认 300。 |
| `overwrite` | 覆盖模式：ask（默认）/ force / no-clobber。 |

**返回值：**

将图表写入文件，并不可见地返回 ggplot 对象。

**示例：**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum")
save_timetree(p, file = "tree.pdf", width = 12, height = 8)
```


---

## `summarize_timetree`

**打印时间树图的摘要信息**

读取 plot_timetree 结果中附带的 rclade_info 属性，以结构化方式打印树规模、折叠分支数、分类覆盖等关键信息。

**用法：**

```r
summarize_timetree(p)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `p` | plot_timetree 返回的 ggplot 对象。 |

**返回值：**

将摘要打印到控制台，并（不可见地）返回内部的 rclade_info 列表。

**示例：**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum")
summarize_timetree(p)
```


---

## `theme_timetree`

**时间树图的出版级主题**

基于 ggtree::theme_tree2() 定制，面向出版质量（字体、网格、边距等）。注意：它返回含 `theme` 与 `coord` 两个组件的列表，不能直接整体用 `+` 叠加，需分别应用（见下方示例）。

**用法：**

```r
theme_timetree(base_size = 12)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `base_size` | 基础字体大小。 |

**返回值：**

返回含 `theme`（ggplot2 主题）与 `coord`（`coord_cartesian(clip = "off")`）两个组件的列表。调用方应通过 `p + r$theme + r$coord` 同时应用两者。

**示例：**

```r
data(example_tree)
r <- theme_timetree(base_size = 14)
p <- plot_timetree(example_tree, rank = "phylum") +
     r$theme + r$coord
print(p)
```


---


---

[英文](../../en/reference/core-visualization.md) | [文档首页](../../index.md)
