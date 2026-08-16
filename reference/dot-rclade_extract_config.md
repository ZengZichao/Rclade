# Extract –config path from raw args (pre-parse)

Scans the raw argument vector for `--config <path>` or `--config=<path>`
so the config can be loaded before optparse parsing fills in defaults.

## Usage

``` r
.rclade_extract_config(args)
```
