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

Global switch that controls whether Rclade emits any log output at all.

**Usage:**

```r
set_log_enabled(enabled)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `enabled` | Logical. |

**Value:**

No return value, called for side effects (toggles the package-level logging enabled flag).

**Examples:**

```r
set_log_enabled(FALSE)  # turn off all logging
```


---

## `set_log_file`

Set log file for dual output

Log lines are written to the given file in addition to the console, which
makes post-hoc troubleshooting easier; pass `NULL` to disable file output.

**Usage:**

```r
set_log_file(filepath)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `filepath` | Character. Path to log file. NULL to disable. |

**Value:**

No return value, called for side effects (opens or closes a log file connection for dual console + file logging).

**Examples:**

```r
set_log_file("rclade.log")
```


---

## `set_log_level`

Set log level

Sets the minimum output level (`DEBUG` < `INFO` < `WARNING` < `ERROR` <
`CRITICAL`); messages below that level are suppressed.

**Usage:**

```r
set_log_level(level)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `level` | Character. One of "DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL". |

**Value:**

No return value, called for side effects (sets the package-level log threshold).

**Examples:**

```r
set_log_level("DEBUG")
```


---

## `log_info`

Log an INFO message

Emits a single `INFO` message, optionally tagged with a module label, and
supports concatenating several components.

**Usage:**

```r
log_info(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Value:**

No return value, called for side effects (the message is printed to the console and, when a log file is set, written to it).

**Examples:**

```r
log_info("Starting processing", .module = "main")
```


---

## `log_debug`

Log a DEBUG message

Emits detailed `DEBUG`-level information (visible only when the log level is
set to `DEBUG`).

**Usage:**

```r
log_debug(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Value:**

No return value, called for side effects (the message is printed to the console and, when a log file is set, written to it).

**Examples:**

```r
log_debug("variable x =", 42, .module = "parse")
```


---

## `log_warning`

Log a WARNING message

Emits a `WARNING` message about a potential problem that is not fatal.

**Usage:**

```r
log_warning(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Value:**

No return value, called for side effects (the message is printed to the console and, when a log file is set, written to it).

**Examples:**

```r
log_warning("Clade not monophyletic, skipped", .module = "collapse")
```


---

## `log_error`

Log an ERROR message

Emits an `ERROR` message, signalling that something went wrong (execution is
not interrupted).

**Usage:**

```r
log_error(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Value:**

No return value, called for side effects (the message is printed to the console and, when a log file is set, written to it; execution is not interrupted).

**Examples:**

```r
log_error("File not found", .module = "io")
```


---

## `log_critical`

Log a CRITICAL message

Emits the highest-severity `CRITICAL` message, reserved for severe failures
(logged only, execution is not interrupted).

**Usage:**

```r
log_critical(..., .module = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Message components (passed to sprintf if multiple). |
| `.module` | Character. Optional module/function tag (§15). Default: NULL. |

**Value:**

No return value, called for side effects (the message is printed to the console and, when a log file is set, written to it; logging a CRITICAL message does not stop execution).

**Examples:**

```r
log_critical("Out of memory", .module = "main")
```


---

## `log_section`

Print a formatted section header

Prints a section header framed with `=`, used to separate the main stages of
a pipeline.

**Usage:**

```r
log_section(title)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `title` | Character. Section title. |

**Value:**

No return value, called for side effects (the `=` section frame is printed unless logging is disabled; it is not filtered by the log level).

**Examples:**

```r
log_section("Stage 1: Reading data")
```


---

## `log_subsection`

Print a formatted subsection header

Prints a subsection header framed with `-`, used to split a section into
further steps.

**Usage:**

```r
log_subsection(title)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `title` | Character. Subsection title. |

**Value:**

No return value, called for side effects (the `-` subsection frame is printed unless logging is disabled; it is not filtered by the log level).

**Examples:**

```r
log_subsection("Sub-step: parsing labels")
```


---

## `log_progress`

Log a progress indicator

Emits a progress line of the form "current/total", handy for monitoring
long-running jobs.

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

**Value:**

No return value, called for side effects (an INFO progress line with a bar and percentage is emitted).

**Examples:**

```r
log_progress(3, 10, item = "Processing tree file")
```


---

## `log_keyvalue`

Log a key-value pair

Emits a structured log line in the form `key: value`.

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

**Value:**

No return value, called for side effects (the `key: value` line is emitted at `level`).

**Examples:**

```r
log_keyvalue("Number of nodes", 1234)
```


---

## `log_stats`

Print summary statistics

Prints a set of named statistics in tidy, aligned form.

**Usage:**

```r
log_stats(stats)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `stats` | Named list of statistics. |

**Value:**

No return value, called for side effects (one aligned INFO line per named statistic is emitted).

**Examples:**

```r
log_stats(list(files = 5, tips = 120))
```


---

## `log_table`

Print a formatted table

Prints a `data.frame` or a named list to the log as an aligned table.

**Usage:**

```r
log_table(data, title = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `data` | Named list or data.frame to display. |
| `title` | Character. Optional table title. |

**Value:**

No return value, called for side effects (one INFO line per row or entry is emitted; `title` is printed through `log_subsection()`).

**Examples:**

```r
log_table(data.frame(a = 1:3, b = letters[1:3]),
         title = "Statistics")
```


---

## `timer_start`

Start a timer for performance measurement

Starts a performance timer under the given name; pair it with `timer_stop()`
to measure how long a block of code takes.

**Usage:**

```r
timer_start(name)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `name` | Character. Timer name. |

**Value:**

No return value, called for side effects (records the start time in package-level state).

**Examples:**

```r
timer_start("pipeline")
```


---

## `timer_stop`

Stop a timer and log elapsed time

Stops the named timer and logs the elapsed time.

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

Numeric. Elapsed seconds, returned invisibly (`NA` if the timer was not started).

**Examples:**

```r
timer_stop("pipeline")
```


---


---

[中文](../../cn/reference/logging-timing.md) | [文档首页](../index.md)
