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

Rclade 的核心函数，接收系统发育树对象或文件路径。自动解析分类学标签、定位各分组的最近共同祖先（MRCA）、按指定阶元折叠分支、集成地质时间轴并智能排布图例，生成出版级时间树图。

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
  groups_label_only = FALSE,
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
  tree_start_position = "right",
  opts = NULL
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `tree` | `phylo` 或 `treedata` 对象，或指向 Newick（.nwk、.tre、.treefile）或 Nexus（.nexus、.nex）文件的路径字符串。 |
| `tree_index` | 整数。多树对象（如 BEAST 后验样本）中要使用的树索引；仅当 `tree` 为文件路径时生效。默认：`NULL`（改用 `multi_tree_mode` 决定）。 |
| `multi_tree_mode` | 字符。如何处理文件中的多棵树。可选项：`"error"`（默认，报错并提示用户指定）、`"ask"`（交互式询问，非交互会话回退为 `"error"`）、`"first"`、`"last"`、`"random"`、`"all"`（批量模式，返回图对象列表）、`"split"`（同样返回全部树，但 CLI 会按序号为每棵树写出独立输出文件）。 |
| `rank` | 字符。按哪个分类阶元折叠，可选：`"none"`、`"kingdom"`、`"domain"`、`"phylum"`、`"class"`、`"order"`、`"family"`、`"genus"`、`"species"`、`"subspecies"`，或缩写 `"k"`、`"d"`、`"p"`、`"c"`、`"o"`、`"f"`、`"g"`、`"s"`、`"ss"`。默认：`"none"`。与 `groups` 互斥。 |
| `triangle_mode` | 折叠三角形的可视化模式。`"max"` 显示演化支（clade）的完整范围，`"min"` 显示最小范围，`"mixed"` 采用自适应选择，`"none"` 不绘制三角形。默认：`"mixed"`。 |
| `space_mode` | 折叠演化支的空间分配策略。`"equal"` 为每个演化支分配等高的纵向空间，`"proportional"` 按末端数目按比例分配空间。默认：`"proportional"`。 |
| `layout` | 树形布局。`"rectangular"` 为标准矩形布局，`"circular"` 为扇形/环形布局。默认：`"rectangular"`。 |
| `angle` | 数值。环形布局的扇形角度（0–360 度），仅当 `layout = "circular"` 时生效。默认：`360`。 |
| `color_palette` | 调色板指定方式，可为：<br>- 调色板名称：`"viridis"`（默认）、`"rainbow"`，或任意 RColorBrewer 调色板名称（如 `"Set1"`、`"Paired"`）<br>- 十六进制颜色码字符向量（长度不足时循环使用） |
| `color_mapping` | 具名字符向量，指定各分组的具体颜色。优先级高于 `color_palette`，名称需与分组名一致。示例：`c("Proteobacteria" = "#E41A1C", "Firmicutes" = "#377EB8")`。 |
| `line_width` | 数值。分支线宽（传给 ggtree）。默认：`1`。 |
| `show_tip_labels` | 逻辑值。是否显示末端标签。默认：`FALSE`（末端数超过 100 的树建议关闭）。 |
| `tip_label_size` | 数值。末端标签字号。默认：`2`。 |
| `add_timescale` | 逻辑值。是否在 x 轴添加地质时间轴。需要矩形布局与有效枝长。默认：`TRUE`。 |
| `timescale_levels` | 字符向量。要显示的地质时间轴层级，可选 `"eras"`、`"eons"`、`"periods"`。默认：`c("eras", "eons")`。 |
| `unit` | 输入树的枝长的时间单位：`"Ga"`（十亿年）或 `"Ma"`（百万年）。**当 `add_timescale = TRUE` 时必须显式指定**：若 `unit` 为 `NULL`，流水线会中止，因为 Rclade 不推断枝长单位，也不验证输入树是否为经过时间校准的时间树（chronogram）。取 `"Ga"` 时枝长自动换算为 Ma（乘以 1000）。`NULL` 保持树的原生单位不变，仅在与 `add_timescale = FALSE` 配合时有效。Rclade 仅展示用户提供的时间校准，从不推断分化时间。默认：`NULL`。 |
| `taxonomy_format` | 字符。分类标签格式。`"auto"` 通过前缀匹配启发式自动探测格式。手动可选项：`"GTDB"`、`"Silva"`、`"NCBI"`、`"custom_rank"`、`"custom_regex"`。默认：`"auto"`。 |
| `custom_patterns` | 具名正则表达式列表，用于自定义格式的解析；当 `taxonomy_format = "custom_regex"` 时必填。示例：`list(domain = "Domain:([^\|]+)", phylum = "Phylum:([^\|]+)")`。 |
| `taxonomy_file` | 字符。外部分类学文件路径。文件应含两列：（1）末端标签；（2）GTDB 格式的分类串（如 `d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria`）。支持制表符分隔或逗号分隔的文件。提供该文件后，它会补充或覆盖基于标签的解析结果。默认：`NULL`。 |
| `taxonomy_file_sep` | 字符。分类文件的列分隔符。`"auto"` 会自动检测制表符或逗号。默认：`"auto"`。 |
| `taxonomy_file_header` | 逻辑值。分类文件是否含表头行。默认：`FALSE`。 |
| `taxonomy_file_priority` | 逻辑值。为 `TRUE`（默认）时，文件中的分类信息优先于基于标签的解析；为 `FALSE` 时，文件仅用于那些无法从树上标签解析出的末端。默认：`TRUE`。若提供了 `taxonomy_source_priority`，则以其为准。 |
| `taxonomy_source_priority` | 字符。当内嵌（基于标签）与表格（基于文件）两种分类信息都可用时，优先使用哪一来源：`"embedded"` 或 `"table"`。默认：`NULL`（改用 `taxonomy_file_priority`）。 |
| `taxonomy_table_sep` | 字符。外部分类文件第二列中各阶元之间的分隔符。默认：`";"`。 |
| `taxonomy_delimiter_mode` | 字符。内嵌标签（格式 A）的解析策略：`"reverse"`（由右向左解析，默认）、`"greedy"`（由左向右）或 `"segment"`（在分隔符之间逐段提取）。 |
| `legend_position` | 图例位置。可为方位词（`"bottom"`、`"top"`、`"right"`、`"left"`、`"none"`），也可为长度为 2 的数值向量 `c(x, y)` 以将图例放在绘图区域内部（需 ggplot2 >= 3.5）。默认：`"bottom"`（横向排布）。 |
| `legend_nrow` | 整数。图例网格的行数；为 `NULL` 时自动计算。 |
| `legend_ncol` | 整数。图例网格的列数；为 `NULL` 时自动计算。 |
| `legend_title` | 字符。自定义图例标题。为 `NULL` 时自动使用阶元名称（如 "Phylum"、"Class"）。默认：`NULL`。 |
| `clade` | 字符。要折叠的特定演化支名称（如 `"Cyanobacteriota"`）。提供后仅检查该演化支的单系性（monophyly），并在有效时折叠它。与 `rank`、`groups` 互斥。默认：`NULL`。 |
| `strict` | 逻辑值。为 `TRUE` 时，非单系演化支会报错终止；为 `FALSE` 时，非单系演化支仅触发告警并被跳过。默认：`FALSE`。采用宽容默认值是有意为之：在交互探索末端众多、分类信息可能不准的大树时，遇到首个非单系群就中止会让用户看不到任何结果；在要求分类完整性的生产流水线中应使用 `TRUE`。 |
| `groups` | 具名列表，指定用于折叠的自定义末端分组。每个元素是一个字符向量，给出属于该分组的末端标签。各分组必须构成单系群，非单系分组会报错。提供 `groups` 时，`rank` 会被忽略（应将其设为 `"none"`）。示例：`list("Group_A" = c("tip1", "tip2"), "Group_B" = c("tip3"))`。 |
| `groups_label_only` | 逻辑值。为 `TRUE` 时，`groups` 定义的演化支只加标注而不折叠：成员分支保持完全展开，仅在旁边画出分组名称。默认：`FALSE`。 |
| `show_clade_label` | 逻辑值。是否在折叠三角形旁添加演化支标签，显示分组名称与物种数目。默认：`FALSE`。 |
| `show_clade_count` | 逻辑值。是否在演化支标签中显示物种数目（如 "Proteobacteria (n=42)"）。仅当 `show_clade_label = TRUE` 时生效。默认：`TRUE`。 |
| `clade_label_offset` | 数值。演化支标签相对折叠三角形右边缘的水平偏移，单位为 Ma（取值范围 0–5000）。默认：`50`。 |
| `clade_label_fontsize` | 数值。演化支标签的字号（取值范围 1–20）。默认：`3`。 |
| `show_support` | 逻辑值。是否显示节点支持值（support value）。需要带后验/bootstrap 支持值注解的 `treedata` 输入。默认：`FALSE`。 |
| `support_threshold` | 数值。显示支持值所需的最小阈值（0–1）。默认：`0.95`。 |
| `show_hpd` | 逻辑值。是否显示 HPD（最高后验密度）区间。需要带 HPD 注解的节点数据。默认：`FALSE`。 |
| `hpd_color` | HPD 条的颜色。默认：`"firebrick"`。 |
| `geo_events` | 用于标注地质事件的数据框，列需含 `name`、`age_min`、`age_max`（Ma）、`color`；为 `TRUE` 时显示默认事件（GOE=2400–2000 Ma，NOE=800–550 Ma）。默认：`FALSE`。 |
| `timescale_version` | 字符。地质时间轴版本字符串。目前仅支持 `"ICS 2023/02"`。默认：`"ICS 2023/02"`。 |
| `main_title` | 字符。图的主标题。默认：`NULL`（不绘制标题）。 |
| `sub_title` | 字符。图的副标题。默认：`NULL`（不绘制副标题）。 |
| `highlight` | 字符向量，指定要用彩色背景高亮的分组名称。只有单系群会被高亮，非单系群会触发告警。支持特殊标识符：`"ROOT"`（树的根节点）、`"LUCA"`（最后通用共同祖先，Last Universal Common Ancestor）、`"LACA"`（最后古菌共同祖先，Last Archaeal Common Ancestor）、`"LBCA"`（最后细菌共同祖先，Last Bacterial Common Ancestor）。默认：`NULL`（不高亮）。 |
| `highlight_alpha` | 数值。高亮颜色的透明度（0–1）。默认：`0.2`。 |
| `theme_fun` | 主题函数或 `NULL`。设为 `NULL` 时使用 ggplot2 默认主题。默认：`theme_timetree`。 |
| `output` | 可选的输出文件路径。提供时立即保存该图（向后兼容用法）。默认：`NULL`。 |
| `overwrite` | 字符。当 `output` 文件已存在时的覆盖模式：`"ask"`（默认，交互式询问；在非交互会话中降级为 `"no-clobber"`，即跳过保存并仅告警，不会报错）、`"force"`（覆盖写入）或 `"no-clobber"`（跳过保存）。会传给 `save_timetree()`。 |
| `width` | 输出宽度（英寸）。默认：`14`。 |
| `height` | 输出高度（英寸）。默认：`10`。 |
| `taxonomy_levels` | 可选列表，用于自定义分类阶元的代码与名称，例如 `list(codes = c("k", "ss"), names = c("kingdom", "subspecies"))`。其中 `codes` 是标签中使用的缩写记号（如 `"k"`、`"ss"`），`names` 是可读的阶元名称，用作结果数据框的列名。用于扩展或覆盖默认的阶元处理。默认：`NULL`。 |
| `low_memory` | 逻辑值。为 `TRUE` 时启用尽力而为的低内存模式，在流水线的主要步骤之间触发垃圾回收。默认：`FALSE`。 |
| `ignore_malformed` | 逻辑值。为 `TRUE` 时，畸形输入仅告警跳过而不终止流程。在批量模式下，失败的树会以 `NULL` 返回。默认：`FALSE`。 |
| `ignore_branch_length` | 逻辑值。为 `TRUE` 时忽略枝长，按支序图（cladogram）绘制，所有末端对齐到同一 x 位置（等价于 ggtree 的 `branch.length = "none"`）。这会自动关闭地质时间轴。默认：`FALSE`。 |
| `color_rank` | 字符。用于着色的分类阶元，独立于控制折叠的 `rank`。设置后（如 `"phylum"`），分支与末端按该阶元着色，而折叠仍使用 `rank`。为 `NULL`（默认）时，`rank` 同时用于着色与折叠。 |
| `timescale_mode` | 字符。环形布局下地质时间轴的显示模式。`"radial"`（默认）画出整圈的地质背景带；`"linear"` 通过 `deeptime::guide_geo()` 在 `timescale_position` 指定的位置画出直角形的地质时间轴，且不画背景带。矩形布局下忽略。 |
| `timescale_position` | 字符。当 `timescale_mode = "linear"` 时地质时间轴所在的时钟方位。可选项：`"right"`（3 点方向，默认）、`"top"`（12 点方向）、`"bottom"`（6 点方向）、`"left"`（9 点方向）。应与 `tree_start_position` 一致。当 `timescale_mode = "radial"` 或矩形布局时忽略。 |
| `tree_start_position` | 字符。环形布局中树开始展开的时钟方位（即最后一个末端与第一个末端之间的缺口）。可选项：`"right"`（3 点方向，默认）、`"top"`（12 点方向）、`"bottom"`（6 点方向）、`"left"`（9 点方向）。当 `timescale_mode = "linear"` 时应与 `timescale_position` 一致，否则发出告警。矩形布局下忽略。 |
| `opts` | `rclade_options` 对象（见 `rclade_options()`）或参数默认值的具名列表。提供时，`opts` 中的值会为调用方未显式设置的参数充当默认值；显式传入的参数始终优先。这是在多次调用之间复用同一套参数的推荐方式。默认：`NULL`。 |

