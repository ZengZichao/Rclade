# Resolve the target/expected taxonomy domains for a special ancestral identifier.

Single source of truth for which taxonomy domains a special identifier
maps to. Shared by
[`resolve_special_identifier()`](https://zengzichao.github.io/Rclade/reference/resolve_special_identifier.md)
(to find the tips belonging to the identifier) and
[`check_special_monophyly()`](https://zengzichao.github.io/Rclade/reference/check_special_monophyly.md)
(to decide which domains are "inside" the clade), so the two call sites
cannot drift apart.

## Usage

``` r
resolve_target_domains(identifier, all_domains)
```

## Arguments

- identifier:

  Character, one of `"ROOT"`, `"LUCA"`, `"LACA"`, `"LBCA"`.

- all_domains:

  Character vector of domain names present in the relevant tip set (full
  tree for resolution, MRCA clade for monophyly checking).

## Value

Character vector of target domains.
