# Launch Rclade Shiny app

Provides an interactive web interface for Rclade. Requires the shiny
package.

## Usage

``` r
run_rclade_shiny()
```

## Concurrency

The logger, step-progress, and interrupt subsystems use package-level
global environments (`.logger_env`, `.interrupt_env`). Within a single R
process, multiple concurrent Shiny sessions will share (and may corrupt)
this state — log messages, step counters, and interrupt flags can cross
between sessions. For production multi-user deployment, run one Shiny
instance per R process (e.g., behind a load balancer), or assign a
dedicated log file per task via `--log_file`. A session-scoped state
refactor is on the roadmap.