**返回值：**

返回一个 `ggplot` 对象，其 `rclade_info` 属性包含元数据（末端数、分组数、分类格式等）。
可继续用 `+` 叠加图层做进一步定制。

**示例：**

```r
# 从文件绘制，按门（phylum）阶元折叠
p <- plot_timetree("my_tree.tre", rank = "phylum", unit = "Ma")

# 从带 GTDB 标签的 phylo 对象绘制
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB", add_timescale = FALSE)

# 指定外部分类学文件
p <- plot_timetree("my_tree.tre", rank = "phylum", unit = "Ma",
                   taxonomy_file = "taxonomy.tsv")

# 关闭地质时间轴，改用自定义调色板
p2 <- plot_timetree(example_tree, rank = "class",
                    add_timescale = FALSE, color_palette = "Set1")

# 处理多树文件：仅使用第一棵树
p <- plot_timetree("beast.trees", rank = "phylum", unit = "Ma",
                   multi_tree_mode = "first")

# 处理多树文件：分析全部树
plots <- plot_timetree("beast.trees", rank = "phylum", unit = "Ma",
                       multi_tree_mode = "all")

# 直接保存结果
plot_timetree(tree, rank = "phylum", unit = "Ma", output = "output.pdf")
```


---

## `batch_plot`

**批量绘制目录下所有树文件**

