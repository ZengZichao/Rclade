# Installation

## System requirements

- **R** ≥ 4.1.0
- Operating systems: Linux, macOS, Windows
- Suggested: a working C/C++ toolchain for compiling dependencies (usually already present)

## Install from CRAN

```r
install.packages("Rclade")
```

## Install the development version

```r
# install.packages("remotes")
remotes::install_github("zengzichao/Rclade")
```

## Dependencies

Rclade imports: `ape`, `ggtree`, `deeptime`, `ggplot2`, `rlang`, `stringr`, `tidytree`, `viridisLite`.

Suggested packages (needed for some features): `treeio`, `phangorn`, `RColorBrewer`, `cowplot`, `patchwork`, `shiny`, `optparse`, `yaml`, `testthat`, `knitr`, `rmarkdown`.

Install suggested packages if you plan to use the Shiny app, CLI, or run tests:

```r
install.packages(c("shiny", "optparse", "patchwork", "RColorBrewer",
                   "cowplot", "testthat", "rmarkdown", "knitr"))
```

## Docker

A `Dockerfile` is provided in the repository for a reproducible environment:

```bash
docker build -t rclade .
docker run --rm -it rclade R -e 'library(Rclade); run_rclade_selftest()'
```

## Verify the installation

```r
library(Rclade)
run_rclade_selftest()
```

If all checks pass, you are ready to go. See [Getting started](getting-started.md).
