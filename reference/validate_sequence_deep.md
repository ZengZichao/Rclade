# Deep validation of sequence files

Validates FASTA/FASTQ files: format detection, duplicate IDs, alphabet
detection, and alignment length consistency.

## Usage

``` r
validate_sequence_deep(
  filepath,
  expected_alphabet = NULL,
  check_alignment = FALSE
)
```

## Arguments

- filepath:

  Character. Path to sequence file.

- expected_alphabet:

  Character or NULL. Expected alphabet: "DNA", "RNA", "protein", or NULL
  for auto-detect.

- check_alignment:

  Logical. If TRUE, check all sequences have equal length.

## Value

List with validation results.

## Examples

``` r
if (FALSE) { # \dontrun{
result <- validate_sequence_deep("sequences.fasta", expected_alphabet = "DNA")
} # }
```
