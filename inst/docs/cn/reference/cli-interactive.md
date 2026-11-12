# 命令行与交互界面

通过命令行运行 Rclade、启动 Shiny 应用、运行自检，并支持可中断的批量处理。

本模块包含以下函数：

- [`run_rclade_cli`](#run_rclade_cli) — 从命令行运行 Rclade
- [`run_rclade_shiny`](#run_rclade_shiny) — 启动 Rclade Shiny 交互应用
- [`run_rclade_selftest`](#run_rclade_selftest) — 运行 Rclade 自检
- [`batch_with_interrupt`](#batch_with_interrupt) — 带中断处理的批量执行
- [`with_graceful_interrupt`](#with_graceful_interrupt) — 带优雅中断处理的表达式执行

## `run_rclade_cli`

**从命令行运行 Rclade**

Rclade 的命令行入口，解析命令行参数并驱动批处理或单树绘制，便于在 shell / 流水线中调用。需要 `optparse` 包。

**用法：**

```r
run_rclade_cli(args = commandArgs(trailingOnly = TRUE))
```

**参数：**

| 参数 | 说明 |
|------|------|
| `args` | 命令行参数字符向量，默认取 `commandArgs(trailingOnly = TRUE)`。 |

**返回值：**

不可见地返回遵循标准 Unix 约定的整数退出码：`0L`（成功）、`1L`（运行错误）、`2L`（参数错误）、`3L`（输入数据错误）、`130L`（用户中断 / SIGINT）。调用方**必须**把该值转发给 `q(status = ...)` 或 `quit(status = ...)`，否则进程无论是否出错都恒以退出码 `0` 结束。

**示例：**

```r
# 在系统命令行中运行：
# Rscript -e 'Rclade::run_rclade_cli()' -- --help
run_rclade_cli(c("--help"))
```


---

## `run_rclade_shiny`

**启动 Rclade Shiny 交互应用**

启动基于 Shiny 的图形界面，通过上传树文件与参数交互式生成时间树图，无需编写代码。需要 `shiny` 包。

**用法：**

```r
run_rclade_shiny()
```

**返回值：**

无返回值，仅为副作用调用（启动 Shiny 网页应用，该应用会阻塞直到被关闭）。

**示例：**

```r
run_rclade_shiny()
```


---

## `run_rclade_selftest`

**运行 Rclade 自检**

运行内置的综合自检，用于安装后快速确认环境：

1. 必需依赖包的可用性与版本
1. 示例树解析与分类提取
1. 单系性逻辑校验

**用法：**

```r
run_rclade_selftest(verbose = TRUE)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `verbose` | 逻辑值。为 `TRUE`（默认）时通过 `message()` 报告进度与结果（可用 `suppressMessages()` 抑制）；为 `FALSE` 时静默运行，仅返回退出码。 |

**返回值：**

不可见地返回整数退出码（`0` = 全部通过，`1` = 有未通过项）。

**示例：**

```r
run_rclade_selftest()
```


---

## `batch_with_interrupt`

**带中断处理的批量执行**

对列表/向量逐项执行给定函数，带进度追踪，并能在用户中断（如 Ctrl+C）时优雅退出；被中断时会报告中止前已完成多少项。

**用法：**

```r
batch_with_interrupt(items, fun, label_fun = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `items` | 待处理的列表或向量。 |
| `fun` | 作用于每个元素的函数，接收 `(item, index)`。 |
| `label_fun` | 可选的、为每个元素生成标签的函数。 |

**返回值：**

返回各元素的处理结果列表（因用户中断而未处理的元素对应位置为 `NULL`）。

**示例：**

```r
trees <- list(example_tree, example_tree)
results <- batch_with_interrupt(trees, function(t, i) {
  plot_timetree(t, rank = "phylum", add_timescale = FALSE)
})
```


---

## `with_graceful_interrupt`

**带优雅中断处理的表达式执行**

包装表达式，使 SIGINT（Ctrl+C）被优雅捕获：报告进度、清理资源，并返回 `NULL` 而不抛出错误。

**用法：**

```r
with_graceful_interrupt(expr, total = 0)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `expr` | 待求值的表达式。 |
| `total` | 整数。用于进度追踪的总项数（批量模式）。 |

**返回值：**

返回表达式的求值结果；若被用户中断，则返回 `NULL`。

**示例：**

```r
result <- with_graceful_interrupt({
  for (i in 1:100) {
    Sys.sleep(0.1)
  }
  "done"
}, total = 100)
```


---


---

[英文](../../en/reference/cli-interactive.md) | [文档首页](../index.md)
