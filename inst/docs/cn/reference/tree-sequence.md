# 树与序列读取与校验

读取树文件、校验序列文件，并检验单系性。

本模块包含以下函数：

- [`read_tree_auto`](#read_tree_auto) — 自动识别格式并读取树文件
- [`validate_sequence_file`](#validate_sequence_file) — 校验序列文件格式
- [`validate_sequence_deep`](#validate_sequence_deep) — 深度校验序列文件
- [`validate_tree_sequence_match`](#validate_tree_sequence_match) — 交叉校验树末端标签与序列 ID
- [`check_monophyly`](#check_monophyly) — 检查分类群是否为单系
- [`check_special_monophyly`](#check_special_monophyly) — 检查特殊标识符是否为单系

## `read_tree_auto`

**自动识别格式并读取树文件**

根据扩展名与内容自动检测树文件格式（Newick / Nexus / BEAST XML 等），读取为 `phylo` 或 `multiPhylo` 对象，并支持多树文件处理。供外部工作流（如 Snakemake/Nextflow）作为稳定库 API 使用。

> **标签长度防护**：超过 500 字符的 Newick 标签在解析前会被截断为 400 字符 + `_RCLADE_TRUNC` 后缀（并给出警告）。原因：ape 的解析器在 Linux 上遇到超过约 512 字符的标签会使整个 R 进程崩溃。截断后的标签可能无法与外部分类文件或序列 ID 精确匹配，如有需要请提前缩短标签。

**用法：**

```r
read_tree_auto(filepath, tree_index = NULL, multi_tree_mode = "error")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 树文件路径（.tre / .tree / .nwk / .newick / .nexus / .nex / .treefile / .nhx / .xml / .beast）；其他扩展名按内容识别（`#NEXUS`、`<beast`/`<phylogeny`，否则按 Newick 解析）。 |
| `tree_index` | 整数，多树对象（如 BEAST 后验）中要使用的树索引。默认 `NULL`（此时由 `multi_tree_mode` 决定行为）。 |
| `multi_tree_mode` | 字符值，文件中含多棵树时的处理方式，共七种：`"error"`（默认）——报错停止并要求用户指定；`"ask"`——交互式询问用户选择某棵树或某种处理方式，在非交互会话中回退为 `"error"`；`"first"`——使用第一棵树；`"last"`——使用最后一棵树；`"random"`——使用随机抽取的一棵树；`"all"`——返回全部树（`multiPhylo`）；`"split"`——返回全部树（`multiPhylo`），由调用方为每棵树写出带数字后缀的独立输出（如 `output_1.pdf`）。 |

**返回值：**

返回 `phylo` 对象；当 `multi_tree_mode` 为 `"all"` 或 `"split"` 时返回 `multiPhylo` 对象。

**示例：**

```r
# 自动识别格式并读取
tree <- read_tree_auto("my_tree.nwk")

# 读取 BEAST 后验分布中的第一棵树
tree1 <- read_tree_auto("beast.trees", multi_tree_mode = "first")
```


---

## `validate_sequence_file`

**校验序列文件格式**

检测序列文件格式（FASTA / FASTQ），返回检测到的格式字符串（`"fasta"` / `"fastq"` / `"unknown"`）。

**用法：**

```r
validate_sequence_file(filepath)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 序列文件路径。 |

**返回值：**

返回检测到的格式字符串：`"fasta"` / `"fastq"` / `"unknown"`。

**示例：**

```r
format <- validate_sequence_file("sequences.fasta")
```


---

## `validate_sequence_deep`

**深度校验序列文件**

校验 FASTA/FASTQ 文件：格式检测、重复 ID（duplicate IDs）检测、字母表类型（DNA / RNA / 蛋白质）检测，以及对齐长度一致性检查；可指定预期字母表。

**用法：**

```r
validate_sequence_deep(
  filepath,
  expected_alphabet = NULL,
  check_alignment = FALSE
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 序列文件路径。 |
| `expected_alphabet` | 字符值或 `NULL`，预期字母表：`"DNA"` / `"RNA"` / `"protein"`，或 `NULL` 表示自动检测。 |
| `check_alignment` | 逻辑值，为 `TRUE` 时检查所有序列长度是否一致。 |

**返回值：**

返回更深入的校验结果列表。

**示例：**

```r
result <- validate_sequence_deep("sequences.fasta", expected_alphabet = "DNA")
```


---

## `validate_tree_sequence_match`

**交叉校验树末端标签与序列 ID**

检查系统发育树的末端标签与序列文件中的 ID 是否一一对应，捕获缺失或多余的标签，可选分子类型与长度一致性检查。

**用法：**

```r
validate_tree_sequence_match(
  tree,
  sequence_file,
  quiet = FALSE,
  mol_type = NULL,
  skip_length_check = FALSE,
  multi_tree_mode = "error"
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `tree` | `phylo` 对象或树文件路径。 |
| `sequence_file` | 字符值，序列文件路径（FASTA/FASTQ）。 |
| `quiet` | 逻辑值，为 `TRUE` 时静默消息。 |
| `mol_type` | 字符值，序列校验所用分子类型：`"DNA"` / `"RNA"` / `"protein"`，或 `"auto"`（即 `NULL`）。默认 `NULL`。 |
| `skip_length_check` | 逻辑值，为 `TRUE` 时跳过对齐长度一致性检查。默认 `FALSE`。 |
| `multi_tree_mode` | 字符值，当 `tree` 为路径时多树文件的处理方式。默认 `"error"`。 |

**返回值：**

返回包含匹配统计与差异列表的校验结果。

**示例：**

```r
result <- validate_tree_sequence_match("tree.nwk", "sequences.fasta")
```


---

## `check_monophyly`

**检查分类群是否为单系**

检验属于指定分类群的全部末端在树中是否构成一个单系的演化支（clade），即这些末端的最近共同祖先（MRCA）的全部后代都只属于该分组，支持多种标签格式与阶元。

**用法：**

```r
check_monophyly(
  tree,
  group,
  rank,
  format = "auto",
  custom_patterns = NULL,
  quiet = FALSE,
  delimiter_mode = "reverse",
  taxonomy_levels = NULL
)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `tree` | `phylo` 对象。 |
| `group` | 字符值，待检查的分类群名（如 `"P1"`、`"Mammalia"`）。 |
| `rank` | 字符值，分组所属的分类阶元：`"kingdom"` / `"domain"` / `"phylum"` / `"class"` / `"order"` / `"family"` / `"genus"` / `"species"` / `"subspecies"`，或缩写 `"k"` / `"d"` / `"p"` / `"c"` / `"o"` / `"f"` / `"g"` / `"s"` / `"ss"`。 |
| `format` | 字符值，分类学标签格式：`"auto"` / `"embedded"` / `"GTDB"` / `"Silva"` / `"NCBI"` / `"custom_rank"` / `"custom_regex"`。默认 `"auto"`。 |
| `custom_patterns` | `custom_regex` 格式所需的具名正则列表，当 `format = "custom_regex"` 时必选。 |
| `quiet` | 逻辑值，为 `TRUE` 时静默消息，默认 `FALSE`。 |
| `delimiter_mode` | 字符值，嵌入（Format A）标签解析策略：`"reverse"`（自右向左，默认）、`"greedy"`（自左向右）或 `"segment"`（逐段提取，即按分隔符之间截取）。 |
| `taxonomy_levels` | 自定义分类阶元配置列表（含 codes 与 names 的 list）。默认 `NULL`。 |

**返回值：**

不可见地返回包含以下组件的列表：

- **is_monophyletic**：逻辑值，该分组是否为单系群。
- **group**：字符值，分类群名。
- **n_tips**：整数，属于该分组的末端数。
- **mrca_node**：整数或 `NULL`，MRCA 节点号；仅当没有末端属于该分组时为 `NULL`（分组只含 1 个末端时返回该末端的节点号）。
- **outsiders**：字符向量，MRCA 所在演化支中不属于该分组的末端（单系时为空）。

**示例：**

```r
data(example_tree)

# 检查门（phylum）P1 是否为单系
result <- check_monophyly(example_tree, "P1",
                           rank = "phylum", format = "GTDB")
if (result$is_monophyletic) {
  cat("P1 is monophyletic!\n")
} else {
  cat("P1 is NOT monophyletic.\n")
}
```


---

## `check_special_monophyly`

**检查特殊标识符是否为单系**

检查由特殊标识符（`LUCA` / `LACA` / `LBCA`）确定的目标域（domain）的 MRCA 是否只包含来自这些域的末端，即相对于目标域是否为单系；用于在生命之树中高亮关键祖先节点。

**用法：**

```r
check_special_monophyly(
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
| `identifier` | 字符值，特殊标识符之一：`"ROOT"`、`"LUCA"`、`"LACA"`、`"LBCA"`。其中 `"ROOT"` 亦被接受，且因其恒包含树中全部末端，故总是单系。 |
| `format` | 字符值，标签格式，默认 `"auto"`。 |
| `quiet` | 逻辑值，为 `TRUE` 时静默消息，默认 `FALSE`。 |
| `delimiter_mode` | 字符值，嵌入（Format A）标签解析策略：`"reverse"` / `"greedy"` / `"segment"`，默认 `"reverse"`。 |
| `taxonomy_levels` | 自定义分类阶元配置列表（含 codes 与 names 的 list）。默认 `NULL`。 |

**返回值：**

不可见地返回包含以下组件的列表：

- **is_monophyletic**：逻辑值，该分组是否为单系群。
- **identifier**：字符值，标识符名。
- **node**：整数或 NULL，MRCA 节点号。
- **n_tips**：整数，目标域中的末端数。
- **n_outsiders**：整数，MRCA 所在演化支中不属于目标域的末端个数。
- **outsider_domains**：字符向量，上述不属于目标域的末端所属的域。

**示例：**

```r
data(example_tree)
result <- check_special_monophyly(example_tree, "LBCA")
if (result$is_monophyletic) {
  cat("LBCA is monophyletic!\n")
}
```


---


---

[英文](../../en/reference/tree-sequence.md) | [文档首页](../index.md)
