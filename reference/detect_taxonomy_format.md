# Detect taxonomy format from tip labels

Detects Format A (embedded: `_d_Bacteria_p_...`) or Format B
(semicolon-delimited: `d__Bacteria;p__...`).

## Usage

``` r
detect_taxonomy_format(labels)
```

## Arguments

- labels:

  Character vector of tip labels

## Value

Format name: "embedded", "GTDB", "Silva", "NCBI", or "unknown"

## Regex heuristic boundaries (L-C3)

Detection and parsing here are **heuristic regex** passes, not a strict
grammar. Known boundaries the caller must respect:

- **Underscores in names**: under `delimiter_mode = "reverse"` the
  pattern uses `[^_]+?`, so an underscore inside a taxon name (e.g.
  `_g_Clostridium_sensu_stricto_s_X`) can be mis-read as a rank
  separator. Names that contain underscores should use
  `delimiter_mode = "segment"` (delimiter-to-delimiter extraction),
  which preserves embedded underscores. For Format B (`;`-delimited)
  underscores are safe.

- **Custom regex backtracking**: caller-supplied `custom_patterns` are
  inserted verbatim into the parser. Unbounded repeating groups (e.g.
  `(.+)+`) can cause **catastrophic backtracking** on adversarial
  labels. Patterns are rejected above the 200-character limit, but keep
  sub-patterns bounded and anchored.

- **Detection is content-based**: `detect_taxonomy_format` samples
  labels; a mixed or malformed corpus may return `"unknown"`, in which
  case the caller must fall back to an explicit `format=`.

- **GTDB requires a semicolon majority (M-B3)**: the GTDB rule
  additionally requires that more than half of sampled labels contain a
  semicolon. Accession-prefixed embedded labels with double-underscore
  rank separators (e.g. `GCA_xxx_d__Archaea_p__Nanoarchaeota`) satisfy
  the `[dpcofgsk]__` pattern but contain no semicolons; they are
  detected as `"embedded"` rather than misclassified as GTDB. The
  embedded parsers also tolerate double-underscore separators.
