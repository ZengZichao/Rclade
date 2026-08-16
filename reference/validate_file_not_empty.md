# Validate file is not empty

Checks file size and raises CRITICAL if empty.

## Usage

``` r
validate_file_not_empty(filepath, file_type = "input")
```

## Arguments

- filepath:

  Character. Path to file.

- file_type:

  Character. Description for error messages.

## Value

Invisibly returns TRUE if not empty. Stops on empty file.
