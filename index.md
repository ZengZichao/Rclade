# Rclade

**Automated Deep-Time Phylogenetic Tree Collapsing and Visualization**

Version: 1.1.2

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

remotes::install_github("zengzichao/Rclade@v1.1.2")
```

Or from a downloaded release tarball (GitHub Releases / Zenodo archive):

``` r

install.packages("Rclade_1.1.2.tar.gz", repos = NULL, type = "source")
```

## Quick start

``` r

library(Rclade)
data(example_tree)
p <- plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE)
print(p)
```

## Reference

Zeng Z (2026). Rclade: automated taxonomic collapsing and
geological-timescale annotation of time-calibrated phylogenetic trees in
R. bioRxiv. <doi:10.64898/2026.08.27.747462>

## License

MIT + file LICENSE
