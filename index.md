# Rclade

**Automated Deep-Time Phylogenetic Tree Collapsing and Visualization**

Version: 1.0.0

Rclade provides a single-function pipeline for automated collapsing and
visualization of large phylogenetic trees with geological timescales.

- [English
  README](https://github.com/zengzichao/Rclade/blob/main/README.EN.md)
- [中文
  README](https://github.com/zengzichao/Rclade/blob/main/README.CN.md)
- Online documentation (pkgdown): <https://zengzichao.github.io/Rclade>

The GitHub repository is at <https://github.com/zengzichao/Rclade>.
Report issues at <https://github.com/zengzichao/Rclade/issues>.

## Installation from source

``` r

install.packages("path/to/Rclade_1.0.0.tar.gz", repos = NULL, type = "source")
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
