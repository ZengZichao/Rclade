# Rclade Functional Test Coverage

The functional test suite (`tests/functional/run-functional-full.R`, 691 lines)
tests Rclade through its public API (`plot_timetree()`, CLI, library-mode functions)
across 17 test categories.

## Test Scenarios (17 categories)

| # | Category | Key Scenarios |
|---|----------|---------------|
| 1 | Main pipeline (plot_timetree) | Basic usage, all rank levels, all layout modes (rectangular/circular/slanted/fan), timescale integration, custom groups, batch mode with `ignore_malformed` |
| 2 | Taxonomy parsing | GTDB/Silva/NCBI/custom format detection; `parse_taxonomy()` with auto/manual format; custom rank levels; custom regex patterns |
| 3 | MRCA computation & collapsing | `compute_mrca_map()` with various ranks/clades; nesting conflict detection; batch collapsing with depth-first ordering |
| 4 | Monophyly checking | `strict = TRUE` (error on non-monophyletic); `strict = FALSE` (warning + skip); case-insensitive matching; non-phylo object rejection |
| 5 | Special identifiers | LUCA/LACA/LBCA node identification and highlighting; custom annotation of ancestral nodes |
| 6 | Input validation | Empty files, corrupt Newick, negative branch lengths, duplicate tip labels, self-loops, missing files |
| 7 | Logging system | All log levels (DEBUG/INFO/WARNING/ERROR/CRITICAL); file logging to disk; step tracking; timestamp formatting |
| 8 | Interrupt handling | SIGINT propagation; graceful cleanup; temporary file removal on interrupt |
| 9 | Encoding & cross-platform | UTF-8/BOM/Latin-1 file reading; CRLF/LF line ending normalization; mixed-encoding detection |
| 10 | External taxonomy files | TSV file parsing; cyclic dependency detection; source priority control; merging with tree labels |
| 11 | Self-test mode | `run_rclade_selftest()` comprehensive diagnostics; environment validation |
| 12 | Output saving | PDF/PNG/TIFF/SVG/EPS export; resolution/size control; file overwrite protection (`no_clobber`) |
| 13 | Batch processing | `batch_plot()` directory processing; file pattern matching; error accumulation in batch mode |
| 14 | Visualization components | Legend layout (inside/right/bottom/smart); color palette selection (viridis/RColorBrewer); title/subtitle/caption; theme customization |
| 15 | Adversarial inputs | Control characters in tree files; BiDi (bidirectional) Unicode markers; extreme tip label lengths |
| 16 | Performance & boundaries | 100-tip tree timing assertion (Rclade < 60s); multi-tree scaling; large synthetic tree memory check |
| 17 | CLI extended tests | Exit code correctness (0 success, 1 error, 2 invalid args); `--help`/`--version` output; CLI parameter validation |

## Test Environment Requirements

- R 4.5.3 with Rclade package installed
- Test input data in `tests/functional/input/` (2 tree files + taxonomy TSV + FASTA)
- macOS-specific behaviors: `qpdf` WARNING is expected locally (not on CRAN Linux)

## Running

```bash
cd Rclade-项目代码
Rscript tests/functional/run-functional-full.R
```

Functional tests are excluded from the CRAN package build via `.Rbuildignore` (line 30) because they require pre-installed test data and may run long. They are executed separately in CI via `.github/workflows/functional-tests.yaml`.
