# 分类学解析

检测标签格式、解析分类学标签、将分组解析为最近共同祖先（MRCA），并校验自定义分组。

本模块包含以下函数：

- [`detect_taxonomy_format`](#detect_taxonomy_format) — 从末端标签检测分类学格式
- [`parse_taxonomy`](#parse_taxonomy) — 分类学解析统一入口
- [`resolve_group`](#resolve_group) — 将分组名解析为 MRCA 节点
- [`resolve_special_identifier`](#resolve_special_identifier) — 解析特殊祖先节点标识符
- [`build_group_vec`](#build_group_vec) — 从自定义分组构建分组向量
- [`validate_custom_groups`](#validate_custom_groups) — 校验用于折叠的自定义分组
- [`summarize_taxonomy_quality`](#summarize_taxonomy_quality) — 汇报分类标签解析质量
- [`summarize_taxonomy_quality_with_file`](#summarize_taxonomy_quality_with_file) — 结合外部文件汇报分类解析质量
- [`read_taxonomy_file`](#read_taxonomy_file) — 从表格文件读取分类学信息
- [`validate_taxonomy_no_cycles`](#validate_taxonomy_no_cycles) — 检测分类表中的循环依赖

## `detect_taxonomy_format`

**从末端标签检测分类学格式**

基于前缀匹配启发式，自动判断一组末端标签所属的分类学格式（GTDB / Silva / NCBI / embedded 等）。

**用法：**

```r
detect_taxonomy_format(labels)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `labels` | 末端标签字符向量。 |

**返回值：**

返回检测到的格式字符串（如 "GTDB"）。

**示例：**

```r
labels <- c("d__Bacteria;p__Firmicutes",
              "d__Bacteria;p__Proteobacteria")
detect_taxonomy_format(labels)
```


---

## `parse_taxonomy`

**分类学解析统一入口**

解析末端标签中指定阶元的分类学名称，是读取分类信息的统一函数，支持自动/GTDB/Silva/NCBI/custom 多种格式。

**用法：**

```r
parse_taxonomy(
  labels,
  rank,
  format = "auto",
  custom_patterns = NULL,
  taxonomy_levels = NULL,
  delimiter_mode = "reverse"
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `labels` | 末端标签字符向量。 |
| `rank` | 目标分类阶元（缩写或全称）。 |
| `format` | 格式：auto / embedded / GTDB / Silva / NCBI / custom_rank / custom_regex。 |
| `custom_patterns` | custom_regex 格式所需的正则列表。 |
| `taxonomy_levels` | 自定义分类阶元配置列表。 |
| `delimiter_mode` | 嵌入标签解析策略：reverse / greedy / segment。 |

**返回值：**

返回含 label、Group 两列的数据框（data.frame）。

**示例：**

```r
labels <- c("d__Bacteria;p__Firmicutes;c__Bacilli",
              "d__Bacteria;p__Proteobacteria")
parse_taxonomy(labels, rank = "phylum", format = "GTDB")
```


---

## `resolve_group`

**将分组名解析为 MRCA 节点**

把分类分组名（或特殊标识符）解析为树中对应的最近共同祖先节点，供折叠、高亮等操作使用。

**用法：**

```r
resolve_group(
  tree,
  group,
  rank = "domain",
  format = "auto",
  quiet = FALSE,
  delimiter_mode = "reverse",
  custom_patterns = NULL,
  taxonomy_levels = NULL
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `tree` | phylo 对象。 |
| `group` | 分组名或特殊标识符。 |
| `rank` | 分类阶元（特殊标识符忽略此项）。 |
| `format` | 标签格式，默认 auto。 |
| `quiet` | 为 TRUE 时静默消息。 |
| `delimiter_mode` | 嵌入标签解析策略：reverse / greedy / segment。 |
| `custom_patterns` | custom_regex 格式所需的具名正则列表。 |
| `taxonomy_levels` | 自定义分类阶元配置列表。 |

**返回值：**

返回列表，含 is_monophyletic（是否单系）、group（分组名/标识符）、is_special（是否特殊标识符）、node（MRCA 节点号整数或 NULL）、n_tips（分组末端数）、outsiders（MRCA 中不属于该分组的末端）等组件。

**示例：**

```r
data(example_tree)
resolve_group(example_tree, group = "Firmicutes", rank = "phylum")
```


---

## `resolve_special_identifier`

**解析特殊祖先节点标识符**

将 ROOT / LUCA / LACA / LBCA 等特殊标识符解析为对应的树节点，用于在生命之树中高亮关键祖先。

**用法：**

```r
resolve_special_identifier(
  tree,
  identifier,
  format = "auto",
  quiet = FALSE,
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `tree` | phylo 对象。 |
| `identifier` | 特殊标识符之一：ROOT / LUCA / LACA / LBCA。 |
| `format` | 标签格式，默认 auto。 |
| `quiet` | 为 TRUE 时静默消息。 |
| `delimiter_mode` | 嵌入标签解析策略：reverse / greedy / segment。 |
| `taxonomy_levels` | 自定义分类阶元配置列表。 |

**返回值：**

返回列表，含 node（MRCA 节点号整数或 NULL）、identifier（标识符名）、description（可读描述）、n_tips（后代末端数）、tip_labels（后代末端标签向量）等组件。

**示例：**

```r
data(example_tree)
resolve_special_identifier(example_tree, identifier = "LUCA")
```


---

## `build_group_vec`

**从自定义分组构建分组向量**

把“分组名 -> 末端标签向量”的具名列表转换为与树末端一一对应的分组向量，便于着色与折叠。

**用法：**

```r
build_group_vec(groups, tip_labels)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `groups` | 每个元素为某分组末端标签向量的具名列表。 |
| `tip_labels` | 树中所有末端标签的字符向量。 |

**返回值：**

返回具名字符向量：名称为末端标签，值为分组名，未分组的末端为 NA。

**示例：**

```r
tips <- c("A", "B", "C", "D")
groups <- list(g1 = c("A", "B"), g2 = c("C", "D"))
build_group_vec(groups, tips)
```


---

## `validate_custom_groups`

**校验用于折叠的自定义分组**

检查用户提供的自定义分组在树中是否均为单系；非单系分组会在折叠时引发错误，提前校验可避免运行失败。

**用法：**

```r
validate_custom_groups(tree, groups)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `tree` | phylo 对象。 |
| `groups` | 具名列表，每个元素是该分组的末端标签向量。 |

**返回值：**

若全部校验通过则不可见地返回 TRUE；否则以明确错误终止。

**示例：**

```r
data(example_tree)
validate_custom_groups(example_tree,
     list(Group1 = c("tip1", "tip2")))
```


---

## `summarize_taxonomy_quality`

**汇报分类标签解析质量**

统计末端标签的分类学解析覆盖率与缺失情况，帮助评估标签格式是否适合自动折叠。

**用法：**

```r
summarize_taxonomy_quality(
  labels,
  format = "auto",
  custom_patterns = NULL,
  taxonomy_levels = NULL,
  delimiter_mode = "reverse"
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `labels` | 末端标签字符向量。 |
| `format` | 格式：auto / embedded / GTDB / Silva / NCBI / custom_rank / custom_regex。 |
| `custom_patterns` | custom_regex 格式所需的正则列表。 |
| `taxonomy_levels` | 自定义分类阶元配置列表。 |
| `delimiter_mode` | 嵌入标签解析策略：reverse / greedy / segment。 |

**返回值：**

返回解析覆盖率、各阶元缺失数等质量统计。

**示例：**

```r
labels <- c("d__Bacteria;p__Firmicutes",
              "d__Archaea;p__Euryarchaeota")
summarize_taxonomy_quality(labels, format = "GTDB")
```


---

## `summarize_taxonomy_quality_with_file`

**结合外部文件汇报分类解析质量**

在 summarize_taxonomy_quality 基础上支持外部分类文件，对标签无法自解析的末端用文件补全，并统计整体质量。

**用法：**

```r
summarize_taxonomy_quality_with_file(
  labels,
  format = "auto",
  custom_patterns = NULL,
  taxonomy_file = NULL,
  file_sep = "auto",
  file_header = FALSE,
  file_priority = TRUE,
  table_sep = ";",
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `labels` | 末端标签字符向量。 |
| `format` | 格式：auto / GTDB / Silva / NCBI / custom_rank / custom_regex。 |
| `custom_patterns` | custom_regex 格式所需的正则列表。 |
| `taxonomy_file` | 外部分类文件路径，默认 NULL。 |
| `file_sep` | 分类文件列分隔符，默认 auto。 |
| `file_header` | 分类文件是否含表头，默认 FALSE。 |
| `file_priority` | 为 TRUE 时文件分类优先。 |
| `table_sep` | 分类文件中阶元间分隔符，默认分号。 |
| `delimiter_mode` | 嵌入标签解析策略：reverse / greedy / segment。 |
| `taxonomy_levels` | 自定义分类阶元配置列表。 |

**返回值：**

返回结合文件后的分类解析质量统计。

**示例：**

```r
labels <- c("spA", "spB")
summarize_taxonomy_quality_with_file(labels,
     taxonomy_file = "taxonomy.tsv")
```


---

## `read_taxonomy_file`

**从表格文件读取分类学信息**

读取外部分类学表格（两列：末端标签与分类串），支持自动检测分隔符与表头，供 plot_timetree 的 taxonomy_file 参数使用。

**用法：**

```r
read_taxonomy_file(file, sep = "auto", header = FALSE, table_sep = ";")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `file` | 分类表格文件路径。 |
| `sep` | 列分隔符；auto 自动检测制表符或逗号。 |
| `header` | 文件是否含表头行，默认 FALSE。 |
| `table_sep` | 第二列分类串中阶元间的分隔符，默认分号。 |

**返回值：**

返回解析后的分类信息数据框。

**示例：**

```r
df <- read_taxonomy_file("taxonomy.tsv",
                     sep = "\t", header = TRUE)
head(df)
```


---

## `validate_taxonomy_no_cycles`

**检测分类表中的循环依赖**

检查分类学表（父子关系）中是否存在环，若存在循环依赖会导致折叠逻辑错误，提前检测可保证数据一致。

**用法：**

```r
validate_taxonomy_no_cycles(taxa_df, filepath = "<taxonomy>")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `taxa_df` | 含分类列（domain / phylum / class 等）的数据框。 |
| `filepath` | 用于报错信息的来源文件名。 |

**返回值：**

若无环返回 TRUE；否则返回含环路径的诊断信息。

**示例：**

```r
df <- data.frame(child = c("B", "C"), parent = c("A", "B"))
validate_taxonomy_no_cycles(df)
```


---


---

[英文](../../en/reference/taxonomy-parsing.md) | [文档首页](../../index.md)
