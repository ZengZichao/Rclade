# Parse Format A: Embedded taxonomy labels

Parses labels like
`GB_GCA_000252485.1_d_Bacteria_p_Cyanobacteriota_c_...` using delimiters
`_d_`, `_p_`, `_c_`, `_o_`, `_f_`, `_g_`, `_s_`.

## Usage

``` r
parse_embedded(labels, levels = NULL, delimiter_mode = "reverse")
```

## Arguments

- labels:

  Character vector of tip labels

- levels:

  List with codes and names vectors for taxonomy levels.

- delimiter_mode:

  Character. One of `"reverse"`, `"greedy"`, `"segment"`. Default:
  `"reverse"`.

## Value

data.frame with taxonomy columns

## Details

Supports three delimiter matching strategies:

- `"reverse"` (default): match ranks from right-to-left to reduce
  ambiguity when taxonomy names contain underscores.

- `"greedy"`: match ranks left-to-right using a character-class boundary
  (faster but less robust to underscores in names).

- `"segment"`: extract the segment between each rank delimiter and the
  next rank delimiter, preserving underscores within values.

All three strategies tolerate double-underscore rank separators (e.g.
`_p__Nanoarchaeota`, common in accession-prefixed embedded labels);
leading underscores left over from such schemes are trimmed from parsed
values.
