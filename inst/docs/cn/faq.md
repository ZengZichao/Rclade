# 常见问题

**支持哪些树文件格式？**
Newick（`.nwk`、`.tre`、`.treefile`）、Nexus（`.nexus`、`.nex`）、PhyloXML（`.xml`），以及 BEAST `.trees` 等多树文件。参见 [get_supported_extensions](reference/utilities.md) 与 [read_tree_auto](reference/tree-sequence.md)。

**我的末端标签不含分类信息，Rclade 还能用吗？**
可以。通过 `taxonomy_file`（或 `plot_timetree` 中的同名参数）提供两列的外部分类文件。参见 [read_taxonomy_file](reference/taxonomy-parsing.md) 与 [summarize_taxonomy_quality_with_file](reference/taxonomy-parsing.md)。

**出现了“非单系分组”警告，是什么意思？**
你要求折叠的分类分组不是单系的——其成员不共享同一个 MRCA。默认情况下 Rclade 警告并跳过它；设 `strict = TRUE` 则改为中止。可用 [check_monophyly](reference/tree-sequence.md) 排查。

**如何切换时间单位（Ma / Ga）？**
在 `plot_timetree` 中设置 `unit = "Ma"` 或 `unit = "Ga"`。若为 `NULL`，Rclade 会按枝长数量级自动推断。

**环形布局能用时间轴吗？**
时间轴在 `layout = "rectangular"` 下效果最佳。环形布局建议设 `add_timescale = FALSE`，或用 `timescale_mode = "linear"` 绘制线性时间轴。

**如何引用 Rclade？**
使用 `citation("Rclade")` 命令，或查阅包内附带的 `CITATION` 文件。也可用 `save_session_info()` 记录精确环境。

**绘图很慢 / 树非常大怎么办？**
使用 `show_tip_label = FALSE`，优先 `space_mode = "proportional"`，并考虑 `low_memory = TRUE`。对多棵树，使用 [batch_plot](reference/core-visualization.md)。

**出现了"标签超过 500 字符将被截断"的警告，怎么办？**
ape 的 Newick 解析器在 Linux 上遇到超过约 512 字符的标签会使整个 R 进程崩溃，因此 Rclade 在解析前把超过 500 字符的标签截断为 400 字符 + `_RCLADE_TRUNC` 后缀。若标签需要与外部分类文件或序列 ID 精确匹配，请在读入前缩短原始标签。

**如何在非交互环境（HPC / 流水线）运行？**
通过 shell 调用 [run_rclade_cli](reference/cli-interactive.md)，或在脚本中调用 `plot_timetree()` / `batch_plot()`。用 [set_log_file](reference/logging-timing.md) 重定向日志。

**文件包含多棵树并报错怎么办？**
设置 `multi_tree_mode` 为 `"first"`、`"last"`、`"random"` 或 `"all"`（批量模式下还可 `"split"`）来控制使用哪些树。

**完整的函数参考在哪里？**
[参考手册索引](reference/index.md) 按模块列出全部函数（其中 26 个从 NAMESPACE 导出），每个都含使用示例。

**Where is the English documentation?**
English docs are under `docs/en/`, entry point [docs/en/index.md](../en/index.md).
