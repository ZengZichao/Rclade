# Rclade

[English](README.EN.md) | [中文](README.CN.md)

<!-- badges: start -->
[![R package](https://img.shields.io/badge/R-包-blue.svg)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/许可证-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/版本-1.0.0-green.svg)]()
<!-- badges: end -->

> **说明：** GitHub 仓库位于 https://github.com/zengzichao/Rclade，问题反馈请提交至 https://github.com/zengzichao/Rclade/issues。

Rclade 提供单函数调用的系统发育树自动折叠与地质时间轴可视化流水线。专为**深时系统发育组学**和**微生物进化研究**设计，支持在地质时间尺度（Ga/Ma）上可视化分类学关系，基于 GTDB、Silva 或 NCBI 分类系统自动折叠分支。

## 详细文档

在线 pkgdown 文档站（函数参考、文章、更新日志）由 `main` 分支自动构建：<https://zengzichao.github.io/Rclade>。

除本页快速参考外，Rclade 还随包发布了一套完整的中英双语使用文档（含各函数参考、教程、示例集锦与常见问题），位于 `inst/docs/`：

- 中文文档总览：[inst/docs/cn/index.md](inst/docs/cn/index.md)
- English documentation：[inst/docs/en/index.md](inst/docs/en/index.md)
- 函数参考（中文）：[inst/docs/cn/reference/index.md](inst/docs/cn/reference/index.md)
- Function reference (EN)：[inst/docs/en/reference/index.md](inst/docs/en/reference/index.md)

## 功能特性

- **自动分类标签解析**：启发式检测 GTDB、Silva、NCBI 及自定义格式
- **双格式分类学**：格式A（嵌入式 `_d_Bacteria_...`）反向匹配，格式B（分号式 `d__Bacteria;...`）值验证
- **批量分支折叠**：嵌套感知的深度优先排序，自动冲突检测
- **指定类群折叠**：`--clade` 选项，先检查单系性再折叠
- **地质时间轴集成**：通过 deeptime 实现自适应时间刻度（Ma/Ka），支持 ICS 2023/02 年代地层表
- **智能图例布局**：根据分组数量自动调整行列
- **出版级输出**：色盲友好调色板（默认 viridis），支持 PDF/PNG/SVG/TIFF/EPS 高分辨率输出
- **特殊祖先节点标识符**：ROOT、LUCA、LACA、LBCA 用于高亮关键节点
- **外部分类学文件支持**：从外部文件读取分类学信息，检测循环依赖
- **树-序列交叉验证**：自动匹配末端标签与序列ID
- **实时日志系统**：ISO 8601 毫秒时间戳、步骤跟踪、日志文件输出
- **全面的输入验证**：深度树/序列验证，PHYLIP/Stockholm 格式拒绝
- **跨平台鲁棒性**：UTF-8 编码、BOM 处理、换行符归一化
- **优雅中断处理**：Ctrl+C 捕获，报告进度，清理资源
- **对抗性输入防护**：控制字符/BiDi 标记检测，空文件拒绝
- **自检模式**：`--check` 验证依赖、解析、单系群逻辑
- **多种使用方式**：R API、命令行（`run_rclade_cli()` / `inst/bin/rclade` 包装脚本）、Shiny Web 应用（`run_rclade_shiny()`）

## 安装

### 从源码安装

```r
# 从本地源码包安装
install.packages("path/to/Rclade_1.0.0.tar.gz", repos = NULL, type = "source")
```

### 使用 Conda

```bash
conda env create -f environment.yml
conda activate rclade
```

> **可重复性说明**：`environment.yml` 指定最低版本下界。
> 若需完全可重复的环境，创建后导出显式规格：
> ```bash
> conda list --explicit > conda-lockfile.txt
> # 恢复：conda create --name rclade --file conda-lockfile.txt
> ```
> 也可在 R 内使用 `renv` 进行包级锁定。

### 使用 Docker

```bash
# 从 Dockerfile 构建
docker build -t rclade .

# 运行分析
docker run -v $(pwd):/data rclade -f tree.tre -r phylum -o output.pdf
```

### 验证安装

```bash
# 运行自检
Rclade --check
```

## 流程概览

```
输入树文件
    │
    ▼
┌─────────────────┐
│  读取与验证      │  ← 格式检测、括号平衡、负分支检查、单位换算
└────────┬────────┘
         ▼
┌─────────────────┐
│  解析分类学      │  ← GTDB/Silva/NCBI/嵌入式格式自动检测（clade/groups/rank 三种模式）
└────────┬────────┘
         ▼
┌─────────────────┐
│  计算 MRCA       │  ← 单系性检查 + 最近共同祖先 + 嵌套冲突检测
└────────┬────────┘
         ▼
┌─────────────────┐
│  生成调色板      │  ← 色盲友好调色板（默认 viridis）
└────────┬────────┘
         ▼
┌─────────────────┐
│  渲染与折叠      │  ← ggtree 渲染 + 深度优先、嵌套感知的批量折叠
└────────┬────────┘
         ▼
┌─────────────────┐
│  时间轴与注释    │  ← deeptime 时间轴 + 支持值/HPD/分支标签/高亮
└────────┬────────┘
         ▼
┌─────────────────┐
│  导出输出        │  ← 图例/主题/标题 + PDF/PNG/SVG/TIFF/EPS，支持覆盖控制
└─────────────────┘
```

## 快速开始

```r
library(Rclade)

# 加载内置示例树（50 个叶节点，GTDB 标签）
data(example_tree)

# 按门级折叠可视化
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE)

# 折叠指定类群（先检查单系性）
p <- plot_timetree(example_tree, clade = "Cyanobacteria",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE)

# 添加地质时间轴
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   unit = "Ma", add_timescale = TRUE)

# 保存到文件
save_timetree(p, "output.pdf", width = 14, height = 10)

# 一行流水线
plot_timetree(example_tree, rank = "phylum", output = "output.pdf")
```

## 支持的分类标签格式

| 格式 | 检测规则 | 示例 |
|------|----------|------|
| **GTDB**（格式B） | 前缀 `d__`、`p__`、`c__`、... | `d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria` |
| **嵌入式**（格式A） | `_d_`、`_p_`、`_c_`、... | `GB_GCA_001_d_Bacteria_p_Proteobacteria_c_Gammaproteobacteria` |
| **Silva** | 分号分隔，无前缀 | `Bacteria;Proteobacteria;Gammaproteobacteria` |
| **NCBI** | 以 `cellular organisms`、`root` 等开头 | `cellular organisms;Bacteria;Proteobacteria` |
| **自定义正则** | 用户提供的正则表达式 | `list(domain = "Domain:([^|]+)")` |

## 核心函数

| 函数 | 说明 |
|------|------|
| `plot_timetree()` | 主入口：一键完成折叠 + 可视化 |
| `rclade_options()` | 为 `plot_timetree(opts = ...)` 构建已验证的参数列表 |
| `save_timetree()` | 导出为 PDF/PNG/SVG/TIFF/EPS，支持覆盖控制 |
| `batch_plot()` | 批量处理目录中的所有树文件 |
| `summarize_timetree()` | 打印折叠元数据 |
| `summarize_taxonomy_quality()` | 报告标签解析质量 |
| `summarize_taxonomy_quality_with_file()` | 使用外部文件报告解析质量 |
| `check_monophyly()` | 检查分组是否为单系群 |
| `check_special_monophyly()` | 检查 LUCA/LACA/LBCA 是否为单系群 |
| `detect_taxonomy_format()` | 检测分类标签格式（GTDB/Silva/NCBI/嵌入式） |
| `parse_taxonomy()` | **库模式 API**：从末端标签解析分类学信息，返回 data.frame |
| `read_tree_auto()` | **库模式 API**：自动检测格式读取树文件，供外部工作流调用 |
| `read_taxonomy_file()` | 从外部文件读取分类学信息 |
| `validate_sequence_deep()` | 深度序列文件验证 |
| `validate_sequence_file()` | 验证序列文件格式 |
| `validate_tree_sequence_match()` | 交叉验证树末端与序列ID |
| `theme_timetree()` | 出版级 ggplot2 主题 |
| `run_rclade_selftest()` | 运行全面自检 |
| `run_rclade_shiny()` | 启动交互式 Shiny Web 应用 |
| `save_session_info()` | 导出 sessionInfo 以保证可重复性 |
| `set_log_level()` | 设置日志级别 |
| `set_log_file()` | 启用日志文件输出 |
| `set_log_enabled()` | 启用或禁用日志 |
| `rclade_logo()` | 显示 ASCII 艺术 Logo |
| `get_supported_extensions()` | 列出支持的文件扩展名 |

### 内部工具函数

以下基础设施辅助函数是**内部函数**（未导出），自 API 表面收敛后需通过 `Rclade:::` 访问：

| 函数 | 说明 |
|------|------|
| `batch_with_interrupt()` | 支持优雅 Ctrl+C 中断的批量处理；中断时返回已完成部分的结果列表 |
| `build_path()` | 跨平台安全路径构建 |
| `managed_tempdir()` / `managed_tempfile()` | 自动清理的临时目录/文件 |
| `normalize_file_newlines()` | 规范化文件换行符 |
| `log_debug()` / `log_info()` / `log_warning()` / `log_error()` / `log_critical()` | 实时日志输出辅助函数 |
| `log_section()` / `log_subsection()` / `log_keyvalue()` / `log_progress()` / `log_stats()` / `log_table()` | 格式化日志输出 |
| `timer_start()` / `timer_stop()` | 性能计时辅助函数 |
| `with_graceful_interrupt()` | 包装表达式以优雅处理 SIGINT |
| `resolve_special_identifier()` / `resolve_group()` | 特殊标识符 / 分组解析器 |
| `validate_custom_groups()` / `validate_taxonomy_no_cycles()` | 分组 / 分类学验证器 |
| `generate_colors()` | 色盲友好调色板生成 |
| `split_legend()` | 将图例提取为独立面板 |
| `detect_encoding()` | 检测文件编码（UTF-8、BOM 等） |

## 指定类群折叠

按名称折叠特定类群（先检查单系性）：

```r
# 折叠 Cyanobacteria（如果是单系群）
p <- plot_timetree(example_tree, clade = "Cyanobacteria",
                   taxonomy_format = "GTDB")

# 严格模式：非单系群时终止
p <- plot_timetree(example_tree, clade = "Proteobacteria",
                   strict = TRUE, taxonomy_format = "GTDB")
```

命令行使用：
```bash
# 折叠指定类群
Rclade -f tree.tre --clade Cyanobacteria -o output.pdf

# 严格模式
Rclade -f tree.tre --clade Proteobacteria --strict -o output.pdf
```

### 使用包装脚本获得标准退出码

包内提供了 `inst/bin/rclade` 包装脚本，可在终端直接使用：

```bash
# 将 inst/bin/rclade 加入 PATH，或使用完整路径
export PATH="/path/to/Rclade/inst/bin:$PATH"
rclade -f tree.tre -r phylum -o output.pdf
```

相比 `Rscript -e "Rclade::run_rclade_cli(...)"`，包装脚本：
- 正确传递退出码 0/1/2/3
- 在 Ctrl+C 中断时返回标准 Unix 退出码 **130**
- 用法与直接调用 CLI 完全一致

## 特殊祖先节点标识符

| 标识符 | 说明 | 目标 |
|--------|------|------|
| **ROOT** | 树的根节点 | 所有末端 |
| **LUCA** | 最后共同祖先 | 所有细菌和古菌的 MRCA |
| **LACA** | 最后古菌共同祖先 | 所有古菌的 MRCA |
| **LBCA** | 最后细菌共同祖先 | 所有细菌的 MRCA |

```r
# 高亮 LUCA
p <- plot_timetree(example_tree, rank = "phylum",
                   highlight = c("LUCA"), add_timescale = FALSE)

# 检查单系性
result <- check_special_monophyly(example_tree, "LBCA")
```

## 多树文件处理

```r
# 使用第一个树
p <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "first")

# 随机选择一个树
p <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "random")

# 分别分析所有树（返回绘图列表）
plots <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "all")

# split 模式：同 all 返回所有树，CLI 会为每棵树生成带数字后缀的输出
plots <- plot_timetree("beast.trees", rank = "phylum", multi_tree_mode = "split")
```

## 外部分类学文件

```r
# 从文件读取分类学信息
taxa <- read_taxonomy_file("taxonomy.tsv")

# 使用外部文件进行折叠
p <- plot_timetree(tree, rank = "phylum", taxonomy_file = "taxonomy.tsv")

# 使用自定义分隔符
p <- plot_timetree(tree, rank = "phylum",
                   taxonomy_file = "taxonomy.csv",
                   taxonomy_file_sep = ",")
```

## 树-序列交叉验证

```r
# 验证树末端与序列ID匹配
validate_tree_sequence_match("tree.nwk", "sequences.fasta")

# 多树文件时指定处理方式（默认 "error"，多树文件会报错）
validate_tree_sequence_match("beast.trees", "sequences.fasta",
                             multi_tree_mode = "first")

# 通过 CLI 使用
# Rclade -f tree.tre --sequence_file seqs.fasta -r phylum
```

## 命令行参考

### 基本用法

```bash
# 显示帮助（所有参数、默认值、示例）
Rclade --help

# 显示版本及依赖版本
Rclade --version

# 运行自检
Rclade --check

# 基本用法：门级折叠
Rclade -f tree.tre -r phylum -o output.pdf

# 使用 GTDB 格式和 Ma 时间单位
Rclade -f tree.tre -r phylum --taxonomy_format GTDB -u Ma -o output.pdf

# 折叠指定类群
Rclade -f tree.tre --clade Cyanobacteria -o output.pdf
```

### 分类学选项

```bash
# 外部分类学文件
Rclade -f tree.tre -r phylum --taxonomy_file taxa.tsv -o output.pdf

# 带标题行和逗号分隔符的分类学文件
Rclade -f tree.tre -r phylum --taxonomy_file taxa.csv --taxonomy_file_header --taxonomy_file_sep comma

# 嵌入式格式解析策略（reverse/greedy/segment）
Rclade -f tree.tre -r phylum --taxonomy_format custom_rank --taxonomy_delimiter_mode reverse

# 表格分类学优先于嵌入式
Rclade -f tree.tre -r phylum --taxonomy_file taxa.tsv --taxonomy_source_priority table

# 自定义分类级别（界、亚种）：code:prefix 格式
# 这里 k 使用 _k_ 作为嵌入式分隔符，ss 使用 _ss_
Rclade -f tree.tre -r phylum --taxonomy_format custom_rank --taxonomy_levels "k:_k_,ss:_ss_"

# 自定义分类表分隔符（taxonomy 字符串内部的分隔符）
Rclade -f tree.tre -r phylum --taxonomy_file taxa.tsv --taxonomy_table_sep "|"
```

### 多树选项

```bash
# 使用第一个树
Rclade -f beast.trees --multi_tree_mode first -r phylum -o output.pdf

# 使用最后一个树
Rclade -f beast.trees --multi_tree_mode last -r phylum -o output.pdf

# 随机选择一个树
Rclade -f beast.trees --multi_tree_mode random -r phylum -o output.pdf

# 使用指定索引的树
Rclade -f beast.trees --tree_index 42 -r phylum -o output.pdf

# 分别分析所有树（输出文件自动添加数字后缀）
Rclade -f beast.trees --multi_tree_mode all -r phylum -o output.pdf
# 生成：output_1.pdf, output_2.pdf, ...

# split 模式：同 all，但语义上明确表示按树拆分输出（用于流水线下游分派）
Rclade -f beast.trees --multi_tree_mode split -r phylum -o output.pdf
```

### 序列验证

```bash
# 交叉验证树末端与序列 ID
Rclade -f tree.tre --sequence_file seqs.fasta -r phylum -o output.pdf

# 跳过交叉验证
Rclade -f tree.tre --sequence_file seqs.fasta --no_cross_check -r phylum

# 指定分子类型（DNA/RNA/protein/auto）
Rclade -f tree.tre --sequence_file seqs.fasta --mol_type DNA -r phylum

# 跳过比对长度检查
Rclade -f tree.tre --sequence_file seqs.fasta --skip_length_check -r phylum
```

### 输出控制

```bash
# 强制覆盖已有输出
Rclade -f tree.tre -r phylum -o output.pdf --force

# 跳过已有输出（不覆盖）
Rclade -f tree.tre -r phylum -o output.pdf --no_clobber

# 跳过畸形输入而非终止
Rclade -f tree.tre -r phylum --ignore_malformed -o output.pdf

# 低内存模式（适用于大型树）
Rclade -f tree.tre -r phylum --low_memory -o output.pdf

# 剥离节点注释（bootstrap/NHX），减小输出体积
Rclade -f tree.nhx -r phylum --strip_annotations -o output.pdf
```

### 配置文件支持

Rclade 支持通过 YAML 配置文件提供默认值。优先级：**CLI 显式参数 > 配置文件 > 内置默认值**。包内附带 `config.example.yaml` 模板，列出全部可配置项；可通过以下方式获取：

```r
system.file("extdata", "config.example.yaml", package = "Rclade")
```

```bash
# 使用配置文件
Rclade --config config.yaml -f tree.tre -o output.pdf

# CLI 参数覆盖配置文件（此处 rank 优先于配置文件中的 rank）
Rclade --config config.yaml -f tree.tre -r genus -o output.pdf
```

配置文件示例（详见 `inst/extdata/config.example.yaml`）：

```yaml
# 任何 CLI 长选项名均可作为键
rank: phylum
taxonomy_format: GTDB
unit: Ma
multi_tree_mode: error
strip_annotations: false
log_level: INFO
```

> 注：optparse 无法区分"用户显式传入默认值"和"用户未传入该参数"。若用户显式传入与默认值相同的值，配置文件中的值仍会生效。如需强制覆盖配置文件，请在 CLI 上显式传入该参数。

### 日志选项

```bash
# 调试日志
Rclade -f tree.tre -r phylum --log_level DEBUG -o output.pdf

# 日志输出到文件
Rclade -f tree.tre -r phylum --log_file analysis.log -o output.pdf

# 组合使用
Rclade -f tree.tre -r phylum --log_level DEBUG --log_file debug.log -o output.pdf
```

### 完整 CLI 选项表

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `-f, --file` | FILE | - | 输入树文件（必需） |
| `-o, --out` | FILE | `timetree_plot.pdf` | 输出文件 |
| `-W, --width` | NUM | 14 | 宽度（英寸） |
| `-H, --height` | NUM | 10 | 高度（英寸） |
| `-r, --rank` | RANK | none | 折叠等级 |
| `--clade` | NAME | - | 指定要折叠的类群 |
| `--strict` | FLAG | FALSE | 非单系群时终止 |
| `--tree_index` | INT | - | 多树文件中的树索引 |
| `--multi_tree_mode` | MODE | error | 多树处理方式：error/ask/first/last/random/all/split |
| `--taxonomy_format` | STR | auto | 格式：auto/GTDB/Silva/NCBI/custom_rank/custom_regex |
| `--taxonomy_file` | FILE | - | 外部分类学文件 |
| `--taxonomy_file_sep` | STR | auto | 分隔符：auto/tab/comma |
| `--taxonomy_file_header` | FLAG | FALSE | 文件有标题行 |
| `--no_taxonomy_file_priority` | FLAG | FALSE | 降低文件优先级 |
| `--taxonomy_delimiter_mode` | STR | reverse | 嵌入式解析策略：reverse/greedy/segment |
| `--taxonomy_source_priority` | STR | table | 来源优先级：`embedded`/`table` |
| `--taxonomy_table_sep` | STR | ; | 表格值分隔符（taxonomy 字符串内部分隔符） |
| `--taxonomy_levels` | STR | - | 自定义等级映射，格式 `code:prefix`，如 `k:_k_,ss:_ss_` |
| `-t, --triangle_mode` | MODE | mixed | 三角形：max/min/mixed/none |
| `-s, --space_mode` | MODE | proportional | 空间：equal/proportional |
| `-l, --layout` | STR | rectangular | 布局：rectangular/circular |
| `-u, --unit` | STR | auto | 单位：auto/Ga/Ma（auto = 保持树原生单位；Ga 会 ×1000 转换） |
| `--angle` | NUM | 360 | 环形布局角度（10-360度） |
| `--line_width` | NUM | 1 | 分支线宽度 |
| `--ignore_branch_length` | FLAG | FALSE | 支序图模式（忽略分支长度） |
| `--color_palette` | STR | viridis | 调色板或十六进制颜色 |
| `--color_mapping` | STR | - | 颜色映射：`Group:#FF0000` |
| `--show_tip_labels` | FLAG | FALSE | 显示末端标签 |
| `--tip_label_size` | NUM | 2 | 末端标签字号 |
| `--show_clade_label` | FLAG | FALSE | 显示分支标签 |
| `--no_clade_count` | FLAG | FALSE | 隐藏分支标签中的物种计数 |
| `--clade_label_offset` | NUM | 50 | 分支标签偏移量 |
| `--clade_label_fontsize` | NUM | 3 | 分支标签字号 |
| `--show_support` | FLAG | FALSE | 显示节点支持值 |
| `--support_threshold` | NUM | 0.95 | 最小支持值阈值（0-1） |
| `--show_hpd` | FLAG | FALSE | 显示 HPD 区间 |
| `--hpd_color` | STR | firebrick | HPD 条颜色 |
| `--legend_position` | STR | bottom | 图例位置：bottom/right/left/top/none |
| `--legend_nrow` | INT | - | 图例行数 |
| `--legend_ncol` | INT | - | 图例列数 |
| `--no_timescale` | FLAG | FALSE | 禁用时间轴 |
| `--timescale_levels` | STR | eras,eons | 时间轴级别（逗号分隔）：eons/eras/periods |
| `--geo_events` | FLAG | FALSE | 显示地质事件带（GOE、NOE） |
| `--highlight` | STR | - | 高亮类群（逗号分隔） |
| `--highlight_alpha` | NUM | 0.2 | 高亮透明度（0-1） |
| `--main_title` | STR | - | 主标题 |
| `--sub_title` | STR | - | 副标题 |
| `--sequence_file` | FILE | - | 序列文件（用于交叉验证） |
| `--mol_type` | STR | auto | 分子类型：DNA/RNA/protein/auto |
| `--skip_length_check` | FLAG | FALSE | 跳过比对长度一致性检查 |
| `--no_cross_check` | FLAG | FALSE | 禁用树-序列验证 |
| `--force` | FLAG | FALSE | 覆盖已有输出 |
| `--no_clobber` | FLAG | FALSE | 跳过已有输出 |
| `--ignore_malformed` | FLAG | FALSE | 跳过畸形输入并警告，不终止 |
| `--low_memory` | FLAG | FALSE | 低内存模式（触发 GC 等最佳努力优化） |
| `--log_level` | STR | INFO | 日志级别：DEBUG/INFO/WARNING/ERROR/CRITICAL |
| `--log_file` | FILE | - | 日志输出到文件 |
| `--check` | FLAG | FALSE | 运行自检 |
| `--strip_annotations` | FLAG | FALSE | 剥离节点注释（bootstrap/NHX）以减小输出体积 |
| `--config` | FILE | - | YAML 配置文件路径；CLI 参数 > 配置文件 > 默认值 |
| `-v, --version` | FLAG | FALSE | 显示版本 |

## `plot_timetree()` 参数表

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `tree` | phylo/character | - | 树对象或文件路径（必需） |
| `tree_index` | integer | NULL | 多树文件中的索引 |
| `multi_tree_mode` | character | "error" | 多树处理：error/ask/first/last/random/all/split |
| `rank` | character | "none" | 折叠等级：none/kingdom/domain/phylum/class/order/family/genus/species/subspecies（支持缩写 k/d/p/c/o/f/g/s/ss） |
| `clade` | character | NULL | 指定要折叠的类群名称 |
| `strict` | logical | FALSE | 非单系群时终止 |
| `groups` | list | NULL | 自定义末端分组 |
| `triangle_mode` | character | "mixed" | 三角形模式：max/min/mixed/none |
| `space_mode` | character | "proportional" | 空间分配：equal/proportional |
| `layout` | character | "rectangular" | 布局：rectangular/circular |
| `angle` | numeric | 360 | 环形布局角度 |
| `color_palette` | character | "viridis" | 调色板名称或十六进制向量 |
| `color_mapping` | named vector | NULL | 指定颜色分配 |
| `line_width` | numeric | 1 | 分支线宽度 |
| `show_tip_labels` | logical | FALSE | 显示末端标签 |
| `tip_label_size` | numeric | 2 | 末端标签字号 |
| `add_timescale` | logical | TRUE | 添加地质时间轴 |
| `timescale_levels` | character | c("eras","eons") | 显示的时间尺度级别 |
| `unit` | character | NULL | 时间单位：Ga/Ma |
| `taxonomy_format` | character | "auto" | 格式：auto/GTDB/Silva/NCBI/custom_rank/custom_regex |
| `custom_patterns` | list | NULL | 自定义正则表达式 |
| `taxonomy_file` | character | NULL | 外部分类学文件路径 |
| `taxonomy_file_sep` | character | "auto" | 文件分隔符：auto/tab/comma |
| `taxonomy_file_header` | logical | FALSE | 文件有标题行 |
| `taxonomy_file_priority` | logical | TRUE | 文件优先于标签 |
| `taxonomy_source_priority` | character | NULL | 来源优先级：`embedded`/`table`（覆盖 taxonomy_file_priority） |
| `taxonomy_table_sep` | character | ";" | 表格值分隔符（taxonomy 字符串内部分隔符） |
| `taxonomy_delimiter_mode` | character | "reverse" | 嵌入式解析策略：reverse/greedy/segment |
| `taxonomy_levels` | list | NULL | 自定义等级配置，如 `list(codes = c("k", "ss"), names = c("kingdom", "subspecies"))` |
| `legend_position` | character | "bottom" | 图例位置 |
| `legend_title` | character | NULL | 自定义图例标题 |
| `show_clade_label` | logical | FALSE | 显示分支标签 |
| `show_clade_count` | logical | TRUE | 标签中显示物种数 |
| `clade_label_offset` | numeric | 50 | 分支标签水平偏移量（Ma） |
| `clade_label_fontsize` | numeric | 3 | 分支标签字号 |
| `show_support` | logical | FALSE | 显示节点支持值 |
| `support_threshold` | numeric | 0.95 | 最小支持值阈值 |
| `show_hpd` | logical | FALSE | 显示 HPD 区间 |
| `hpd_color` | character | "firebrick" | HPD 条颜色 |
| `geo_events` | data.frame/FALSE | FALSE | 地质事件标注（GOE、NOE） |
| `timescale_version` | character | "ICS 2023/02" | 地质时间表版本 |
| `main_title` | character | NULL | 主标题 |
| `sub_title` | character | NULL | 副标题 |
| `highlight` | character | NULL | 要高亮的分组 |
| `highlight_alpha` | numeric | 0.2 | 高亮透明度 |
| `output` | character | NULL | 直接保存到文件 |
| `overwrite` | character | "ask" | 覆盖模式：ask/force/no-clobber |
| `width` | numeric | 14 | 输出宽度（英寸） |
| `height` | numeric | 10 | 输出高度（英寸） |
| `legend_nrow` | integer | NULL | 图例行数 |
| `legend_ncol` | integer | NULL | 图例列数 |
| `theme_fun` | function | theme_timetree | 主题函数（NULL 使用默认 ggplot2） |
| `low_memory` | logical | FALSE | 低内存模式（触发 GC 等最佳努力优化） |
| `ignore_malformed` | logical | FALSE | 跳过畸形输入并警告，不终止 |
| `ignore_branch_length` | logical | FALSE | cladogram 模式（忽略分支长度） |
| `color_rank` | character | NULL | 分支着色的分类学等级（独立于折叠 `rank`；为 NULL 时按折叠分组着色） |
| `timescale_mode` | character | "radial" | 环形布局时间轴模式：radial（径向）/ linear（线性，3 点钟方向） |
| `timescale_position` | character | "right" | 环形布局时间轴起始方位 |
| `tree_start_position` | character | "right" | 环形布局树绘制起始方位 |

## 输入/输出格式

### 树文件规范

- **节点编号**：内部节点从 1 开始编号（根节点 = Ntip + 1），遵循 `ape` 惯例
- **分支长度**：必须为非负值（负值将触发 CRITICAL 错误）
- **末端标签**：必须唯一（重复将触发 ERROR）
- **标签长度**：超过 500 字符的 Newick 标签在解析前会被截断为 400 字符 + `_RCLADE_TRUNC` 后缀（并给出警告），因为 ape 的解析器在 Linux 上遇到超过约 512 字符的标签会使整个 R 进程崩溃；若标签需与外部文件精确匹配，请提前缩短标签
- **坐标系**：系统发育树使用分支长度坐标（时间，单位 Ma/Ga），非序列坐标
- **标准合规**：Newick 格式遵循 [Newick 标准](https://evolution.genetics.washington.edu/phylip/newicktree.html)，Nexus 遵循 [NEXUS 标准](https://doi.org/10.1093/sysbio/46.4.590)

### 支持的树文件格式

| 格式 | 扩展名 | 说明 |
|------|--------|------|
| Newick | `.nwk`, `.tre`, `.tree`, `.treefile`, `.newick` | 标准系统发育树格式 |
| Nexus | `.nexus`, `.nex` | NEXUS 格式，支持元数据 |
| BEAST XML | `.xml`, `.beast` | BEAST2 输出格式 |
| NHX | `.nhx` | New Hampshire 扩展格式 |
| 共识树 | `.con`, `.confile` | 按 Newick 解析（使用 `ape::read.tree()`） |

### 支持的序列文件格式

| 格式 | 扩展名 | 说明 |
|------|--------|------|
| FASTA | `.fasta`, `.fa`, `.fna`, `.fas`, `.faa` | 标准序列格式 |
| FASTQ | `.fastq`, `.fq` | 测序读段（含质量值） |

**拒绝的格式**（会给出明确错误）：
- PHYLIP 格式
- Stockholm 格式

### 分类学文件格式

外部分类学文件应有两列：
1. 末端标签（必须与树中一致）
2. GTDB 格式的分类学字符串

```
# 制表符分隔（TSV）
tip1	d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria
tip2	d__Bacteria;p__Firmicutes;c__Bacilli

# 逗号分隔（CSV）
tip1,d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria
tip2,d__Bacteria;p__Firmicutes;c__Bacilli
```

缺失等级用空前缀表示：`s__`（物种缺失）

### 输出格式

| 格式 | 扩展名 | 说明 |
|------|--------|------|
| PDF | `.pdf` | 矢量格式，出版级 |
| PNG | `.png` | 栅格格式，默认 300 DPI |
| SVG | `.svg` | 矢量格式，Web 友好 |
| TIFF | `.tiff` | 栅格格式，印刷级 |
| EPS | `.eps` | 矢量格式，LaTeX 兼容 |

## 标准合规

| 标准 | 说明 | 参考 |
|------|------|------|
| **Newick** | 系统发育树格式 | [Newick 标准](https://evolution.genetics.washington.edu/phylip/newicktree.html) |
| **NEXUS** | 多用途数据格式 | [Maddison et al. 1997](https://doi.org/10.1093/sysbio/46.4.590) |
| **GTDB** | 基因组分类数据库 | [GTDB](https://gtdb.ecogenomic.org/) |
| **SILVA** | 核糖体 RNA 数据库 | [SILVA](https://www.arb-silva.de/) |
| **NCBI Taxonomy** | NCBI 生物分类学 | [NCBI Taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy) |
| **ICS 年代地层表** | 地质时间尺度 | [ICS 2023/02](https://stratigraphy.org/chart) |
| **ISO 8601** | 日期/时间格式 | [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) |

## 退出码

| 代码 | 含义 | 说明 |
|------|------|------|
| 0 | 成功 | 所有操作成功完成 |
| 1 | 运行时错误 | 依赖缺失、自检失败、内部错误 |
| 2 | 参数错误 | 命令行参数无效、缺少必需选项 |
| 3 | 输入数据错误 | 畸形树/序列文件、交叉验证失败 |
| 130 | 用户中断 | 执行期间收到 Ctrl+C (SIGINT)；`run_rclade_cli()` 会返回 130，使用 `inst/bin/rclade` 包装脚本可保证终端下稳定传播为 130 |

> 注：`run_rclade_cli()` 内部已改用 `tryCatch` 捕获中断并返回 130，因此无论是在交互式 R 还是会话中通过 `q(status = run_rclade_cli(...))` 结束，理论上都会得到 130。但在复杂信号场景或纯 `Rscript -e` 调用中，仍建议使用包内提供的 `inst/bin/rclade` 包装脚本（见上文），它由 shell 直接转发 SIGINT 并返回 130，最为稳定。

## 常见错误及解决方法

| 错误 | 原因 | 解决方案 |
|------|------|----------|
| `Input file (-f) is required` | 未指定输入文件 | 添加 `-f <tree_file>` |
| `Input file does not exist` | 文件路径错误 | 检查文件路径和权限 |
| `CRITICAL: Empty file` | 输入文件为 0 字节 | 检查文件是否正确传输 |
| `CRITICAL: Negative branch lengths` | 树有负分支长度 | 移除或修复负分支 |
| `ERROR: Duplicate tip labels` | 同一标签出现两次 | 使末端标签唯一 |
| `ERROR: Control characters detected` | 标签中有恶意字符 | 清理控制字符/BiDi 字符（涉及的标签以 `<U+XXXX>` 转义形式显示） |
| `WARNING: ... 个标签超过 500 字符 ... 截断` | ape 的 Newick 解析器遇到超过约 512 字符的标签会崩溃 | Rclade 已将其截断为 400 字符 + `_RCLADE_TRUNC`；若需精确匹配请提前缩短标签 |
| `Circular dependency detected` | 分类学有循环（如 d__A;p__B 和 d__B;p__A） | 修复分类学文件 |
| `Clade 'X' not found` | 类群名不在分类学中 | 检查拼写和格式 |
| `Group 'X' is NOT monophyletic` | 类群分散在树中 | 使用 `--clade --strict` 或 `--rank` |
| `Multiple trees detected` | 文件有多个树 | 使用 `--multi_tree_mode` 或 `--tree_index` |
| `PHYLIP format not supported` | 序列格式错误 | 先转换为 FASTA |
| `Duplicate sequence IDs` | FASTA 中有重复 ID | 使序列 ID 唯一 |
| `Tree-sequence mismatch` | 标签不匹配 | 确保末端标签 = 序列 ID |
| `Output file already exists` | 文件已存在 | 使用 `--force` 覆盖或 `--no_clobber` 跳过 |

## 性能优化建议

| 末端数 | 建议 |
|--------|------|
| >5,000 | 谨慎使用 `--show_tip_labels` |
| >10,000 | 考虑 `--low_memory` 模式 |
| >50,000 | 预计高内存占用（>4GB） |
| 大型树 | 使用 PDF 输出（比 PNG 更快） |
| 多分组 | 使用 `--no_timescale` 禁用时间轴 |

## 实时日志系统

```r
# 设置日志级别
set_log_level("DEBUG")

# 日志输出到文件
set_log_file("analysis.log")

# 运行分析
p <- plot_timetree(example_tree, rank = "phylum")
```

日志格式（ISO 8601 毫秒精度）：
```
2026-06-13T15:30:45.123 | INFO     | Step 1/7: Input validation and reading
2026-06-13T15:30:45.125 | INFO     | Reading tree file: example.tre
2026-06-13T15:30:45.130 | DEBUG    | Memory: 45.2 MB used (approx)
```

日志函数（`log_info()` / `log_warning()` / `log_error()` 等）支持可选的 `.module` 参数，用于在错误/警告消息中插入 `[MODULE/FUNCTION]` 来源标签，便于定位问题：

```r
log_warning("Skipped %d non-monophyletic group(s)", n,
            .module = "compute-mrca/compute_mrca_map")
# 输出：... | WARNING  | [compute-mrca/compute_mrca_map] | Skipped 3 non-monophyletic group(s)
```

## 自检模式

```r
# 从 R 运行自检
run_rclade_selftest()
```

```bash
# 从 CLI 运行自检
Rclade --check
```

检查内容：依赖库、树解析、分类学提取（格式A和B）、单系群逻辑、输入验证、对抗性输入。

## 性能基准

| 叶节点数 | 分类群数 | 耗时 | 状态 |
|----------|----------|------|------|
| 50 | 10 | 0.5s | 通过 |
| 500 | 50 | 0.3s | 通过（基准线） |
| 1,000 | 100 | 1.9s | 通过 |
| 5,000 | 200 | 38.7s | 较慢 |
| 10,000+ | - | - | 警告：预计高内存占用 |

## 依赖

**必需**：ape (>= 5.0, GPL-2+)、ggtree (>= 4.0.0, Artistic-2.0)、deeptime (>= 1.0, GPL-3)、ggplot2 (>= 3.5.0, MIT)、rlang (MIT)、stringr (>= 1.5, MIT)、tidytree (>= 0.4, Artistic-2.0)

**可选**：treeio（Artistic-2.0，BEAST2/IQ-TREE 支持）、phangorn（GPL-2+，嵌套检测）、viridisLite/RColorBrewer（调色板）、cowplot/patchwork（图例分离）、shiny（Web UI）、optparse（CLI）、yaml（`--config` 配置文件支持）

完整的第三方依赖及许可证声明见 [inst/THIRDPARTY](inst/THIRDPARTY)。

## 引用

如果您在研究中使用了 Rclade，请引用：

> Zeng Z (2026). Rclade: Automated Deep-Time Phylogenetic Tree Collapsing and Visualization. R package version 1.0.0.

Rclade 基于 ggtree 和 deeptime 生态系统构建，请同时引用以下关键依赖：

> Yu G, Smith DK, Zhu H, Guan Y, Lam TT-Y (2017). ggtree: an R package for visualization and annotation of phylogenetic trees with their covariates and other associated data. Methods in Ecology and Evolution, 8(1), 28-36. doi:10.1111/2041-210X.12628

> Gearty W (2025). deeptime: an R package that facilitates highly customizable and reproducible visualizations of data over geological time intervals. Big Earth Data. doi:10.1080/20964471.2025.2537516

GitHub 仓库：https://github.com/zengzichao/Rclade  
Issue 追踪：https://github.com/zengzichao/Rclade/issues

## 贡献指南

欢迎贡献！请通过 GitHub Issue 或 Pull Request 提交：

```bash
git clone https://github.com/zengzichao/Rclade.git
```

详见 [CONTRIBUTING.CN.md](CONTRIBUTING.CN.md)。

## 联系方式与维护者

- **作者**：曾子超 (zengzichao@sjtu.edu.cn)
- **单位**：上海交通大学
- **GitHub**：https://github.com/zengzichao/Rclade

## 许可证

MIT

### 内置数据许可证

- **ICS 地质年代数据**（`R/sysdata.rda`）：基于 [ICS 国际年代地层表 2023/02](https://stratigraphy.org/chart)，地质边界年龄为事实数据。
