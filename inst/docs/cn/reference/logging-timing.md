# 日志与计时

提供结构化、分级的日志与计时功能，便于追踪流程运行状态。

本模块包含以下函数：

- [`set_log_enabled`](#set_log_enabled) — 启用或禁用日志
- [`set_log_file`](#set_log_file) — 设置日志文件（双输出）
- [`set_log_level`](#set_log_level) — 设置日志级别
- [`log_info`](#log_info) — 记录 INFO 级别日志
- [`log_debug`](#log_debug) — 记录 DEBUG 级别日志
- [`log_warning`](#log_warning) — 记录 WARNING 级别日志
- [`log_error`](#log_error) — 记录 ERROR 级别日志
- [`log_critical`](#log_critical) — 记录 CRITICAL 级别日志
- [`log_section`](#log_section) — 打印格式化的章节标题
- [`log_subsection`](#log_subsection) — 打印格式化的子章节标题
- [`log_progress`](#log_progress) — 记录进度指示
- [`log_keyvalue`](#log_keyvalue) — 记录键值对日志
- [`log_stats`](#log_stats) — 打印汇总统计
- [`log_table`](#log_table) — 打印格式化表格
- [`timer_start`](#timer_start) — 启动用于性能测量的计时器
- [`timer_stop`](#timer_stop) — 停止计时器并记录耗时

> 以下函数为内部函数（未导出）：`log_info`、`log_debug`、`log_warning`、`log_error`、`log_critical`、`log_section`、`log_subsection`、`log_progress`、`log_keyvalue`、`log_stats`、`log_table`、`timer_start`、`timer_stop`，须以 `Rclade:::log_info()` 形式调用。

## `set_log_enabled`

**启用或禁用日志**

全局开关，控制 Rclade 的日志输出是否生效。

**用法：**

```r
set_log_enabled(enabled)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `enabled` | 逻辑值。 |

**返回值：**

无返回值，仅为副作用调用（切换包级日志开关）。

**示例：**

```r
set_log_enabled(FALSE)  # 关闭所有日志
```


---

## `set_log_file`

**设置日志文件（双输出）**

将日志同时写入指定文件（与控制台并存），便于事后排查；传入 `NULL` 可关闭文件输出。

**用法：**

```r
set_log_file(filepath)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 字符串，日志文件路径；`NULL` 表示关闭文件输出。 |

**返回值：**

无返回值，仅为副作用调用（打开或关闭日志文件连接，实现控制台 + 文件双输出日志）。

**示例：**

```r
set_log_file("rclade.log")
```


---

## `set_log_level`

**设置日志级别**

设定最低输出级别（`DEBUG` < `INFO` < `WARNING` < `ERROR` < `CRITICAL`），低于该级别的日志将被抑制。

**用法：**

```r
set_log_level(level)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `level` | 字符串，级别取 `DEBUG` / `INFO` / `WARNING` / `ERROR` / `CRITICAL` 之一。 |

**返回值：**

无返回值，仅为副作用调用（设置包级日志阈值）。

**示例：**

```r
set_log_level("DEBUG")
```


---

## `log_info`

**记录 INFO 级别日志**

输出一条 `INFO` 级日志消息，可附加模块标签，支持多段拼接。

**用法：**

```r
log_info(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段（多段时按 `sprintf` 规则拼接）。 |
| `.module` | 字符串，可选的模块/函数标签（§15），默认 `NULL`。 |

**返回值：**

无返回值，仅为副作用调用（消息打印到控制台；若已设置日志文件，同时写入该文件）。

**示例：**

```r
Rclade:::log_info("Starting processing", .module = "main")
```


---

## `log_debug`

**记录 DEBUG 级别日志**

输出 `DEBUG` 级详细调试信息（仅在级别设为 `DEBUG` 时可见）。

**用法：**

```r
log_debug(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段（多段时按 `sprintf` 规则拼接）。 |
| `.module` | 字符串，可选的模块/函数标签（§15），默认 `NULL`。 |

**返回值：**

无返回值，仅为副作用调用（消息打印到控制台；若已设置日志文件，同时写入该文件）。

**示例：**

```r
Rclade:::log_debug("variable x =", 42, .module = "parse")
```


---

## `log_warning`

**记录 WARNING 级别日志**

输出一条 `WARNING` 级日志，提示潜在但不致命的问题。

**用法：**

```r
log_warning(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段（多段时按 `sprintf` 规则拼接）。 |
| `.module` | 字符串，可选的模块/函数标签（§15），默认 `NULL`。 |

**返回值：**

无返回值，仅为副作用调用（消息打印到控制台；若已设置日志文件，同时写入该文件）。

**示例：**

```r
Rclade:::log_warning("Clade not monophyletic, skipped", .module = "collapse")
```


---

## `log_error`

**记录 ERROR 级别日志**

输出一条 `ERROR` 级日志，表示发生了错误（不中断执行）。

**用法：**

```r
log_error(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段（多段时按 `sprintf` 规则拼接）。 |
| `.module` | 字符串，可选的模块/函数标签（§15），默认 `NULL`。 |

**返回值：**

无返回值，仅为副作用调用（消息打印到控制台；若已设置日志文件，同时写入该文件；不会中断执行）。

**示例：**

```r
Rclade:::log_error("File not found", .module = "io")
```


---

## `log_critical`

**记录 CRITICAL 级别日志**

输出最高级别 `CRITICAL` 日志，用于严重故障（仅记录，不中断执行）。

**用法：**

```r
log_critical(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段（多段时按 `sprintf` 规则拼接）。 |
| `.module` | 字符串，可选的模块/函数标签（§15），默认 `NULL`。 |

**返回值：**

无返回值，仅为副作用调用（消息打印到控制台；若已设置日志文件，同时写入该文件；记录 CRITICAL 消息不会停止执行）。

**示例：**

```r
Rclade:::log_critical("Out of memory", .module = "main")
```


---

## `log_section`

**打印格式化的章节标题**

输出带 `=` 分隔框的章节标题，用于划分流程的主要阶段。

**用法：**

```r
log_section(title)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `title` | 字符串，章节标题文本。 |

**返回值：**

无返回值，仅为副作用调用（除非日志被禁用，否则打印 `=` 章节框；它不受日志级别过滤）。

**示例：**

```r
Rclade:::log_section("Stage 1: Reading data")
```


---

## `log_subsection`

**打印格式化的子章节标题**

输出带 `-` 分隔框的子章节标题，用于在章节内进一步细分步骤。

**用法：**

```r
log_subsection(title)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `title` | 字符串，子章节标题文本。 |

**返回值：**

无返回值，仅为副作用调用（除非日志被禁用，否则打印 `-` 子章节框；它不受日志级别过滤）。

**示例：**

```r
Rclade:::log_subsection("Sub-step: parsing labels")
```


---

## `log_progress`

**记录进度指示**

输出形如“当前/总数”的进度条式日志，便于长任务监控。

**用法：**

```r
log_progress(current, total, item = "")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `current` | 整数，当前进度。 |
| `total` | 整数，总项数。 |
| `item` | 字符串，当前项的描述文本。 |

**返回值：**

无返回值，仅为副作用调用（输出一条带进度条和百分比的 INFO 进度行）。

**示例：**

```r
Rclade:::log_progress(3, 10, item = "Processing tree file")
```


---

## `log_keyvalue`

**记录键值对日志**

以“键: 值”形式输出一条结构化的键值日志。

**用法：**

```r
log_keyvalue(key, value, level = "INFO")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `key` | 字符串，键名。 |
| `value` | 任意类型，要显示的值。 |
| `level` | 字符串，日志级别，默认 `INFO`。 |

**返回值：**

无返回值，仅为副作用调用（`key: value` 行按 `level` 输出）。

**示例：**

```r
Rclade:::log_keyvalue("Number of nodes", 1234)
```


---

## `log_stats`

**打印汇总统计**

以整齐格式输出一组命名统计指标。

**用法：**

```r
log_stats(stats)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `stats` | 具名列表，各项统计指标。 |

**返回值：**

无返回值，仅为副作用调用（每个具名统计量输出一条对齐的 INFO 行）。

**示例：**

```r
Rclade:::log_stats(list(files = 5, tips = 120))
```


---

## `log_table`

**打印格式化表格**

将 `data.frame` 或具名列表以对齐表格形式输出到日志。

**用法：**

```r
log_table(data, title = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `data` | 具名列表或 `data.frame`，要显示的数据。 |
| `title` | 字符串，可选的表格标题。 |

**返回值：**

无返回值，仅为副作用调用（每行/每条记录输出一条 INFO 行；`title` 通过 `log_subsection()` 打印）。

**示例：**

```r
Rclade:::log_table(data.frame(a = 1:3, b = letters[1:3]),
         title = "Statistics")
```


---

## `timer_start`

**启动用于性能测量的计时器**

以给定名称启动一个性能计时器，配合 `timer_stop()` 测量代码段耗时。

**用法：**

```r
timer_start(name)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `name` | 字符串，计时器名称。 |

**返回值：**

无返回值，仅为副作用调用（在包级状态中记录起始时间）。

**示例：**

```r
Rclade:::timer_start("pipeline")
```


---

## `timer_stop`

**停止计时器并记录耗时**

停止指定计时器，记录并输出耗时。

**用法：**

```r
timer_stop(name, level = "INFO")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `name` | 字符串，计时器名称。 |
| `level` | 字符串，日志级别，默认 `INFO`。 |

**返回值：**

数值型。不可见地返回耗时秒数（若计时器未启动则返回 `NA`）。

**示例：**

```r
Rclade:::timer_stop("pipeline")
```


---


---

[英文](../../en/reference/logging-timing.md) | [文档首页](../index.md)
