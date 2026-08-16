# Validate sequence file format

Validate sequence file format

## Usage

``` r
validate_sequence_file(filepath)
```

## Arguments

- filepath:

  Character. Path to sequence file.

## Value

Character. Detected format: "fasta", "fastq", "unknown".

## Examples

``` r
if (FALSE) { # \dontrun{
format <- validate_sequence_file("sequences.fasta")
} # }
```
