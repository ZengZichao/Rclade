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

## Install with Conda

The repository root contains an `environment.yml` that creates an environment with R and its dependencies in one step:

```bash
conda env create -f environment.yml
conda activate rclade
```

`environment.yml` does not include Rclade itself, so once the environment is activated you still need to install Rclade as described under "Install from CRAN" or "Install the development version" above.

> **Reproducibility note**: `environment.yml` specifies minimum version bounds for
> most entries; a few (`r-viridislite`, `r-rcolorbrewer`, `r-filelock`, `r-yaml`,
> `r-svglite`) are left unpinned.
> For fully reproducible environments, export an explicit spec after creation:
>
> ```bash
> conda list --explicit > conda-lockfile.txt
> # Restore with: conda create --name rclade --file conda-lockfile.txt
> ```
>
> Alternatively, use `renv` inside R for package-level locking.

## Dependencies

Rclade imports: `ape`, `ggtree`, `deeptime`, `ggplot2`, `rlang`, `stringr`, `tidytree`, `viridisLite`.

Suggested packages (needed for some features): `treeio`, `phangorn`, `RColorBrewer`, `cowplot`, `patchwork`, `shiny`, `optparse`, `yaml`, `testthat`, `knitr`, `rmarkdown`. Additionally, `vdiffr`, `covr`, `filelock`, `withr` are suggested for the test suite. `svglite` is not a declared dependency; it is listed (unpinned) in `environment.yml` for SVG output.

Install suggested packages if you plan to use the Shiny app, CLI, or run tests:

```r
install.packages(c("shiny", "optparse", "patchwork", "RColorBrewer",
                   "cowplot", "testthat", "rmarkdown", "knitr"))
```

## Docker

A `Dockerfile` is provided in the repository for a reproducible environment. The image's default entry point is the Rclade command line (`run_rclade_cli()`):

```bash
docker build -t rclade .
docker run --rm -it --init rclade --help
```

Pass `--init` to `docker run`: with `--init`, Docker injects tini as PID 1 to forward Ctrl+C (SIGINT) to the entry point, which is what produces the documented exit code 130.

To run R code inside the container you must override the default entry point with `--entrypoint`; otherwise `R` is treated as a command-line argument and the run fails:

```bash
docker run --rm -it --entrypoint R rclade -e 'library(Rclade); run_rclade_selftest()'
```

The self-test can also be invoked through a command-line option:

```bash
docker run --rm -it --init rclade --check
```

## Verify the installation

```r
library(Rclade)
run_rclade_selftest()
```

If all checks pass, you are ready to go. See [Getting started](getting-started.md).
