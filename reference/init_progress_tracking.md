# Initialize progress tracking for a batch operation

Initialize progress tracking for a batch operation

## Usage

``` r
init_progress_tracking(total = 0, preserve_temp_files = FALSE)
```

## Arguments

- total:

  Integer. Total number of items to process.

- preserve_temp_files:

  Logical. If TRUE, do not reset temp_files list (used when nesting
  inside an already-active interrupt context).
