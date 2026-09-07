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
#> 2026-09-07T09:18:57.789+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:18:57.790+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:18:57.790+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:18:57.791+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:18:57.791+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:18:57.792+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:18:57.794+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:18:57.795+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:18:57.795+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:18:57.796+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:18:57.805+00:00 | INFO     | Timer 'input_reading': 12 ms
#> 2026-09-07T09:18:57.805+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:18:57.806+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:18:57.814+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:18:57.815+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:18:57.815+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-07T09:18:57.816+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:18:57.816+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:18:57.820+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:18:57.820+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:18:57.821+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-07T09:18:58.654+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:18:58.662+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:18:58.663+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:18:58.890+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:18:58.921+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:18:58.922+00:00 | INFO     | Timer 'tree_rendering': 258 ms
#> 2026-09-07T09:18:58.922+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:18:59.027+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:18:59.028+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:18:59.028+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:18:59.029+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:18:59.029+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:18:59.030+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:18:59.030+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:18:59.030+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:18:59.031+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:18:59.031+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T09:18:59.642+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:18:59.643+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:18:59.643+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:18:59.643+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:18:59.644+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:18:59.644+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:18:59.645+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:18:59.646+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:18:59.646+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:18:59.647+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:18:59.648+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T09:18:59.648+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:18:59.648+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:18:59.656+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:18:59.657+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:18:59.657+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T09:18:59.657+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:18:59.658+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:18:59.660+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:18:59.661+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:18:59.661+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-07T09:18:59.662+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:18:59.663+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:18:59.664+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:18:59.787+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:18:59.818+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:18:59.819+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-09-07T09:18:59.819+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:18:59.904+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:18:59.905+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:18:59.905+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:18:59.905+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:18:59.906+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:18:59.906+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:18:59.907+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:18:59.907+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:18:59.907+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:18:59.908+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T09:19:00.583+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:19:00.583+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:19:00.583+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:19:00.584+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:19:00.584+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:19:00.585+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:19:00.586+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:19:00.586+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:19:00.586+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:19:00.587+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:19:00.588+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T09:19:00.588+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:19:00.589+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:19:00.597+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:19:00.597+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:19:00.597+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T09:19:00.598+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:19:00.598+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:19:00.606+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:19:00.606+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:19:00.607+00:00 | INFO     | Timer 'mrca_computation': 9 ms
#> 2026-09-07T09:19:00.608+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:19:00.609+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:19:00.610+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:19:00.727+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:19:00.757+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:19:00.758+00:00 | INFO     | Timer 'tree_rendering': 148 ms
#> 2026-09-07T09:19:00.758+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:19:00.849+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:19:00.850+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:19:00.850+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:19:00.851+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:19:00.851+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:19:00.851+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:19:00.852+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:19:00.852+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:19:00.853+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:19:00.853+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-07T09:19:00.855+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:19:00.855+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:19:00.855+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:19:00.856+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:19:00.856+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:19:00.857+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:19:00.858+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:19:00.858+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:19:00.859+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:19:00.859+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:19:00.860+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T09:19:00.860+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:19:00.861+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:19:00.869+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:19:00.869+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:19:00.870+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T09:19:00.870+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:19:00.871+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:19:00.873+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:19:00.874+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:19:00.874+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-07T09:19:00.875+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:19:00.876+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:19:00.877+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:19:01.002+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:19:01.034+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:19:01.034+00:00 | INFO     | Timer 'tree_rendering': 157 ms
#> 2026-09-07T09:19:01.035+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:19:01.123+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:19:01.123+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:19:01.123+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:19:01.124+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:19:01.124+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:19:01.125+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:19:01.125+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:19:01.125+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:19:01.126+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:19:01.126+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T09:19:01.278+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:19:01.279+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:19:01.279+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:19:01.279+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:19:01.280+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:19:01.280+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:19:01.281+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:19:01.282+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:19:01.282+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:19:01.283+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:19:01.284+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T09:19:01.284+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:19:01.284+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:19:01.292+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:19:01.293+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:19:01.293+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T09:19:01.294+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:19:01.294+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:19:01.297+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:19:01.297+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:19:01.298+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-07T09:19:01.298+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:19:01.305+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:19:01.306+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:19:01.425+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:19:01.454+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:19:01.455+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-09-07T09:19:01.455+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:19:01.553+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:19:01.553+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:19:01.554+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:19:01.554+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:19:01.554+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:19:01.555+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:19:01.555+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:19:01.556+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:19:01.556+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:19:01.556+00:00 | INFO     | plot_timetree completed successfully
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
Chronostratigraphic Chart 2023/02 (<https://stratigraphy.org/chart/>).
