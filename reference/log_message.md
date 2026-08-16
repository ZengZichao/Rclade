# Log a message with real-time flush

Log a message with real-time flush

## Usage

``` r
log_message(level, ..., .flush = TRUE, .module = NULL)
```

## Arguments

- level:

  Character. Log level.

- ...:

  Message components.

- .flush:

  Logical. Whether to flush immediately. Default: TRUE.

- .module:

  Character. Optional module/function tag for §15 error message format.
  When non-empty, inserted as `[MODULE]` between the level and the
  message. Example: `.module = "parse_taxonomy"`.
