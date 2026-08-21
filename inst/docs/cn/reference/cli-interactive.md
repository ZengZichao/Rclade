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

Rclade 的命令行入口，解析命令行参数并驱动批处理或单树绘制，便于在 shell / 流水线中调用。

**用法：**

```r
run_rclade_cli(args = commandArgs(trailingOnly = TRUE))
```

**参数：**

| 参数 | 说明 |
|------|------|
| `args` | 命令行参数字符向量，默认取 commandArgs(trailingOnly = TRUE)。 |

**返回值：**

按参数执行对应任务，返回结果（不可见）。

**示例：**

```r
# 在系统命令行中运行：
# Rscript -e 'Rclade::run_rclade_cli()' -- --help
run_rclade_cli(c("--help"))
```


---

## `run_rclade_shiny`

**启动 Rclade Shiny 交互应用**

启动基于 Shiny 的图形界面，通过上传树文件与参数交互式生成时间树图，无需编写代码。

**用法：**

```r
run_rclade_shiny()
```

**返回值：**

启动 Shiny 应用（阻塞式，直到关闭）。

**示例：**

```r
run_rclade_shiny()
```


---

## `run_rclade_selftest`

**运行 Rclade 自检**

运行内置自检流程，验证核心功能（读取、解析、折叠、绘图）是否正常，用于安装后快速确认环境。

**用法：**

```r
run_rclade_selftest()
```

**返回值：**

打印自检结果，返回是否全部通过的标志。

**示例：**

```r
run_rclade_selftest()
```


---

## `batch_with_interrupt`

**带中断处理的批量执行**

对列表/向量逐项执行给定函数，并在用户中断（如 Ctrl+C）时优雅退出，同时可选显示进度标签。

**用法：**

```r
batch_with_interrupt(items, fun, label_fun = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `items` | 待处理的列表或向量。 |
| `fun` | 作用于每个元素的函数，接收 (item, index)。 |
| `label_fun` | 可选的、为每个元素生成标签的函数。 |

**返回值：**

返回各元素的处理结果列表。

**示例：**

```r
items <- 1:5
batch_with_interrupt(items, function(x, i) {
  Sys.sleep(0.1)
  x * 2
})
```


---

## `with_graceful_interrupt`

**带优雅中断处理的表达式执行**

在表达式执行期间捕获中断信号，确保批量任务能被用户安全中止而不破坏状态。

**用法：**

```r
with_graceful_interrupt(expr, total = 0)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `expr` | 待求值的表达式。 |
| `total` | 用于进度追踪的总项数（批量模式）。 |

**返回值：**

返回表达式的求值结果。

**示例：**

```r
with_graceful_interrupt({
  for (i in 1:100) cat(i, "\n")
}, total = 100)
```


---


---

[英文](../../en/reference/cli-interactive.md) | [文档首页](../../index.md)
