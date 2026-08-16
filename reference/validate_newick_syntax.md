# Validate Newick string syntax

Performs deep syntax validation on a raw Newick string before parsing.
Checks bracket balance, negative branch lengths, empty node names,
duplicate node names, and self-loops.

## Usage

``` r
validate_newick_syntax(text, filepath = "<string>")
```

## Arguments

- text:

  Character. Raw Newick string.

- filepath:

  Character. File path for error messages.

## Value

Invisibly returns TRUE if valid. Stops on CRITICAL errors.

## Heuristics & error contract (L-C3 / L-E3)

The syntax checks are **regex heuristics** over the raw string and may
occasionally **false-positive or false-negative** on exotic input (e.g.
unusual quoting, deeply nested labels). They are a fast pre-filter; the
authoritative correctness check is the structural validation that runs
after the tree is parsed. Do not treat a clean heuristic pass as a full
guarantee.

On failure these validators raise via
`rlang::abort(message, class = "Rclade_validate_error")` (or
`"Rclade_read_error"` for I/O problems). **Callers must branch on the
condition `class`, never `grep` the message text** — this is the
supported contract and prevents brittle tests when wording changes.
