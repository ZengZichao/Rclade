# Check for malicious characters in node names

Detects control characters and Unicode bidirectional text markers that
could be used for display spoofing.

## Usage

``` r
check_malicious_chars(names, filepath = "<unknown>")
```

## Arguments

- names:

  Character vector of node names to check.

- filepath:

  Character. Source file for error messages.

## Value

Invisibly returns TRUE if clean. Stops on detection.
