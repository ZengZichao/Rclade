# Acquire an advisory file lock for the active log file (L-C5)

Uses the `filelock` package when available; otherwise it is a silent
no-op and parallel safety relies on the documented per-process log-file
convention. Lock acquisition is non-blocking (`timeout = 0`).

## Usage

``` r
.acquire_log_lock()
```
