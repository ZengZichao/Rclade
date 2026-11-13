# 常见问题

**支持哪些树文件格式？**
Newick（`.nwk`、`.newick`、`.tre`、`.tree`、`.treefile`、`.nhx`）、Nexus（`.nexus`、`.nex`）、BEAST XML（`.xml`、`.beast`，需建议包 `treeio`），以及 `.trees` 等多树 BEAST 输出（按文件内容识别）。参见 [get_supported_extensions](reference/utilities.md) 与 [read_tree_auto](reference/tree-sequence.md)。

**我的末端标签不含分类信息，Rclade 还能用吗？**
可以。提供两列的外部分类文件即可：命令行用 `--taxonomy_file`，或在 `plot_timetree` 中设 `taxonomy_file` 参数。参见 [read_taxonomy_file](reference/taxonomy-parsing.md) 与 [summarize_taxonomy_quality_with_file](reference/taxonomy-parsing.md)。

**出现 “Group '…' is NOT monophyletic ... Cannot collapse.” 警告，是什么意思？**
你要求折叠的分类群不是单系的——其成员不共享同一个 MRCA。默认情况下 Rclade 警告并跳过它；设 `strict = TRUE` 则改为中止。可用 [check_monophyly](reference/tree-sequence.md) 排查。

**如何切换时间单位（Ma / Ga）？**
在 `plot_timetree` 中设置 `unit = "Ma"` 或 `unit = "Ga"`。Rclade 不会推断单位：由于 `add_timescale` 默认为 `TRUE`，`unit` 留作 `NULL` 会直接中止，因此必须显式给出 `unit`，或设 `add_timescale = FALSE`。

**环形布局能用时间轴吗？**
可以。环形布局默认也绘制时间轴：`timescale_mode = "radial"`（默认）将地质年代条带环绕整个扇形绘制，`timescale_mode = "linear"` 则改为在 `timescale_position` 处绘制一条直线时间轴。若要完全关闭，设 `add_timescale = FALSE`。`timescale_mode` 对矩形布局无效，而矩形布局通常更易读。

**如何引用 Rclade？**
使用 `citation("Rclade")` 命令，或查阅包内附带的 `CITATION` 文件。也可用 `save_session_info()` 记录精确环境。

**绘图很慢 / 树非常大怎么办？**
设 `low_memory = TRUE`（超过 10000 个末端时 Rclade 会警告并建议启用），用 `triangle_mode = "none"` 去掉折叠三角形，并保持 `show_tip_labels = FALSE`（默认即为关闭）。多棵树请用 [batch_plot](reference/core-visualization.md)。

**出现了“label(s) exceed 500 characters ... truncated”（标签超过 500 字符，将被截断）的警告，怎么办？**
ape 的 Newick 解析器在 Linux 上遇到超过约 512 字符的标签会使整个 R 进程崩溃，因此 Rclade 在解析前把超过 500 字符的标签截断为 400 字符 + `_RCLADE_TRUNC` 后缀。若标签需要与外部分类文件或序列 ID 精确匹配，请在读入前缩短原始标签。

**如何在非交互环境（HPC / 流水线）运行？**
通过 shell 调用 [run_rclade_cli](reference/cli-interactive.md)，或在脚本中调用 `plot_timetree()` / `batch_plot()`。用 [set_log_file](reference/logging-timing.md) 重定向日志。

**文件包含多棵树并报错怎么办？**
设置 `multi_tree_mode` 为 `"first"`、`"last"`、`"random"` 或 `"all"`（批量模式下还可 `"split"`）来控制使用哪些树。

**完整的函数参考在哪里？**
[参考手册索引](reference/index.md) 按模块列出全部函数（其中 26 个从 NAMESPACE 导出），每个都含使用示例。

**英文文档在哪里？**
英文文档位于 `inst/docs/en/`，入口为 [inst/docs/en/index.md](../en/index.md)。
