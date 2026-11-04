## CRAN submission comments for Rclade 1.1.6

### Update to 1.1.5 (2026-11-03)

This is a regular update to the current CRAN version 1.1.5. It fixes label
placement and HPD rendering, and adds one optional argument. No existing
function signature was changed incompatibly, and behaviour is unchanged
unless the new argument is used.

- **Clade and tip labels are no longer clipped.** The x range now reserves
  space based on the measured text width (new internal `right_pad` argument
  on `add_geo_timescale()`, and a matching x-scale expansion in the plotting
  pipeline). Previously a clade label drawn at the right edge of the panel
  was cut off.

- **Circular layout: tip labels are drawn radially.** `ggtree::geom_tiplab()`
  in ggtree 4.x ignores the `angle` aesthetic under polar coordinates and
  applies its own rotation, which left the left half of the circle upside
  down. Labels are now drawn with `ggplot2::geom_text()` using per-tip
  angles, flipped and right-aligned on the left half.

- **HPD bars are drawn only for internal nodes.** Node tables shipped with
  the examples also list tips, so extant species received an age interval
  they do not have. Only nodes above `ape::Ntip(tree)` are now drawn.

- **HPD bars now render in circular layouts.** `ggtree::geom_range()`
  produced no visible layer under polar coordinates, so bars are drawn as
  radial segments there.

- **New argument `groups_label_only` (default `FALSE`)** in `plot_timetree()`:
  labels the clades defined by `groups` without collapsing them, keeping
  every terminal branch expanded.

- **`annotate_clade()` gains `hjust`** so callers can right-align labels that
  are too wide to fit to the right of the tips.

### R CMD check results (local)

`R CMD check --as-cran --no-manual` was run on macOS aarch64 (arm64) with
R 4.5.3.

0 ERRORs, 0 WARNINGs, 1 NOTE:

- "unable to verify current time" — this machine has no outbound access to a
  time service; the same NOTE appears for any package checked here and does
  not occur on CRAN's check machines.

### Downstream dependencies

There are no reverse dependencies on CRAN.
