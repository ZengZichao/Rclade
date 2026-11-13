# 分类学解析

检测标签格式、解析分类学标签、将分组解析为最近共同祖先（MRCA），并校验自定义分组。

本模块包含以下函数：

- [`detect_taxonomy_format`](#detect_taxonomy_format) — 从末端标签检测分类学格式
- [`parse_taxonomy`](#parse_taxonomy) — 分类学解析统一入口
- [`resolve_group`](#resolve_group) — 将分类群名或特殊标识符解析为 MRCA 节点
- [`resolve_special_identifier`](#resolve_special_identifier) — 解析特殊祖先节点标识符
- [`build_group_vec`](#build_group_vec) — 从自定义分组构建分组向量
- [`validate_custom_groups`](#validate_custom_groups) — 校验用于折叠的自定义分组
- [`summarize_taxonomy_quality`](#summarize_taxonomy_quality) — 汇报分类学标签解析质量
- [`summarize_taxonomy_quality_with_file`](#summarize_taxonomy_quality_with_file) — 结合外部文件汇报分类解析质量
- [`read_taxonomy_file`](#read_taxonomy_file) — 从表格文件读取分类学信息
- [`validate_taxonomy_no_cycles`](#validate_taxonomy_no_cycles) — 检测分类表中的循环依赖

> 以下函数为内部函数（未导出）：`resolve_group`、`resolve_special_identifier`、`build_group_vec`、`validate_custom_groups`、`validate_taxonomy_no_cycles`，须以 `Rclade:::resolve_group()` 形式调用。

## `detect_taxonomy_format`

**从末端标签检测分类学格式**

基于内容匹配的启发式规则（而非严格语法），检测末端标签属于 Format A（内嵌式 embedded，如 `_d_Bacteria_p_...`）还是 Format B（分号分隔式，如 `d__Bacteria;p__...`）。

**用法：**

```r
detect_taxonomy_format(labels)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `labels` | 末端标签字符向量。 |

**返回值：**

返回检测到的格式名称：`"embedded"`、`"GTDB"`、`"Silva"`、`"NCBI"` 或 `"unknown"`。检测至多抽样前 100 条标签，是基于内容匹配的启发式判断而非严格语法校验：GTDB 规则匹配未锚定的 `[dpcofgsk]__` 且要求过半标签含分号，embedded 规则匹配 `_[dpcofgsk]_`，仅 NCBI/Silva 判别使用锚定前缀表；GTDB 与 embedded 须明显过半（>0.5，即不低于 0.6）才会被采用。多种情形（标签混合、分号串无法判定为 NCBI/Silva 等）会返回 `"unknown"`，此时需显式指定 `format`。

**示例：**

```r
labels <- c("d__Bacteria;p__Firmicutes",
              "d__Bacteria;p__Proteobacteria")
detect_taxonomy_format(labels)
```


---

## `parse_taxonomy`

**分类学解析统一入口**

解析末端标签中指定阶元的分类学名称，是读取分类信息的统一函数，支持自动/GTDB/Silva/NCBI/custom 多种格式，并返回记录分组归属的数据框。供外部工作流（如 Snakemake/Nextflow）作为稳定库 API 使用。

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
| `format` | 格式：`"auto"` / `"embedded"` / `"GTDB"` / `"Silva"` / `"NCBI"` / `"custom_rank"` / `"custom_regex"`。 |
| `custom_patterns` | `custom_regex` 格式所需的具名正则列表。 |
| `taxonomy_levels` | 自定义分类阶元配置列表（含 `codes` 与 `names` 的 list），默认 `NULL`。 |
| `delimiter_mode` | 字符值，嵌入（Format A）标签解析策略：`"reverse"` / `"greedy"` / `"segment"`，默认 `"reverse"`。 |

**返回值：**

返回含 `label`、`Group` 两列的数据框（data.frame）。

**示例：**

```r
labels <- c("d__Bacteria;p__Firmicutes;c__Bacilli",
              "d__Bacteria;p__Proteobacteria")
parse_taxonomy(labels, rank = "phylum", format = "GTDB")
```


---

## `resolve_group`

**将分类群名或特殊标识符解析为 MRCA 节点**

把分类群（taxonomic group）名或特殊标识符（`ROOT`、`LUCA`、`LACA`、`LBCA`）解析为树中对应的最近共同祖先节点，供折叠、高亮等操作使用。

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
| `tree` | `phylo` 对象。 |
| `group` | 字符值，分类群名或特殊标识符。 |
| `rank` | 分类阶元（特殊标识符忽略此项）。 |
| `format` | 字符值，标签格式，默认 `"auto"`。 |
| `quiet` | 逻辑值，为 `TRUE` 时静默消息，默认 `FALSE`。 |
| `delimiter_mode` | 字符值，嵌入（Format A）标签解析策略：`"reverse"` / `"greedy"` / `"segment"`，默认 `"reverse"`。 |
| `custom_patterns` | `custom_regex` 格式所需的具名正则列表。 |
| `taxonomy_levels` | 自定义分类阶元配置列表（含 `codes` 与 `names` 的 list），默认 `NULL`。 |

**返回值：**

返回包含以下组件的列表：

- **is_monophyletic**：逻辑值，该分组是否为单系群。
- **group**：字符值，分类群名或特殊标识符。
- **is_special**：逻辑值，是否为特殊标识符。
- **node**：整数或 NULL，MRCA 节点号。
- **n_tips**：整数，该分组的末端数。
- **outsiders**：字符向量，MRCA 中不属于该分组的末端。当 `group` 为特殊标识符（`ROOT`/`LUCA`/`LACA`/`LBCA`）时，返回值是形如 `"N tip(s) from <domains>"` 的单元素摘要字符串，而非末端标签。

**示例：**

```r
data(example_tree)

# 常规分类群
result1 <- Rclade:::resolve_group(example_tree, "P1", rank = "phylum")

# 特殊标识符
result2 <- Rclade:::resolve_group(example_tree, "LUCA")
```


---

## `resolve_special_identifier`

**解析特殊祖先节点标识符**

将 `ROOT` / `LUCA` / `LACA` / `LBCA` 等特殊标识符解析为对应的树节点，用于在生命之树中高亮关键祖先节点。所处理的特殊标识符为：

- **LUCA**：最后通用共同祖先（Last Universal Common Ancestor）——所有细菌与古菌的 MRCA
- **LACA**：最后古菌共同祖先（Last Archaeal Common Ancestor）——所有古菌的 MRCA
- **LBCA**：最后细菌共同祖先（Last Bacterial Common Ancestor）——所有细菌的 MRCA

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
| `tree` | `phylo` 对象。 |
| `identifier` | 字符值，特殊标识符之一：`"ROOT"`、`"LUCA"`、`"LACA"`、`"LBCA"`。**ROOT**：根节点；**LUCA**：最后通用共同祖先（所有细菌与古菌的 MRCA）；**LACA**：最后古菌共同祖先（所有古菌的 MRCA）；**LBCA**：最后细菌共同祖先（所有细菌的 MRCA）。 |
| `format` | 字符值，标签格式，默认 `"auto"`。 |
| `quiet` | 逻辑值，为 `TRUE` 时静默消息，默认 `FALSE`。 |
| `delimiter_mode` | 字符值，嵌入（Format A）标签解析策略：`"reverse"` / `"greedy"` / `"segment"`，默认 `"reverse"`。 |
| `taxonomy_levels` | 自定义分类阶元配置列表（含 `codes` 与 `names` 的 list），默认 `NULL`。 |

**返回值：**

不可见地返回包含以下组件的列表：

- **node**：整数或 NULL，MRCA 节点号；未找到时为 NULL。
- **identifier**：字符值，标识符名。
- **description**：字符值，可读的描述文本。
- **n_tips**：整数，后代末端数。
- **tip_labels**：字符向量，后代末端标签。

**示例：**

```r
data(example_tree)
root <- Rclade:::resolve_special_identifier(example_tree, "ROOT")
luca <- Rclade:::resolve_special_identifier(example_tree, "LUCA")
if (!is.null(luca$node)) {
  cat("LUCA found at node", luca$node, "\n")
}
```


---

## `build_group_vec`

**从自定义分组构建分组向量**

把“分组名 -> 末端标签向量”的具名列表转换为 `compute_mrca_map()` 所使用的具名向量格式（与树末端一一对应的分组向量），便于着色与折叠。

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

返回具名字符向量：名称为末端标签，值为分组名，未分组的末端为 `NA`。

**示例：**

```r
tips <- c("A", "B", "C", "D")
groups <- list(g1 = c("A", "B"), g2 = c("C", "D"))
Rclade:::build_group_vec(groups, tips)
```


---

## `validate_custom_groups`

**校验用于折叠的自定义分组**

检查用户提供的自定义分组在树中是否均为单系，且不同分组之间的末端标签不得重叠；任一条件不满足即直接报错。`plot_timetree()` 在传入 `groups` 时会无条件调用本函数（与 `strict` 无关），因此提前校验可避免运行失败。

**用法：**

```r
validate_custom_groups(tree, groups)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `tree` | `phylo` 对象。 |
| `groups` | 具名列表，每个元素是该分组的末端标签向量。 |

**返回值：**

若全部校验通过则不可见地返回 `TRUE`；否则以明确错误终止。

**示例：**

```r
data(example_tree)
Rclade:::validate_custom_groups(example_tree,
     list(C1 = "d__D1;p__P1;c__C1"))
```


---

## `summarize_taxonomy_quality`

**汇报分类学标签解析质量**

给出末端标签可被解析程度的详细报告，包含各阶元的解析率与解析失败的标签，帮助评估标签格式是否适合自动折叠。

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
| `format` | 格式：`"auto"` / `"embedded"` / `"GTDB"` / `"Silva"` / `"NCBI"` / `"custom_rank"` / `"custom_regex"`。 |
| `custom_patterns` | `custom_regex` 格式所需的具名正则列表。 |
| `taxonomy_levels` | 自定义分类阶元配置列表（含 `codes` 与 `names` 的 list），默认 `NULL`。 |
| `delimiter_mode` | 字符值，嵌入（Format A）标签解析策略：`"reverse"` / `"greedy"` / `"segment"`，默认 `"reverse"`。 |

**返回值：**

不可见地返回含解析统计信息的列表。

**示例：**

```r
labels <- c("d__Bacteria;p__Firmicutes",
              "d__Archaea;p__Euryarchaeota")
summarize_taxonomy_quality(labels, format = "GTDB")
```


---

## `summarize_taxonomy_quality_with_file`

**结合外部文件汇报分类解析质量**

在 `summarize_taxonomy_quality()` 基础上支持外部分类文件：默认（`file_priority = TRUE`）以文件中的分类信息覆盖标签解析所得的阶元，`file_priority = FALSE` 时仅补全标签解析失败（NA）的阶元，并统计整体质量。

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
| `format` | 格式：`"auto"` / `"embedded"` / `"GTDB"` / `"Silva"` / `"NCBI"` / `"custom_rank"` / `"custom_regex"`。 |
| `custom_patterns` | `custom_regex` 格式所需的具名正则列表。 |
| `taxonomy_file` | 字符值，外部分类文件路径，默认 `NULL`。 |
| `file_sep` | 字符值，分类文件列分隔符，默认 `"auto"`。 |
| `file_header` | 逻辑值，分类文件是否含表头，默认 `FALSE`。 |
| `file_priority` | 逻辑值，为 `TRUE` 时文件分类优先，默认 `TRUE`。 |
| `table_sep` | 字符值，分类文件中阶元间分隔符，默认 `";"`。 |
| `delimiter_mode` | 字符值，嵌入（Format A）标签解析策略：`"reverse"` / `"greedy"` / `"segment"`，默认 `"reverse"`。 |
| `taxonomy_levels` | 自定义分类阶元配置列表（含 `codes` 与 `names` 的 list），默认 `NULL`。 |

**返回值：**

不可见地返回含解析统计信息的列表。

**示例：**

```r
labels <- c("d__Bacteria;p__Firmicutes",
              "d__Archaea;p__Euryarchaeota")
# 结合外部文件汇报解析质量
summarize_taxonomy_quality_with_file(labels, format = "auto",
                                      taxonomy_file = "taxonomy.tsv")
```


---

## `read_taxonomy_file`

**从表格文件读取分类学信息**

从两列的表格文件读取分类学信息，其中：

- 第一列：末端标签（须与树的末端标签一致）
- 第二列：GTDB 格式的分类串（如 `d__Archaea;p__Thermoproteota;c__Korarchaeia`）

支持制表符分隔与逗号分隔两种文件，列分隔符可自动识别，但表头不会自动识别：默认 `header = FALSE` 会把首行当作数据，若文件含表头须显式设 `header = TRUE`（`plot_timetree()` 对应 `taxonomy_file_header = TRUE`，命令行为 `--taxonomy_file_header`）。缺失阶元以阶元前缀后的空值表示（如缺失种写作 `s__`）。此类文件即 `plot_timetree()` 的 `taxonomy_file` 参数所接受的格式。

**用法：**

```r
read_taxonomy_file(file, sep = "auto", header = FALSE, table_sep = ";")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `file` | 分类表格文件路径。 |
| `sep` | 字符值，列分隔符；`"auto"` 自动检测制表符或逗号，默认 `"auto"`。 |
| `header` | 逻辑值，文件是否含表头行，默认 `FALSE`。 |
| `table_sep` | 字符值，第二列分类串中阶元间的分隔符，默认 `";"`。 |

**返回值：**

返回数据框（data.frame），列为：

- **label**：字符值，取自第一列的末端标签。
- **kingdom**：字符值，界（`k__`）。
- **domain**：字符值，域（`d__`）。
- **phylum**：字符值，门（`p__`）。
- **class**：字符值，纲（`c__`）。
- **order**：字符值，目（`o__`）。
- **family**：字符值，科（`f__`）。
- **genus**：字符值，属（`g__`）。
- **species**：字符值，种（`s__`）。
- **subspecies**：字符值，亚种（`ss__`）。

缺失的阶元为 `NA`。

**示例：**

```r
# 读取制表符分隔的分类文件
taxa <- read_taxonomy_file("taxonomy.tsv")

# 读取含表头的逗号分隔文件
taxa <- read_taxonomy_file("taxonomy.csv", sep = ",", header = TRUE)
```


---

## `validate_taxonomy_no_cycles`

**检测分类表中的循环依赖**

检查分类学表（父子关系）中是否存在环，若存在循环依赖会导致折叠逻辑错误，提前检测可保证数据一致。会检出如下情形：

- 第 1 行：d__A;p__B
- 第 2 行：d__B;p__A

即域/门关系构成环路。检测按由粗到细的顺序逐对检查相邻阶元列，参与检查的列为 `domain`、`phylum`、`class`、`order`、`family`、`genus`、`species`；其他列（如 `kingdom`、`subspecies`）不参与。

**用法：**

```r
validate_taxonomy_no_cycles(taxa_df, filepath = "<taxonomy>")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `taxa_df` | 含分类列（`domain` / `phylum` / `class` 等）的数据框。 |
| `filepath` | 用于报错信息的来源文件名。 |

**返回值：**

无环时不可见地返回 `TRUE`；一旦检测到环即以 `Rclade_validate_error` 报错中止，错误信息给出来源文件、出问题的相邻阶元对，以及最多 3 条形如 `phylum<->class (phylum=Bacteria, class=Firmicutes)` 的环路描述。

**示例：**

```r
taxa <- read_taxonomy_file("taxonomy.tsv")
Rclade:::validate_taxonomy_no_cycles(taxa, "taxonomy.tsv")
```


---


---

[英文](../../en/reference/taxonomy-parsing.md) | [文档首页](../index.md)
