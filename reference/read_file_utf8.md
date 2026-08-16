# Read file with explicit UTF-8 encoding

Attempts UTF-8 first, falls back to a byte-level read (utf-8-sig
equivalent) on failure. Any occurrence of the Unicode replacement
character `U+FFFD` (a sign of mojibake / invalid bytes silently
substituted by the reader) is reported via `log_warning`, or aborts when
`strict = TRUE` (M-C3).

## Usage

``` r
read_file_utf8(filepath, warn = TRUE, strict = FALSE)
```

## Arguments

- filepath:

  Character. Path to file.

- warn:

  Logical. Whether to warn on encoding fallback.

- strict:

  Logical. If `TRUE`, abort (class `Rclade_parse_error`) instead of only
  warning when `U+FFFD` is detected. Default: `FALSE`.

## Value

Character vector of file lines.
