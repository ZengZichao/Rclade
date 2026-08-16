# Add geological event bands (e.g., GOE, NOE) to a tree plot

Events are drawn as semi-transparent vertical bands covering the full
vertical extent of the tree (but not the geological timescale panels).

## Usage

``` r
add_geo_events(p, tree, events = NULL)
```

## Arguments

- p:

  ggplot object

- tree:

  phylo object (edge lengths in Ma)

- events:

  Event specification. Can be:

  - `NULL` (default): shows built-in events (GOE = 2400–2000 Ma, NOE =
    800–550 Ma).

  - A `data.frame` with columns `name`, `age_min` (Ma), `age_max` (Ma),
    and optionally `color`.

  - A `list` of named lists, each with elements `name`, `age_min`,
    `age_max`, and optionally `color`.

  - A named `list` with a single event (shorthand).

  If only `age` is provided (instead of `age_min`/`age_max`), a default
  bandwidth of `+/- 200 Ma` is used.

## Value

ggplot object
