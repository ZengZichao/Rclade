# Display Rclade ASCII art logo

Prints a stylized ASCII art logo for Rclade to the console.

## Usage

``` r
rclade_logo(show_version = TRUE, show_tagline = TRUE)
```

## Arguments

- show_version:

  Logical. Whether to show version number. Default: TRUE

- show_tagline:

  Logical. Whether to show tagline. Default: TRUE

## Value

Invisible NULL

## Examples

``` r
rclade_logo()
#> 
#>   ######   ######   #####   #       #####   ######  ######
#>   #    #   #    #  #     #  #       #    #  #       #     
#>   ######   ######  #        #       #    #  ####    ####  
#>   #   #    #   #   #        #       #    #  #       #     
#>   #    #   #    #   #####   ######  #####   ######  ######
#> 
#>   Version 1.0.0 | MIT License
#> 
#>   Third-party dependencies and licenses:
#>   --------------------------------------------------------------
#>   ape         >= 5.0    GPL-2+        Paradis & Schliep 2019
#>   ggtree      >= 4.0    Artistic-2.0  Yu et al. 2017
#>   deeptime    >= 1.0    GPL (>= 3)    Gearty 2025
#>   ggplot2     >= 3.5    MIT           Wickham 2016
#>   rlang       >= 1.0    MIT           Wickham et al. 2024
#>   stringr     >= 1.5    MIT           Wickham 2019
#>   tidytree    >= 0.4    Artistic-2.0  Yu 2022
#>   --------------------------------------------------------------
#>   Optional: treeio (Artistic-2.0), phangorn (GPL-2+),
#>             RColorBrewer (Apache-2.0), viridisLite (MIT)
#>   Automated Deep-Time Phylogenetic Tree Visualization
#> 
```
