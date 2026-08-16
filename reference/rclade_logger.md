# Rclade Logger

A real-time logging system with flush support, timestamps, and log
levels. Messages are printed immediately (not buffered) with formatted
output.

## Details

**Thread safety**: The logger uses a package-global environment and is
*not* thread-safe. In concurrent contexts (e.g., multiple Shiny sessions
or parallel Snakemake/Nextflow rule executions), multiple Rclade
instances writing to the same log file will produce interleaved or
corrupted log output.

**Best practices for parallel execution**:

- **Each process MUST use an independent log file** (mandatory). Never
  point two concurrent Rclade processes at the same `--log_file`.
  Sharing one log file is only safe when the `filelock` package is
  installed (it provides an advisory lock on each write); otherwise
  concurrent writes will interleave/corrupt output.

- Assign each Rclade instance a unique log file via `--log_file` (e.g.,
  `--log_file logs/task_\$SLURM_JOB_ID.log`)

- In Snakemake/Nextflow pipelines, use wildcards to generate per-rule or
  per-sample log paths

- For Shiny deployments, disable file logging with
  `enable_file_logging(FALSE)` before launching the app

- The console output (via
  [`message()`](https://rdrr.io/r/base/message.html)) is process-local
  and does not suffer from interleaving issues

**Limitation**: The current design does not support a shared log file
across concurrent Rclade processes. This is a known limitation tracked
for a future release. For now, use per-instance log files as described
above.

## Log Levels

- **DEBUG**: Detailed debug information

- **INFO**: Normal operation information

- **WARNING**: Warning messages

- **ERROR**: Error messages

- **CRITICAL**: Critical errors
