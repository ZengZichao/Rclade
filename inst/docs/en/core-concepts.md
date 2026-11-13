# Core Concepts

This page explains the ideas behind Rclade so the function arguments make sense.

## Taxonomy formats

Rclade reads the taxonomic assignment of each tip from its **label**. Several formats are supported:

| Format | Example label | Detected by |
|--------|---------------|-------------|
| GTDB | `d__Bacteria;p__Firmicutes;c__Bacilli` | prefix `d__`/`p__`/..., and semicolons in the majority |
| Silva | `Bacteria;Firmicutes;Bacilli` | semicolon ranks with no codes, led by `Bacteria`/`Archaea`/`Eukaryota` |
| NCBI | `cellular organisms; Bacteria; Firmicutes` | semicolon ranks led by an NCBI root token (`cellular organisms`, `root`, …) |
| embedded (custom_rank / Format A) | `species_d_Bacteria_p_Firmicutes` | single-letter codes wrapped in underscores: `_d_`/`_p_`/... |
| custom_regex | `Domain:Bacteria\|Phylum:Firmicutes` | user regex |

Detection is automatic (`taxonomy_format = "auto"`). To force a format, set `taxonomy_format` explicitly. See [detect_taxonomy_format](reference/taxonomy-parsing.md) and [parse_taxonomy](reference/taxonomy-parsing.md).

## MRCA-based collapsing

"Collapsing" means replacing a whole clade with a single triangle whose width encodes the clade's age range. Rclade finds the **MRCA** (Most Recent Common Ancestor) of all tips that share a taxonomic group, then draws a triangle for that clade.

You can collapse in three ways:

- **By rank** — `rank = "phylum"` collapses every phylum at once.
- **By named group** — `groups = list(GroupA = c("tip1","tip2"))` collapses a custom set (must be monophyletic; check with [validate_custom_groups](reference/taxonomy-parsing.md)).
- **By specific clade** — `clade = "Cyanobacteriota"` collapses only that named clade.

### Monophyly matters

A group can only be collapsed cleanly if it is **monophyletic** (all descendants share one MRCA). Groups collapsed by `rank` or `clade` trigger a warning and are skipped by default (`strict = FALSE`); set `strict = TRUE` to abort instead. Custom `groups` are validated up front, where a non-monophyletic group always aborts. Check with [check_monophyly](reference/tree-sequence.md).

### Triangle and space modes

- `triangle_mode`: how the triangle's width is drawn — `max`, `min`, `mixed` (adaptive), or `none`.
- `space_mode`: `proportional` gives more vertical room to larger clades; `equal` gives each clade the same room.

## Geological timescale

Rclade adds a geological timescale to the x-axis using `deeptime` (ICS 2023/02).

- `unit`: the unit of your tree's edge lengths — `Ma` (mega-annum) or `Ga` (giga-annum). Required whenever `add_timescale = TRUE`: Rclade never infers the unit, so leaving it `NULL` aborts.
- `timescale_levels`: which bands to show — `eras`, `eons`, `periods`.
- `add_timescale = FALSE` disables it. Circular layouts do support a timescale (`timescale_mode = "radial"` by default), so disable it only when you want a plain fan, e.g. for cladograms.

## Colors and legend

- `color_palette`: `viridis` (default, color-blind safe), any RColorBrewer name, `rainbow`, or a color vector.
- `color_mapping`: a named vector for exact control, e.g. `c("Proteobacteria" = "#E41A1C")`.
- `color_rank`: color by a rank different from the one you collapse on.
- Legend rows/columns are auto-computed from the number of groups (position defaults to `"bottom"`); override with `legend_position`, `legend_nrow`, `legend_ncol`. For very large legends, see [split_legend](reference/colors-legend.md).

## Special identifiers

Rclade understands ancestral nodes of life:

- `LUCA` — Last Universal Common Ancestor (MRCA of Bacteria + Archaea)
- `LACA` — Last Archaeal Common Ancestor
- `LBCA` — Last Bacterial Common Ancestor

Use them with `highlight = "LUCA"` or [resolve_special_identifier](reference/taxonomy-parsing.md).

## External taxonomy file

When labels are incomplete or missing taxonomy, supply a two-column file (column 1 = tip labels, column 2 = GTDB-format taxonomy string) via `taxonomy_file`. See [read_taxonomy_file](reference/taxonomy-parsing.md) and [summarize_taxonomy_quality_with_file](reference/taxonomy-parsing.md).

## Next

- [Tutorials](tutorials.md) for end-to-end workflows.
- [Reference index](reference/index.md) for every function.
