# Load internal geological timescale data

Tries deeptime::get_scale_data() first, falls back to internal sysdata.
Ensures Hadean eon is included.

## Usage

``` r
prepare_geo_timescales(version = "ICS 2023/02")
```

## Arguments

- version:

  Geological timescale version string. Currently supported:
  `"ICS 2023/02"`. Default: `"ICS 2023/02"`.

## Value

List with eons, eras, periods data frames
