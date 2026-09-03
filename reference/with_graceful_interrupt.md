# Execute expression with graceful interrupt handling

Wraps an expression so that SIGINT (Ctrl+C) is caught gracefully:
progress is reported, resources are cleaned up, and the function returns
NULL instead of throwing an error.

## Usage

``` r
with_graceful_interrupt(expr, total = 0)
```

## Arguments

- expr:

  Expression to evaluate.

- total:

  Integer. Total items for progress tracking (batch mode).

## Value

Result of expr, or NULL if interrupted.
