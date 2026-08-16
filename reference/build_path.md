# Build file path safely (cross-platform)

Wrapper around file.path() to ensure consistent path construction. Never
use paste() or sprintf() for path construction.

## Usage

``` r
build_path(...)
```

## Arguments

- ...:

  Path components.

## Value

Character. Constructed path.

## Examples

``` r
if (FALSE) { # \dontrun{
build_path("data", "output", "tree.pdf")
} # }
```
