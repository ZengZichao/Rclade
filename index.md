# Rclade

**Automated Deep-Time Phylogenetic Tree Collapsing and Visualization**

Version: 1.1.0

Rclade provides a single-function pipeline for automated collapsing and
visualization of large phylogenetic trees with geological timescales.

- [English
  README](https://github.com/zengzichao/Rclade/blob/main/README.EN.md)
- [中文
  README](https://github.com/zengzichao/Rclade/blob/main/README.CN.md)
- Online documentation (pkgdown): <https://zengzichao.github.io/Rclade/>

The GitHub repository is at <https://github.com/zengzichao/Rclade>.
Report issues at <https://github.com/zengzichao/Rclade/issues>.

## Installation from source

From the fixed GitHub release tag (requires the `remotes` package):

``` r

remotes::install_github("zengzichao/Rclade@v1.1.0")
```

Or from a downloaded release tarball (GitHub Releases / Zenodo archive):

``` r

install.packages("Rclade_1.1.0.tar.gz", repos = NULL, type = "source")
```

## Quick start

``` r

library(Rclade)
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE)
print(p)
```

## License

MIT + file LICENSE
