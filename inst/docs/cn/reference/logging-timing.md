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
- [`log_section`](#log_section) — 打印格式化的一级标题
- [`log_subsection`](#log_subsection) — 打印格式化的二级标题
- [`log_progress`](#log_progress) — 记录进度指示
- [`log_keyvalue`](#log_keyvalue) — 记录键值对日志
- [`log_stats`](#log_stats) — 打印汇总统计
- [`log_table`](#log_table) — 打印格式化表格
- [`timer_start`](#timer_start) — 启动计时器
- [`timer_stop`](#timer_stop) — 停止计时器并记录耗时

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
| `enabled` | 逻辑值，TRUE 启用、FALSE 禁用。 |

**返回值：**

无返回值，仅设置全局状态。

**示例：**

```r
set_log_enabled(FALSE)  # 关闭所有日志
```


---

## `set_log_file`

**设置日志文件（双输出）**

将日志同时写入指定文件（与控制台并存），便于事后排查；传入 NULL 可关闭文件输出。

**用法：**

```r
set_log_file(filepath)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 日志文件路径；NULL 表示关闭文件输出。 |

**返回值：**

无返回值，仅设置全局状态。

**示例：**

```r
set_log_file("rclade.log")
```


---

## `set_log_level`

**设置日志级别**

设定最低输出级别（DEBUG < INFO < WARNING < ERROR < CRITICAL），低于该级别的日志将被抑制。

**用法：**

```r
set_log_level(level)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `level` | 级别字符串：DEBUG / INFO / WARNING / ERROR / CRITICAL。 |

**返回值：**

无返回值，仅设置全局状态。

**示例：**

```r
set_log_level("DEBUG")
```


---

## `log_info`

**记录 INFO 级别日志**

输出一条 INFO 级日志消息，可附加模块标签，支持多段拼接。

**用法：**

```r
log_info(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段（多段时按 sprintf 规则拼接）。 |
| `.module` | 可选的模块/函数标签，默认 NULL。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_info("开始处理", .module = "main")
```


---

## `log_debug`

**记录 DEBUG 级别日志**

输出 DEBUG 级详细调试信息（仅在级别设为 DEBUG 时可见）。

**用法：**

```r
log_debug(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段。 |
| `.module` | 可选的模块标签。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_debug("变量 x =", 42, .module = "parse")
```


---

## `log_warning`

**记录 WARNING 级别日志**

输出一条 WARNING 级日志，提示潜在但不致命的问题。

**用法：**

```r
log_warning(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段。 |
| `.module` | 可选的模块标签。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_warning("分支非单系，已跳过", .module = "collapse")
```


---

## `log_error`

**记录 ERROR 级别日志**

输出一条 ERROR 级日志，表示发生了错误（不中断执行）。

**用法：**

```r
log_error(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段。 |
| `.module` | 可选的模块标签。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_error("文件不存在", .module = "io")
```


---

## `log_critical`

**记录 CRITICAL 级别日志**

输出最高级别 CRITICAL 日志，表示严重的、通常需终止流程的问题。

**用法：**

```r
log_critical(..., .module = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 消息片段。 |
| `.module` | 可选的模块标签。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_critical("内存耗尽", .module = "main")
```


---

## `log_section`

**打印格式化的一级标题**

输出带分隔线的章节标题，用于划分流程的主要阶段。

**用法：**

```r
log_section(title)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `title` | 章节标题文本。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_section("阶段一：读取数据")
```


---

## `log_subsection`

**打印格式化的二级标题**

输出子章节标题，用于在章节内进一步细分步骤。

**用法：**

```r
log_subsection(title)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `title` | 子章节标题文本。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_subsection("子步骤：解析标签")
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
| `current` | 当前进度（整数）。 |
| `total` | 总项数（整数）。 |
| `item` | 当前项的描述文本。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_progress(3, 10, item = "处理树文件")
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
| `key` | 键名。 |
| `value` | 要显示的值（任意类型）。 |
| `level` | 日志级别，默认 INFO。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_keyvalue("树节点数", 1234)
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
| `stats` | 具名统计列表。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_stats(list(files = 5, tips = 120))
```


---

## `log_table`

**打印格式化表格**

将 data.frame 或具名列表以对齐表格形式输出到日志。

**用法：**

```r
log_table(data, title = NULL)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `data` | 要显示的具名列表或 data.frame。 |
| `title` | 可选的表格标题。 |

**返回值：**

无返回值，打印到日志。

**示例：**

```r
log_table(data.frame(a = 1:3, b = letters[1:3]),
         title = "统计")
```


---

## `timer_start`

**启动计时器**

以给定名称启动一个性能计时器，配合 timer_stop 测量代码段耗时。

**用法：**

```r
timer_start(name)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `name` | 计时器名称。 |

**返回值：**

无返回值，记录起始时间。

**示例：**

```r
timer_start("pipeline")
```


---

## `timer_stop`

**停止计时器并记录耗时**

停止指定计时器，记录并输出经过的时间。

**用法：**

```r
timer_stop(name, level = "INFO")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `name` | 计时器名称。 |
| `level` | 日志级别，默认 INFO。 |

**返回值：**

返回经过的秒数（不可见）。

**示例：**

```r
timer_stop("pipeline")
```


---


---

[英文](../../en/reference/logging-timing.md) | [文档首页](../../index.md)
