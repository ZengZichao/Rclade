# Rclade 文档（中文）

欢迎阅读 Rclade 文档。Rclade 是一个用于**深时系统发育树自动化折叠与可视化**（带地质时间轴）的 R 包。

本文档采用多级体系组织：

1. **入门指南** — 引导式首次运行。
2. **安装** — 如何安装 Rclade 及其依赖。
3. **核心概念** — 分类格式、MRCA 折叠、时间轴、颜色与特殊标识符。
4. **教程** — 分步工作流。
5. **参考手册** — 每个导出函数，按模块分组，均含使用示例。
6. **示例集锦** — 常见任务的即拷即用示例。
7. **常见问题** — 高频问题与排错。

## 导航

| 页面 | 链接 |
|------|------|
| 入门指南 | [getting-started.md](getting-started.md) |
| 安装 | [installation.md](installation.md) |
| 核心概念 | [core-concepts.md](core-concepts.md) |
| 教程 | [tutorials.md](tutorials.md) |
| 参考手册索引 | [reference/index.md](reference/index.md) |
| 示例集锦 | [cookbook.md](cookbook.md) |
| 常见问题 | [faq.md](faq.md) |

English docs: [../en/index.md](../en/index.md) · 项目 README：[../../README.CN.md](../../README.CN.md)

## 模块参考

- [核心可视化](reference/core-visualization.md) — `plot_timetree`、`batch_plot`、`save_timetree`、`summarize_timetree`、`theme_timetree`
- [树与序列读取及校验](reference/tree-sequence.md) — 读取/校验树与序列，检查单系性
- [分类学解析](reference/taxonomy-parsing.md) — 检测/解析标签，将分组解析为 MRCA，校验自定义分组
- [颜色与图例](reference/colors-legend.md) — `generate_colors`、`split_legend`
- [命令行与交互界面](reference/cli-interactive.md) — 命令行、Shiny、自检、中断处理
- [日志与计时](reference/logging-timing.md) — 结构化日志与计时器
- [工具函数](reference/utilities.md) — 路径、编码、临时文件及其他辅助函数
