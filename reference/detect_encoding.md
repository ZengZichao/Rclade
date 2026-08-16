# Detect file encoding

Detect file encoding

## Usage

``` r
detect_encoding(filepath, n_lines = 10)
```

## Arguments

- filepath:

  Character. Path to file.

- n_lines:

  Integer. Number of initial lines sampled for UTF-8 validity (in
  addition to a fixed 10 KB raw-byte prefix used for BOM / endianness
  detection). Sampling the head is sufficient because BOM and byte-order
  markers appear at file start, and U+FFFD substitution surfaces early.

## Value

Character. Detected encoding name.
