# 核心概念

本页解释 Rclade 背后的关键概念，帮助你理解各函数参数。

## 分类格式

Rclade 从每个末端的**标签**读取其分类学归属，支持多种格式：

| 格式 | 示例标签 | 检测依据 |
|------|----------|----------|
| GTDB | `d__Bacteria;p__Firmicutes;c__Bacilli` | 前缀 `d__`/`p__`/... 且分号占多数 |
| Silva | `Bacteria;Firmicutes;Bacilli` | 分号分隔阶元、无代码，且以 `Bacteria`/`Archaea`/`Eukaryota` 开头 |
| NCBI | `cellular organisms; Bacteria; Firmicutes` | 以 NCBI 根词（`cellular organisms`、`root` 等）开头的分号阶元 |
| embedded（custom_rank / Format A） | `species_d_Bacteria_p_Firmicutes` | 下划线包裹的单字母代码 `_d_`/`_p_`/... |
| custom_regex | `Domain:Bacteria\|Phylum:Firmicutes` | 用户正则 |

默认自动检测（`taxonomy_format = "auto"`）。如需强制指定，显式设置 `taxonomy_format`。参见 [detect_taxonomy_format](reference/taxonomy-parsing.md) 与 [parse_taxonomy](reference/taxonomy-parsing.md)。

## 基于 MRCA 的折叠

“折叠”指用单个三角形替代整个演化支（clade），三角形宽度表示该演化支的年龄范围。Rclade 找到共享同一分类群的所有末端的最近共同祖先（**MRCA**），再为该演化支绘制三角形。

折叠有三种方式：

- **按阶元** — `rank = "phylum"` 一次折叠所有门。
- **按命名分组** — `groups = list(GroupA = c("tip1","tip2"))` 折叠自定义集合（必须单系；可用 [validate_custom_groups](reference/taxonomy-parsing.md) 校验）。
- **按特定演化支** — `clade = "Cyanobacteriota"` 仅折叠该命名演化支。

### 单系性很重要

只有**单系**（所有后代共享同一 MRCA）的分组才能被干净地折叠。按 `rank` 或 `clade` 折叠时，非单系分组默认触发警告并跳过（`strict = FALSE`）；设 `strict = TRUE` 则改为中止。自定义 `groups` 会先行校验，其中非单系分组一律直接报错。可用 [check_monophyly](reference/tree-sequence.md) 检查。

### 三角形与空间模式

- `triangle_mode`：三角形宽度的绘制方式 — `max`、`min`、`mixed`（自适应）、`none`。
- `space_mode`：`proportional` 给较大的演化支更多纵向空间；`equal` 给每个演化支相同空间。

## 地质时间轴

Rclade 基于 `deeptime`（ICS 2023/02）在 x 轴添加地质时间轴。

- `unit`：枝长的时间单位 — `Ma`（百万年）或 `Ga`（十亿年）。只要 `add_timescale = TRUE` 就必须显式给出：Rclade 不会推断单位，不填（保持 `NULL`）会直接中止。
- `timescale_levels`：显示哪些条带 — `eras`、`eons`、`periods`。
- `add_timescale = FALSE` 可关闭该功能。环形布局同样支持时间轴（默认 `timescale_mode = "radial"`），因此仅在需要纯净扇形图（如支序图 cladogram）时才关闭。

## 颜色与图例

- `color_palette`：`viridis`（默认，色盲友好）、任意 RColorBrewer 名称、`rainbow` 或颜色向量。
- `color_mapping`：具名向量用于精确控制，如 `c("Proteobacteria" = "#E41A1C")`。
- `color_rank`：以不同于折叠所用的阶元着色。
- 图例行列数按分组数自动计算（位置默认 `"bottom"`）；可用 `legend_position`、`legend_nrow`、`legend_ncol` 覆盖。图例很大时参见 [split_legend](reference/colors-legend.md)。

## 特殊标识符

Rclade 理解生命的祖先节点：

- `LUCA` — 最后通用共同祖先（细菌 + 古菌的 MRCA）
- `LACA` — 最后古菌共同祖先
- `LBCA` — 最后细菌共同祖先

可与 `highlight = "LUCA"` 或 [resolve_special_identifier](reference/taxonomy-parsing.md) 配合使用。

## 外部分类文件

当标签不完整或缺失分类时，可通过 `taxonomy_file` 提供两列文件（第 1 列为末端标签，第 2 列为 GTDB 格式分类字符串）。参见 [read_taxonomy_file](reference/taxonomy-parsing.md) 与 [summarize_taxonomy_quality_with_file](reference/taxonomy-parsing.md)。

## 下一步

- [教程](tutorials.md) 了解端到端工作流。
- [参考手册索引](reference/index.md) 查看每个函数。