遍历输入目录中的树文件，对每个文件调用 `plot_timetree()` 并保存到输出目录，支持通配符匹配与覆盖模式控制。

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
  ignore_malformed = FALSE,
  ...
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `input_dir` | 包含树文件的输入目录。 |
| `output_dir` | 图表输出目录。 |
| `pattern` | 文件匹配模式（glob 格式，如 `"*.tre"`）。 |
| `format` | 输出格式：`"pdf"`、`"png"`、`"tiff"`、`"svg"`、`"eps"`。默认：`"pdf"`。 |
| `width` | 输出宽度（英寸）。默认：`14`。 |
| `height` | 输出高度（英寸）。默认：`10`。 |
| `overwrite` | 覆盖模式：`"ask"`（默认）/ `"force"` / `"no-clobber"`。 |
| `ignore_malformed` | 逻辑值。为 `TRUE` 时，畸形的树输入仅告警跳过，而不会中断整批处理，与 CLI 的 `--ignore_malformed` 行为一致。默认：`FALSE`。 |
| `...` | 传递给 `plot_timetree()` 的额外参数。 |

**返回值：**

在输出目录为每个树生成图表文件，并不可见地返回成功/失败状态列表。

**示例：**

```r
# 批量绘制目录下所有 .tre 文件，按门折叠
batch_plot(input_dir = "trees/", output_dir = "plots/",
           pattern = "*.tre", rank = "phylum", unit = "Ma")
```


