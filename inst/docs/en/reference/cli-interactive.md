# Command-line & Interactive Interfaces

Run Rclade from the command line, launch the Shiny app, run the self-test, and batch with interruption handling.

This module contains the following functions:

- [`run_rclade_cli`](#run_rclade_cli) — Run Rclade from the command line
- [`run_rclade_shiny`](#run_rclade_shiny) — Launch Rclade Shiny app
- [`run_rclade_selftest`](#run_rclade_selftest) — Run Rclade self-test
- [`batch_with_interrupt`](#batch_with_interrupt) — Execute batch operation with interrupt handling and progress
- [`with_graceful_interrupt`](#with_graceful_interrupt) — Execute expression with graceful interrupt handling

## `run_rclade_cli`

Provides a command-line interface for Rclade. Requires the optparse package.

**Usage:**

```r
run_rclade_cli(args = commandArgs(trailingOnly = TRUE))
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `args` | Character vector of command-line arguments (default: commandArgs(trailingOnly = TRUE)) |

**Examples:**

```r
# At the system command line run:
# Rscript -e 'Rclade::run_rclade_cli()' -- --help
run_rclade_cli(c("--help"))
```


---

## `run_rclade_shiny`

Provides an interactive web interface for Rclade. Requires the shiny package.

**Usage:**

```r
run_rclade_shiny()
```

**Examples:**

```r
run_rclade_shiny()
```


---

## `run_rclade_selftest`

Performs comprehensive self-check:

1. Required package availability and versions
1. Example tree parsing and taxonomy extraction
1. Monophyly logic validation

**Usage:**

```r
run_rclade_selftest()
```

**Value:**

Integer. Exit code (0 = all passed, 1 = failures).

**Examples:**

```r
run_rclade_selftest()
```


---

## `batch_with_interrupt`

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
trees <- list(tree1, tree2, tree3)
results <- batch_with_interrupt(trees, function(t, i) {
  plot_timetree(t, rank = "phylum")
})
```


---

## `with_graceful_interrupt`

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
result <- with_graceful_interrupt({
  for (i in 1:100) {
    Sys.sleep(0.1)
  }
  "done"
})
```


---


---

[中文](../../cn/reference/cli-interactive.md) | [文档首页](../../index.md)
