# Logging & Timing

Structured, leveled logging and timers for pipeline observability.

This module contains the following functions:

- [`set_log_enabled`](#set_log_enabled) — Enable or disable logging
- [`set_log_file`](#set_log_file) — Set log file for dual output
- [`set_log_level`](#set_log_level) — Set log level
- [`log_info`](#log_info) — Log an INFO message
- [`log_debug`](#log_debug) — Log a DEBUG message
- [`log_warning`](#log_warning) — Log a WARNING message
- [`log_error`](#log_error) — Log an ERROR message
- [`log_critical`](#log_critical) — Log a CRITICAL message
- [`log_section`](#log_section) — Print a formatted section header
- [`log_subsection`](#log_subsection) — Print a formatted subsection header
- [`log_progress`](#log_progress) — Log a progress indicator
- [`log_keyvalue`](#log_keyvalue) — Log a key-value pair
- [`log_stats`](#log_stats) — Print summary statistics
- [`log_table`](#log_table) — Print a formatted table
- [`timer_start`](#timer_start) — Start a timer for performance measurement
- [`timer_stop`](#timer_stop) — Stop a timer and log elapsed time

## `set_log_enabled`

Enable or disable logging

**Usage:**

```r
set_log_enabled(enabled)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `enabled` | Logical. |

**Examples:**

```r
set_log_enabled(FALSE)  # turn off all logging
```


---

## `set_log_file`

Set log file for dual output

**Usage:**

```r
set_log_file(filepath)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `filepath` | Character. Path to log file. NULL to disable. |

**Examples:**

```r
set_log_file("rclade.log")
```


---

## `set_log_level`

Set log level

**Usage:**

```r
set_log_level(level)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `level` | Character. One of "DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL". |

**Examples:**

```r
set_log_level("DEBUG")
```


---

## `log_info`

Log an INFO message

**Usage:**

```r
log_info(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Examples:**

```r
log_info("Starting processing", .module = "main")
```


---

## `log_debug`

Log a DEBUG message

**Usage:**

```r
log_debug(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Examples:**

```r
log_debug("variable x =", 42, .module = "parse")
```


---

## `log_warning`

Log a WARNING message

**Usage:**

```r
log_warning(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Examples:**

```r
log_warning("Clade not monophyletic, skipped", .module = "collapse")
```


---

## `log_error`

Log an ERROR message

**Usage:**

```r
log_error(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Examples:**

```r
log_error("File not found", .module = "io")
```


---

## `log_critical`

Log a CRITICAL message

**Usage:**

```r
log_critical(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Examples:**

```r
log_critical("Out of memory", .module = "main")
```


---

## `log_section`

Print a formatted section header

**Usage:**

```r
log_section(title)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `title` | Character. Section title. |

**Examples:**

```r
log_section("Stage 1: Reading data")
```


---

## `log_subsection`

Print a formatted subsection header

**Usage:**

```r
log_subsection(title)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `title` | Character. Subsection title. |

**Examples:**

```r
log_subsection("Sub-step: parsing labels")
```


---

## `log_progress`

Log a progress indicator

**Usage:**

```r
log_progress(current, total, item = "")
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `current` | Integer. Current progress. |
| `total` | Integer. Total items. |
| `item` | Character. Description of current item. |

**Examples:**

```r
log_progress(3, 10, item = "Processing tree file")
```


---

## `log_keyvalue`

Log a key-value pair

**Usage:**

```r
log_keyvalue(key, value, level = "INFO")
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `key` | Character. Key name. |
| `value` | Any. Value to display. |
| `level` | Character. Log level. Default: "INFO". |

**Examples:**

```r
log_keyvalue("Number of nodes", 1234)
```


---

## `log_stats`

Print summary statistics

**Usage:**

```r
log_stats(stats)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `stats` | Named list of statistics. |

**Examples:**

```r
log_stats(list(files = 5, tips = 120))
```


---

## `log_table`

Print a formatted table

**Usage:**

```r
log_table(data, title = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `data` | Named list or data.frame to display. |
| `title` | Character. Optional table title. |

**Examples:**

```r
log_table(data.frame(a = 1:3, b = letters[1:3]),
         title = "Statistics")
```


---

## `timer_start`

Start a timer for performance measurement

**Usage:**

```r
timer_start(name)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `name` | Character. Timer name. |

**Examples:**

```r
timer_start("pipeline")
```


---

## `timer_stop`

Stop a timer and log elapsed time

**Usage:**

```r
timer_stop(name, level = "INFO")
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `name` | Character. Timer name. |
| `level` | Character. Log level. Default: "INFO". |

**Value:**

Numeric. Elapsed seconds.

**Examples:**

```r
timer_stop("pipeline")
```


---


---

[中文](../../cn/reference/logging-timing.md) | [文档首页](../../index.md)
