# Run Rclade self-test

Performs comprehensive self-check:

1.  Required package availability and versions

2.  Example tree parsing and taxonomy extraction

3.  Monophyly logic validation

## Usage

``` r
run_rclade_selftest(verbose = TRUE)
```

## Arguments

- verbose:

  Logical. If TRUE (default), progress and results are reported via
  [`message`](https://rdrr.io/r/base/message.html) (suppressible with
  [`suppressMessages`](https://rdrr.io/r/base/message.html)). If FALSE,
  the self-test runs silently and only the exit code is returned.

## Value

Integer. Exit code (0 = all passed, 1 = failures).
