# Escape a string for safe use inside a regular expression

Wraps every regex-metacharacter in a backslash so the resulting string
can be embedded literally in a pattern. Used by the semicolon-delimited
parser (and any other code that turns a user separator into a regex) so
that a separator such as `"."` or `"+"` is matched as a literal
character rather than as a metacharacter.

## Usage

``` r
escape_regex(x)
```

## Arguments

- x:

  Character scalar to escape.

## Value

Escaped character scalar.
