# Core Concepts

This page explains the ideas behind Rclade so the function arguments make sense.

## Taxonomy formats

Rclade reads the taxonomic assignment of each tip from its **label**. Several formats are supported:

| Format | Example label | Detected by |
|--------|---------------|-------------|
| GTDB | `d__Bacteria;p__Firmicutes;c__Bacilli` | prefix `d__`/`p__`/... |
| Silva | `Bacteria;Firmicutes;Bacilli` | semicolon ranks, no codes |
| NCBI | `cellular organisms; Bacteria; Firmicutes` | named ranks |
| embedded (custom_rank) | `k__Bacteria;p__Firmicutes` | explicit codes |
| custom_regex | `Domain:Bacteria\|Phylum:Firmicutes` | user regex |

Detection is automatic (`taxonomy_format = "auto"`). To force a format, set `taxonomy_format` explicitly. See [detect_taxonomy_format](reference/taxonomy-parsing.md) and [parse_taxonomy](reference/taxonomy-parsing.md).

## MRCA-based collapsing

"Collapsing" means replacing a whole clade with a single triangle whose width encodes the clade's age range. Rclade finds the **MRCA** (Most Recent Common Ancestor) of all tips that share a taxonomic group, then draws a triangle for that clade.

You can collapse in three ways:

- **By rank** — `rank = "phylum"` collapses every phylum at once.
- **By named group** — `group = list(GroupA = c("tip1","tip2"))` collapses a custom set (must be monophyletic; check with [validate_custom_groups](reference/taxonomy-parsing.md)).
- **By specific clade** — `clade = "Cyanobacteriota"` collapses only that named clade.

### Monophyly matters

A group can only be collapsed cleanly if it is **monophyletic** (all descendants share one MRCA). Non-monophyletic groups trigger a warning and are skipped by default (`strict = FALSE`); set `strict = TRUE` to abort instead. Check with [check_monophyly](reference/tree-sequence.md).

### Triangle and space modes

- `triangle_mode`: how the triangle's width is drawn — `max`, `min`, `mixed` (adaptive), or `none`.
- `space_mode`: `proportional` gives more vertical room to larger clades; `equal` gives each clade the same room.

## Geological timescale

Rclade adds a geological timescale to the x-axis using `deeptime` (ICS 2023/02).

- `unit`: the unit of your tree's edge lengths — `Ma` (mega-annum) or `Ga` (giga-annum). If `NULL`, Rclade auto-detects from the magnitude.
- `timescale_levels`: which bands to show — `eras`, `eons`, `periods`.
- `add_timescale = FALSE` disables it (useful for circular layouts or cladograms).

## Colors and legend

- `color_palette`: `viridis` (default, color-blind safe), any RColorBrewer name, `rainbow`, or a color vector.
- `color_mapping`: a named vector for exact control, e.g. `c("Proteobacteria" = "#E41A1C")`.
- `color_rank`: color by a rank different from the one you collapse on.
- Legend position and rows/columns are auto-computed; override with `legend_position`, `legend_nrow`, `legend_ncol`. For very large legends, see [split_legend](reference/colors-legend.md).

## Special identifiers

Rclade understands ancestral nodes of life:

- `LUCA` — Last Universal Common Ancestor (MRCA of Bacteria + Archaea)
- `LACA` — Last Archaeal Common Ancestor
- `LBCA` — Last Bacterial Common Ancestor

Use them with `highlight = "LUCA"` or [resolve_special_identifier](reference/taxonomy-parsing.md).

## External taxonomy file

When labels are incomplete or missing taxonomy, supply a two-column file (`tip_label`, `taxonomy_string`) via `taxonomy_file`. See [read_taxonomy_file](reference/taxonomy-parsing.md) and [summarize_taxonomy_quality_with_file](reference/taxonomy-parsing.md).

## Next

- [Tutorials](tutorials.md) for end-to-end workflows.
- [Reference index](reference/index.md) for every function.
