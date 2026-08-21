# 树与序列读取及校验

读取树文件、校验序列文件，并检验单系性。

本模块包含以下函数：

- [`read_tree_auto`](#read_tree_auto) — 自动识别格式并读取树文件
- [`validate_sequence_file`](#validate_sequence_file) — 校验序列文件格式
- [`validate_sequence_deep`](#validate_sequence_deep) — 深度校验序列文件
- [`validate_tree_sequence_match`](#validate_tree_sequence_match) — 交叉校验树末端标签与序列 ID
- [`check_monophyly`](#check_monophyly) — 检查分类学分组是否为单系
- [`check_special_monophyly`](#check_special_monophyly) — 检查特殊标识符是否为单系

## `read_tree_auto`

**自动识别格式并读取树文件**

根据扩展名与内容自动检测树文件格式（Newick / Nexus / PhyloXML 等），读取为 phylo 或 multiPhylo 对象，并支持多树文件处理。

> **标签长度防护**：超过 500 字符的 Newick 标签在解析前会被截断为 400 字符 + `_RCLADE_TRUNC` 后缀（并给出警告）。原因：ape 的解析器在 Linux 上遇到超过约 512 字符的标签会使整个 R 进程崩溃。截断后的标签可能无法与外部分类文件或序列 ID 精确匹配，如有需要请提前缩短标签。

**用法：**

```r
read_tree_auto(filepath, tree_index = NULL, multi_tree_mode = "error")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 树文件路径（.tre / .nwk / .newick / .nexus / .nex / .treefile / .xml）。 |
| `tree_index` | 多树对象中使用的树索引；NULL 时由 multi_tree_mode 决定。 |
| `multi_tree_mode` | 多树文件处理方式：error / ask / first / last / random / all / split。 |

**返回值：**

返回 phylo 对象；当 multi_tree_mode 为 "all" 或 "split" 时返回 multiPhylo 对象。

**示例：**

```r
# 自动识别格式并读取
tree <- read_tree_auto("my_tree.nwk")

# 读取 BEAST 后验中的第一棵树
tree1 <- read_tree_auto("beast.trees", multi_tree_mode = "first")
```


---

## `validate_sequence_file`

**校验序列文件格式**

检测序列文件格式（FASTA / FASTQ），返回检测到的格式字符串（"fasta" / "fastq" / "unknown"）。

**用法：**

```r
validate_sequence_file(filepath)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 序列文件路径。 |

**返回值：**

返回检测到的格式字符串："fasta" / "fastq" / "unknown"。

**示例：**

```r
fmt <- validate_sequence_file("aligned.fasta")
fmt
```


---

## `validate_sequence_deep`

**深度校验序列文件**

在格式校验基础上进一步检查字母表类型（DNA/RNA/蛋白质）与对齐一致性，可指定预期字母表。

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
| `expected_alphabet` | 预期字母表：DNA / RNA / protein，或 NULL 自动检测。 |
| `check_alignment` | 为 TRUE 时检查所有序列长度是否一致。 |

**返回值：**

返回更深入的校验结果列表。

**示例：**

```r
validate_sequence_deep("aligned.fasta",
                      expected_alphabet = "DNA",
                      check_alignment = TRUE)
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
| `tree` | phylo 对象或树文件路径。 |
| `sequence_file` | 序列文件路径（FASTA/FASTQ）。 |
| `quiet` | 为 TRUE 时静默消息。 |
| `mol_type` | 分子类型：DNA / RNA / protein / auto。 |
| `skip_length_check` | 为 TRUE 时跳过对齐长度一致性检查。 |
| `multi_tree_mode` | tree 为路径时多树文件的处理方式。 |

**返回值：**

返回包含匹配统计与差异列表的校验结果。

**示例：**

```r
data(example_tree)
validate_tree_sequence_match(example_tree, "seqs.fasta",
                             mol_type = "DNA")
```


---

## `check_monophyly`

**检查分类学分组是否为单系**

解析指定分组名对应的末端标签，检验其在树中是否构成单系群（即全部后代共享同一个 MRCA），支持多种标签格式与层级。

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
| `tree` | phylo 对象。 |
| `group` | 待检查的分类分组名，如 "Firmicutes" 或 "Mammalia"。 |
| `rank` | 分组的分类阶元：domain / phylum / class / order / family / genus / species 或缩写。 |
| `format` | 标签格式：auto / GTDB / Silva / NCBI / custom_rank / custom_regex。 |
| `custom_patterns` | custom_regex 格式所需的具名正则列表。 |
| `quiet` | 为 TRUE 时静默消息。 |
| `delimiter_mode` | 嵌入标签解析策略：reverse / greedy / segment。 |
| `taxonomy_levels` | 自定义分类阶元配置列表。 |

**返回值：**

返回是否单系、MRCA 节点号及相关信息的列表。

**示例：**

```r
data(example_tree)
check_monophyly(example_tree, group = "Firmicutes", rank = "phylum")
```


---

## `check_special_monophyly`

**检查特殊标识符是否为单系**

针对特殊祖先标识符（LUCA / LACA / LBCA 等）检查其在树中是否构成单系群，用于高亮生命之树中的关键节点。

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
| `tree` | phylo 对象。 |
| `identifier` | 特殊标识符之一：LUCA / LACA / LBCA。 |
| `format` | 标签格式，默认 auto。 |
| `quiet` | 为 TRUE 时静默消息。 |
| `delimiter_mode` | 嵌入标签解析策略：reverse / greedy / segment。 |
| `taxonomy_levels` | 自定义分类阶元配置列表。 |

**返回值：**

返回是否单系及节点信息的列表。

**示例：**

```r
data(example_tree)
check_special_monophyly(example_tree, identifier = "LUCA")
```


---


---

[英文](../../en/reference/tree-sequence.md) | [文档首页](../../index.md)
