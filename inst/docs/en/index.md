# Rclade Documentation (English)

Welcome to the Rclade documentation. Rclade is an R package for **automated deep-time phylogenetic tree collapsing and visualization** with geological timescales.

This documentation is organized as a multi-level system:

1. **Getting started** — a guided first run.
2. **Installation** — how to install Rclade and its dependencies.
3. **Core concepts** — taxonomy formats, MRCA collapsing, timescales, colors, and special identifiers.
4. **Tutorials** — step-by-step workflows.
5. **Reference** — the package's functions grouped by module, each with a usage example; internal (non-exported) helpers are flagged and must be called as `Rclade:::fn()`.
6. **Cookbook** — copy-paste worked examples for common tasks.
7. **FAQ** — frequently asked questions and troubleshooting.

## Where to go

| Page | Link |
|------|------|
| Getting started | [getting-started.md](getting-started.md) |
| Installation | [installation.md](installation.md) |
| Core concepts | [core-concepts.md](core-concepts.md) |
| Tutorials | [tutorials.md](tutorials.md) |
| Reference index | [reference/index.md](reference/index.md) |
| Cookbook | [cookbook.md](cookbook.md) |
| FAQ | [faq.md](faq.md) |

Chinese docs: [../cn/index.md](../cn/index.md) · Project README: [../../../README.EN.md](../../../README.EN.md)

## Module reference

- [Core Visualization](reference/core-visualization.md) — `plot_timetree`, `batch_plot`, `save_timetree`, `summarize_timetree`, `theme_timetree`
- [Tree & Sequence Reading and Validation](reference/tree-sequence.md) — read/validate trees and sequences, check monophyly
- [Taxonomy Parsing](reference/taxonomy-parsing.md) — detect/parse labels, resolve groups to MRCAs, validate custom groups
- [Colors & Legend](reference/colors-legend.md) — `Rclade:::generate_colors`, `Rclade:::split_legend` (internal)
- [Command-line & Interactive Interfaces](reference/cli-interactive.md) — CLI, Shiny, self-test, interruption handling
- [Logging & Timing](reference/logging-timing.md) — structured logging and timers
- [Utilities](reference/utilities.md) — paths, encoding, temp files, misc helpers
