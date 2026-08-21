# FAQ

**Which tree file formats are supported?**
Newick (`.nwk`, `.tre`, `.treefile`), Nexus (`.nexus`, `.nex`), PhyloXML (`.xml`), and multi-tree files such as BEAST `.trees`. See [get_supported_extensions](reference/utilities.md) and [read_tree_auto](reference/tree-sequence.md).

**My tip labels contain no taxonomy. Can Rclade still work?**
Yes. Provide an external two-column taxonomy file via `taxonomy_file` (or `taxonomy_file` in `plot_timetree`). See [read_taxonomy_file](reference/taxonomy-parsing.md) and [summarize_taxonomy_quality_with_file](reference/taxonomy-parsing.md).

**I got a "non-monophyletic group" warning. What does it mean?**
The taxonomic group you asked to collapse is not monophyletic — its members do not share a single MRCA. By default Rclade warns and skips it. Set `strict = TRUE` to abort instead. Use [check_monophyly](reference/tree-sequence.md) to investigate.

**How do I change the time unit (Ma vs Ga)?**
Set `unit = "Ma"` or `unit = "Ga"` in `plot_timetree`. If `NULL`, Rclade infers it from the edge-length magnitude.

**Can I use a circular layout with a timescale?**
The timescale works best with `layout = "rectangular"`. For circular layouts, set `add_timescale = FALSE`, or use `timescale_mode = "linear"` to draw a linear timescale axis.

**How do I cite Rclade?**
Use the `citation("Rclade")` command, or the `CITATION` file shipped with the package. Also see `save_session_info()` to record the exact environment.

**The plot is slow / the tree is huge.**
Use `show_tip_label = FALSE`, prefer `space_mode = "proportional"`, and consider `low_memory = TRUE`. For many trees, use [batch_plot](reference/core-visualization.md).

**I got a "label(s) exceed 500 characters ... truncated" warning. What happened?**
ape's Newick parser aborts the whole R process on Linux for labels longer than ~512 characters, so Rclade truncates labels over 500 characters to 400 characters + a `_RCLADE_TRUNC` suffix before parsing. If your labels must match an external taxonomy file or sequence IDs exactly, shorten them upstream.

**How do I run Rclade non-interactively (HPC / pipeline)?**
Use [run_rclade_cli](reference/cli-interactive.md) from a shell, or call `plot_timetree()` / `batch_plot()` inside a script. Redirect logs with [set_log_file](reference/logging-timing.md).

**My file has multiple trees and I get an error.**
Set `multi_tree_mode` to `"first"`, `"last"`, `"random"`, or `"all"` (or `"split"` in batch mode) to control which tree(s) to use.

**Where is the full function reference?**
[Reference index](reference/index.md) lists all functions by module (26 of them exported via NAMESPACE), each with a usage example.

**中文文档在哪里？**
中文文档位于 `docs/cn/`，入口为 [docs/cn/index.md](../cn/index.md)。
