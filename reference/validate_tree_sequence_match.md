# Cross-validate tree tip labels against sequence IDs

Checks that all tree tips have corresponding sequences and vice versa.

## Usage

``` r
validate_tree_sequence_match(
  tree,
  sequence_file,
  quiet = FALSE,
  mol_type = NULL,
  skip_length_check = FALSE,
  multi_tree_mode = "error"
)
```

## Arguments

- tree:

  phylo object or path to tree file.

- sequence_file:

  Character. Path to sequence file (FASTA/FASTQ).

- quiet:

  Logical. If TRUE, suppress messages.

- mol_type:

  Character. Molecule type for sequence validation: "DNA", "RNA",
  "protein", or "auto" (NULL). Default: `NULL`.

- skip_length_check:

  Logical. If TRUE, skip alignment length consistency check. Default:
  `FALSE`.

- multi_tree_mode:

  Character. How to handle multiple trees in a file when `tree` is a
  path. Default: `"error"`.

## Value

List with match status and differences.

## Examples

``` r
if (FALSE) { # \dontrun{
result <- validate_tree_sequence_match("tree.nwk", "sequences.fasta")
} # }
```
