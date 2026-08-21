# 核心概念

本页解释 Rclade 背后的关键概念，帮助你理解各函数参数。

## 分类格式

Rclade 从每个末端的**标签**读取其分类学归属，支持多种格式：

| 格式 | 示例标签 | 检测依据 |
|------|----------|----------|
| GTDB | `d__Bacteria;p__Firmicutes;c__Bacilli` | 前缀 `d__`/`p__`/... |
| Silva | `Bacteria;Firmicutes;Bacilli` | 分号分隔阶元，无代码 |
| NCBI | `cellular organisms; Bacteria; Firmicutes` | 具名阶元 |
| embedded（custom_rank / Format A） | `species_d_Bacteria_p_Firmicutes` | 下划线包裹的单字母代码 `_d_`/`_p_`/... |
| custom_regex | `Domain:Bacteria\|Phylum:Firmicutes` | 用户正则 |

默认自动检测（`taxonomy_format = "auto"`）。如需强制指定，显式设置 `taxonomy_format`。参见 [detect_taxonomy_format](reference/taxonomy-parsing.md) 与 [parse_taxonomy](reference/taxonomy-parsing.md)。

## 基于 MRCA 的折叠

“折叠”指用单个三角形替代整个分支，三角形宽度表示该分支的年龄范围。Rclade 找到共享同一分类分组的所有末端的最近共同祖先（**MRCA**），再为该分支绘制三角形。

折叠有三种方式：

- **按阶元** — `rank = "phylum"` 一次折叠所有门。
- **按命名分组** — `group = list(GroupA = c("tip1","tip2"))` 折叠自定义集合（必须单系；可用 [validate_custom_groups](reference/taxonomy-parsing.md) 校验）。
- **按特定分支** — `clade = "Cyanobacteriota"` 仅折叠该命名分支。

### 单系性很重要

只有**单系**（所有后代共享同一 MRCA）的分组才能被干净折叠。非单系分组默认触发警告并跳过（`strict = FALSE`）；设 `strict = TRUE` 则改为中止。可用 [check_monophyly](reference/tree-sequence.md) 检查。

### 三角形与空间模式

- `triangle_mode`：三角形宽度画法 — `max`、`min`、`mixed`（自适应）、`none`。
- `space_mode`：`proportional` 给大分支更多纵向空间；`equal` 给每个分支相同空间。

## 地质时间轴

Rclade 基于 `deeptime`（ICS 2023/02）在 x 轴添加地质时间轴。

- `unit`：树枝长的时间单位 — `Ma`（百万年）或 `Ga`（十亿年）。为 `NULL` 时按数量级自动推断。
- `timescale_levels`：显示哪些条带 — `eras`、`eons`、`periods`。
- `add_timescale = FALSE` 可关闭（环形布局或 cladogram 时有用）。

## 颜色与图例

- `color_palette`：`viridis`（默认，色盲友好）、任意 RColorBrewer 名称、`rainbow` 或颜色向量。
- `color_mapping`：具名向量用于精确控制，如 `c("Proteobacteria" = "#E41A1C")`。
- `color_rank`：以不同于折叠所用的阶元着色。
- 图例位置与行列数自动计算；可用 `legend_position`、`legend_nrow`、`legend_ncol` 覆盖。图例很大时用 [split_legend](reference/colors-legend.md)。

## 特殊标识符

Rclade 理解生命的关键祖先节点：

- `LUCA` — 最后共同祖先（细菌 + 古菌的 MRCA）
- `LACA` — 最后古菌共同祖先
- `LBCA` — 最后细菌共同祖先

可与 `highlight = "LUCA"` 或 [resolve_special_identifier](reference/taxonomy-parsing.md) 配合使用。

## 外部分类文件

当标签不完整或缺失分类时，可通过 `taxonomy_file` 提供两列表格（`tip_label`，`taxonomy_string`）。参见 [read_taxonomy_file](reference/taxonomy-parsing.md) 与 [summarize_taxonomy_quality_with_file](reference/taxonomy-parsing.md)。

## 下一步

- [教程](tutorials.md) 了解端到端工作流。
- [参考手册索引](reference/index.md) 查看每个函数。
