# Get the current git short hash of the installed package source

Consolidates the previously duplicated git-hash detection found in
`cli.R::get_version_string()` and `logo.R::rclade_logo()`. Returns
`"unknown"` when not running from a git working tree or when git is
unavailable / errors.

## Usage

``` r
get_git_hash()
```

## Value

Character: short git hash (7 chars) or `"unknown"`.
