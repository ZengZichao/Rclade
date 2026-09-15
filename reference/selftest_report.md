# Report a self-test progress line

All self-test reporting goes through
[`message`](https://rdrr.io/r/base/message.html) (stderr) so that it can
be suppressed with
[`suppressMessages`](https://rdrr.io/r/base/message.html); plain
[`cat()`](https://rdrr.io/r/base/cat.html) output cannot be suppressed
by the user (CRAN policy on console output).

## Usage

``` r
selftest_report(verbose, ...)
```

## Arguments

- verbose:

  Logical. Output only when TRUE.

- ...:

  Passed to [`message`](https://rdrr.io/r/base/message.html).
