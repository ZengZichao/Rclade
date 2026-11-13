# Command-line & Interactive Interfaces

Run Rclade from the command line, launch the Shiny app, run the self-test, and batch with interruption handling.

This module contains the following functions:

- [`run_rclade_cli`](#run_rclade_cli) — Run Rclade from the command line
- [`run_rclade_shiny`](#run_rclade_shiny) — Launch Rclade Shiny app
- [`run_rclade_selftest`](#run_rclade_selftest) — Run Rclade self-test
- [`batch_with_interrupt`](#batch_with_interrupt) — Execute batch operation with interrupt handling and progress
- [`with_graceful_interrupt`](#with_graceful_interrupt) — Execute expression with graceful interrupt handling

> Not exported (internal): `batch_with_interrupt`, `with_graceful_interrupt`. Call them as `Rclade:::batch_with_interrupt()`.

## `run_rclade_cli`

Run Rclade from the command line

Provides a command-line interface for Rclade. Requires the optparse package.

**Usage:**

```r
run_rclade_cli(args = commandArgs(trailingOnly = TRUE))
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `args` | Character vector of command-line arguments (default: commandArgs(trailingOnly = TRUE)) |

**Value:**

Invisible integer exit code following standard Unix conventions: `0L` (success), `1L` (self-test failures, returned only by the `--check` path), `2L` (parameter error), `3L` (input-data error), `130L` (user interrupt / SIGINT). Runtime errors are not converted into a return value: they are re-raised as R errors, which make `Rscript` exit with status 1. The caller MUST forward this value to `q(status = ...)` or `quit(status = ...)`; simply calling `run_rclade_cli()` without forwarding the return value always exits with code 0 regardless of errors.

**Examples:**

```r
# At the system command line run:
# Rscript -e 'Rclade::run_rclade_cli()' -- --help
run_rclade_cli(c("--help"))
```


---

## `run_rclade_shiny`

Launch Rclade Shiny app

Provides an interactive web interface for Rclade. Requires the shiny package.

**Usage:**

```r
run_rclade_shiny()
```

**Value:**

No return value, called for side effects (launches the Shiny web app, which blocks until the app is stopped).

**Examples:**

```r
run_rclade_shiny()
```


---

## `run_rclade_selftest`

Run Rclade self-test

Performs comprehensive self-check:

1. Required package availability and versions
1. Example tree parsing and taxonomy extraction
1. Monophyly logic validation
1. Deep input-validation checks (malformed trees and sequences)

**Usage:**

```r
run_rclade_selftest(verbose = TRUE)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `verbose` | Logical. If `TRUE` (default), progress and results are reported via `message()` (suppressible with `suppressMessages()`); if `FALSE`, the self-test runs silently and only the exit code is returned. |

**Value:**

Integer. Exit code (0 = all passed, 1 = failures), returned invisibly.

**Examples:**

```r
run_rclade_selftest()
```


---

## `batch_with_interrupt`

Execute batch operation with interrupt handling and progress

Processes a list of items with progress tracking and graceful
interrupt handling. If interrupted, reports how many items were
completed before stopping.

**Usage:**

```r
batch_with_interrupt(items, fun, label_fun = NULL)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `items` | List or vector of items to process. |
| `fun` | Function to apply to each item. Receives (item, index). |
| `label_fun` | Optional function to generate label for each item. |

**Value:**

List of results (NULL for items not processed due to interrupt).

**Examples:**

```r
data(example_tree)
trees <- list(example_tree, example_tree)
results <- Rclade:::batch_with_interrupt(trees, function(t, i) {
  plot_timetree(t, rank = "phylum", add_timescale = FALSE)
})
```


---

## `with_graceful_interrupt`

Execute expression with graceful interrupt handling

Wraps an expression so that SIGINT (Ctrl+C) is caught gracefully:
progress is reported, resources are cleaned up, and the function
returns NULL instead of throwing an error.

**Usage:**

```r
with_graceful_interrupt(expr, total = 0)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `expr` | Expression to evaluate. |
| `total` | Integer. Total items for progress tracking (batch mode). |

**Value:**

Result of expr, or NULL if interrupted.

**Examples:**

```r
result <- Rclade:::with_graceful_interrupt({
  for (i in 1:100) {
    Sys.sleep(0.1)
  }
  "done"
}, total = 100)
```


---


---

[中文](../../cn/reference/cli-interactive.md) | [Documentation Home](../index.md)