---

## `save_timetree`

**将时间树图保存到文件**

将 `plot_timetree()` 返回的 `ggplot` 对象保存为磁盘文件，自动按扩展名选择设备并支持覆盖模式。

**用法：**

```r
save_timetree(p, file, width = 14, height = 10, dpi = 300, overwrite = "ask")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `p` | `ggplot` 对象（通常由 `plot_timetree()` 返回）。 |
| `file` | 输出文件路径。 |
| `width` | 宽度（英寸）。默认：`14`。 |
| `height` | 高度（英寸）。默认：`10`。 |
| `dpi` | 分辨率（仅 PNG/TIFF 生效）。默认：`300`。 |
| `overwrite` | 字符。覆盖模式：`"ask"`（默认，交互式询问；非交互会话降级为 `"no-clobber"`，即跳过保存并仅告警，不报错）/ `"force"` / `"no-clobber"`。 |

**返回值：**

将图表写入文件，并不可见地返回 `ggplot` 对象。

**示例：**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
save_timetree(p, file = "tree.pdf", width = 12, height = 8)
```


---

## `summarize_timetree`

**打印时间树图的摘要信息**

读取 `plot_timetree()` 结果中附带的 `rclade_info` 属性，打印末端数量、折叠的演化支（clade）数、分类格式、折叠阶元、调色板、布局与时间轴状态等关键信息。

