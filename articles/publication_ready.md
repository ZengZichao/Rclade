# Publication-Ready Output

## Color-Blind Friendly Palettes

Rclade defaults to the `viridis` palette, which is: - Color-blind
friendly - Grayscale friendly - Perceptually uniform

``` r

library(Rclade)
data(example_tree)

# Default viridis palette
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE)
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T10:57:20.233+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:57:20.233+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:57:20.234+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:57:20.234+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:57:20.234+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:57:20.235+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:57:20.237+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:57:20.237+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:57:20.237+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:57:20.238+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:57:20.239+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:57:20.239+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:57:20.240+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:57:20.248+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:57:20.248+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:57:20.249+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T10:57:20.249+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:57:20.250+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:57:20.253+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:57:20.254+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:57:20.254+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T10:57:21.106+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:57:21.114+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:57:21.115+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:57:21.313+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:57:21.341+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:57:21.342+00:00 | INFO     | Timer 'tree_rendering': 227 ms
#> 2026-08-21T10:57:21.342+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:57:21.433+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:57:21.433+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:57:21.433+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:57:21.434+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:57:21.434+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:57:21.435+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:57:21.435+00:00 | INFO     | plot_timetree completed successfully
print(p)
```

![](publication_ready_files/figure-html/palette-1.png)

## Custom Color Mapping

``` r

# Custom color mapping for specific groups
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   color_mapping = c("Proteobacteria" = "#E41A1C",
                                     "Firmicutes" = "#377EB8"))
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T10:57:22.017+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:57:22.017+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:57:22.017+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:57:22.018+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:57:22.018+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:57:22.018+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:57:22.019+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:57:22.020+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:57:22.020+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:57:22.021+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:57:22.021+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:57:22.022+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:57:22.022+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:57:22.029+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:57:22.030+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:57:22.030+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T10:57:22.030+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:57:22.037+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:57:22.040+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:57:22.040+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:57:22.040+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:57:22.041+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:57:22.042+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:57:22.043+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:57:22.151+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:57:22.177+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:57:22.177+00:00 | INFO     | Timer 'tree_rendering': 134 ms
#> 2026-08-21T10:57:22.178+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:57:22.306+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:57:22.306+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:57:22.306+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:57:22.307+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:57:22.307+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:57:22.307+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:57:22.308+00:00 | INFO     | plot_timetree completed successfully
print(p)
```

![](publication_ready_files/figure-html/custom_colors-1.png)

## Legend Placement

``` r

# Inside the plot (default)
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = c(0.05, 0.85))
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T10:57:22.877+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:57:22.878+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:57:22.878+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:57:22.879+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:57:22.879+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:57:22.879+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:57:22.880+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:57:22.881+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:57:22.881+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:57:22.882+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:57:22.882+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:57:22.883+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:57:22.883+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:57:22.890+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:57:22.891+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:57:22.891+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T10:57:22.892+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:57:22.892+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:57:22.894+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:57:22.895+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:57:22.895+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:57:22.896+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:57:22.897+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:57:22.898+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:57:23.011+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:57:23.038+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:57:23.039+00:00 | INFO     | Timer 'tree_rendering': 141 ms
#> 2026-08-21T10:57:23.039+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:57:23.118+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:57:23.118+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:57:23.119+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:57:23.119+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:57:23.119+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:57:23.120+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:57:23.120+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T10:57:23.121+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:57:23.122+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:57:23.122+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:57:23.122+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:57:23.123+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:57:23.123+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:57:23.124+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:57:23.124+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:57:23.125+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:57:23.126+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:57:23.126+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:57:23.126+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:57:23.127+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:57:23.140+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:57:23.141+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:57:23.141+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-21T10:57:23.141+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:57:23.142+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:57:23.144+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:57:23.144+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:57:23.145+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:57:23.145+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:57:23.147+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:57:23.147+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:57:23.254+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:57:23.280+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:57:23.281+00:00 | INFO     | Timer 'tree_rendering': 134 ms
#> 2026-08-21T10:57:23.281+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:57:23.363+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:57:23.363+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:57:23.363+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:57:23.364+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:57:23.364+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:57:23.364+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:57:23.365+00:00 | INFO     | plot_timetree completed successfully
```

## Clade Labels

``` r

p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   show_clade_label = TRUE)
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T10:57:23.496+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:57:23.496+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:57:23.496+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:57:23.497+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:57:23.497+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:57:23.497+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:57:23.498+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:57:23.499+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:57:23.499+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:57:23.500+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:57:23.500+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:57:23.501+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:57:23.501+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:57:23.509+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:57:23.509+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:57:23.509+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T10:57:23.510+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:57:23.510+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:57:23.513+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:57:23.513+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:57:23.513+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:57:23.514+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:57:23.515+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:57:23.516+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:57:23.639+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:57:23.665+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:57:23.666+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-08-21T10:57:23.666+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:57:23.761+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:57:23.762+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:57:23.762+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:57:23.762+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:57:23.763+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:57:23.763+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:57:23.763+00:00 | INFO     | plot_timetree completed successfully
print(p)
```

![](publication_ready_files/figure-html/clade_labels-1.png)

## Taxonomy Quality Report

Before finalizing your figure, verify label parsing quality:

``` r

summarize_taxonomy_quality(example_tree$tip.label, format = "GTDB")
#> === Taxonomy Label Parsing Quality Report ===
#> Total labels: 50
#> Detected format: GTDB
#> 
#> Per-rank parse rates:
#>   kingdom        0.0% (0/50) 
#>   domain       100.0% (50/50) ====================
#>   phylum       100.0% (50/50) ====================
#>   class        100.0% (50/50) ====================
#>   order          0.0% (0/50) 
#>   family         0.0% (0/50) 
#>   genus          0.0% (0/50) 
#>   species        0.0% (0/50) 
#>   subspecies     0.0% (0/50) 
#> 
#> All labels parsed successfully.
```

## Batch Processing

Process multiple tree files at once:

``` r

batch_plot(input_dir = "trees/",
           output_dir = "figures/",
           pattern = "*.tre",
           rank = "phylum",
           taxonomy_format = "GTDB")
```

## Reproducibility

``` r

save_session_info("session_info.txt")
```

## References & Acknowledgments

Rclade builds on the **ggtree** and **deeptime** R packages. If you use
Rclade in published research, please cite Rclade along with these key
dependencies:

- Yu G, Smith DK, Zhu H, Guan Y, Lam TT-Y (2017). “ggtree: an R package
  for visualization and annotation of phylogenetic trees with their
  covariates and other associated data.” *Methods in Ecology and
  Evolution*, 8(1), 28-36. <doi:10.1111/2041-210X.12628>
- Gearty W (2025). “deeptime: an R package that facilitates highly
  customizable and reproducible visualizations of data over geological
  time intervals.” *Big Earth Data*. <doi:10.1080/20964471.2025.2537516>

The geological timescale data is based on the ICS International
Chronostratigraphic Chart 2023/02 (<https://stratigraphy.org/chart>).
