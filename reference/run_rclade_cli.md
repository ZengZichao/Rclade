# Run Rclade from the command line

Provides a command-line interface for Rclade. Requires the optparse
package.

## Usage

``` r
run_rclade_cli(args = commandArgs(trailingOnly = TRUE))
```

## Arguments

- args:

  Character vector of command-line arguments (default:
  commandArgs(trailingOnly = TRUE))

## Value

An invisible integer exit code following standard Unix conventions: `0L`
(success), `1L` (runtime error), `2L` (parameter error), `3L`
(input-data error), `130L` (user interrupt / SIGINT). **The caller MUST
pass this value to `q(status = ...)` or `quit(status = ...)` for the
exit code to propagate to the operating system**; simply calling
`run_rclade_cli()` without forwarding the return value will always exit
with code 0 regardless of errors.

## Config-file override trap (L-E3 — READ BEFORE USING `--config`)

A `--config` YAML file supplies **defaults** for any option, with
precedence `CLI explicit argument > config file > built-in default`.
Because `optparse` does not expose "was this flag passed?", the override
is applied by comparing each option against its **built-in default**:
**any option the user left at its default value is eligible to be
overridden by the config file** — *even if the user explicitly typed a
value identical to the default*. Concretely:

- `plot_timetree --rank phylum` (where `"phylum"` is the default) **will
  be overridden** by `rank: class` in the config.

- `plot_timetree --rank species` (non-default) is preserved.

This is an `optparse` limitation, not a bug, and is **intentional but
surprising**. To make an option immune to config, pass a non-default
value, or avoid relying on config for options you care about. Unknown
config keys are warned and ignored.