**用法：**

```r
summarize_timetree(p)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `p` | `plot_timetree()` 返回的 `ggplot` 对象（带 `rclade_info` 属性）。 |

**返回值：**

将摘要打印到控制台，并不可见地返回内部的 `rclade_info` 列表。

**示例：**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
summarize_timetree(p)
```


---

## `theme_timetree`

**时间树图的出版级主题**

基于 `ggtree::theme_tree2()` 定制，面向出版质量（字体、网格、边距等）。其中包含 `coord_cartesian(clip = "off")`，用于防止折叠的演化支三角形在绘图面板边界处被裁切——三角形的顶点（尤其是 MRCA 节点顶点）常常超出以末端为基准的 y 轴范围。注意：它返回含 `theme` 与 `coord` 两个组件的列表，不能直接整体用 `+` 叠加，需分别应用（见下方示例）。

**用法：**

```r
theme_timetree(base_size = 12)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `base_size` | 数值。基础字号。默认：`12`。 |

**返回值：**

返回含 `theme`（ggplot2 主题）与 `coord`（`coord_cartesian(clip = "off")`）两个组件的列表。调用方应通过 `p + r$theme + r$coord` 同时应用两者。

**示例：**

```r
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum", unit = "Ma")
r <- theme_timetree(base_size = 14)
print(p + r$theme + r$coord)
```


---


---

[英文](../../en/reference/core-visualization.md) | [文档首页](../index.md)
