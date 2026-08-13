# Contributing to Rclade

> **Note:** GitHub repository at https://github.com/zengzichao/Rclade. Issues and pull requests welcome.

Thank you for your interest in contributing to Rclade!

## Reporting Issues

Please submit issues at https://github.com/zengzichao/Rclade/issues.

When reporting a bug, please include:
- A minimal reproducible example
- Your R session info (`sessionInfo()`)
- The expected vs. actual behavior

## Development Setup

```r
# Clone the repository
git clone https://github.com/zengzichao/Rclade.git

# Install development dependencies
install.packages(c("devtools", "testthat", "roxygen2", "knitr", "rmarkdown"))

# Bioconductor dependencies
tryCatch({
  library(BiocManager)
}, error = function(e) {
  install.packages("BiocManager")
})
BiocManager::install(c("ggtree", "treeio", "tidytree"))

# Load the package in development mode
devtools::load_all(".")

# Run tests
devtools::test()

# Check the package
devtools::check()

# Build documentation
devtools::document()
```

## Code Style

- Follow [Google's R Style Guide](https://google.github.io/styleguide/Rguide.html)
- Use `snake_case` for function names and variables
- Document all exported functions with roxygen2
- Add `@keywords internal` to non-exported functions
- Run `devtools::document()` after modifying roxygen comments to keep `man/` in sync

## Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Add tests for new functionality
5. Run `devtools::check()` to ensure no regressions
6. Submit a pull request

## Testing

```r
# Run all tests
devtools::test()

# Run specific test file
testthat::test_file("tests/testthat/test-taxonomy.R")

# Check test coverage
covr::package_coverage()
```

## Documentation

- Update both `README.EN.md` and `README.CN.md` if user-facing behavior changes.
- Update `NEWS.EN.md` and `NEWS.CN.md` for notable changes.
- Regenerate `man/` pages with `devtools::document()` when roxygen comments change.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
