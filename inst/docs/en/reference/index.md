# Reference Manual

All functions and commands organized by module. Each function includes a description and a simple usage example.

> **Note:** Functions marked as "internal" are not exported in the NAMESPACE; access them with the `Rclade:::function_name()` triple-colon syntax.


| Module | Description |
|------|------|
| [Core Visualization](core-visualization.md) | Main functions for plotting, saving and summarizing phylogenetic timetrees. |
| [Tree & Sequence I/O and Validation](tree-sequence.md) | Read tree files, validate sequence files, and check monophyly. |
| [Taxonomy Parsing](taxonomy-parsing.md) | Detect formats, parse taxonomic labels, resolve groups to MRCAs, and validate custom groups. |
| [Colors & Legend](colors-legend.md) | Generate color-blind-safe palettes and split legends for publication-ready plots. |
| [Command-line & Interactive Interfaces](cli-interactive.md) | Run Rclade from the command line, launch the Shiny app, run the self-test, and batch with interruption handling. |
| [Logging & Timing](logging-timing.md) | Structured, leveled logging and timers for pipeline observability. |
| [Utilities](utilities.md) | Cross-platform path building, encoding detection, temporary file management, and miscellaneous helpers. |

[中文版](../../cn/reference/index.md) | [Documentation Home](../../index.md)
