# Create and manage temporary file with automatic cleanup

Creates a temporary file and registers cleanup via on.exit().

## Usage

``` r
managed_tempfile(pattern = "rclade_", fileext = ".tmp", tmpdir = tempdir())
```

## Arguments

- pattern:

  Character. File name pattern.

- fileext:

  Character. File extension.

- tmpdir:

  Character. Temporary directory. Default: tempdir().

## Value

List with path and cleanup function.
