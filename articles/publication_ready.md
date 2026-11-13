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
#> 2026-11-13T10:43:44.603+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T10:43:44.604+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T10:43:44.604+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T10:43:44.604+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T10:43:44.604+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T10:43:44.605+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T10:43:44.606+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T10:43:44.607+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T10:43:44.607+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T10:43:44.607+00:00 | INFO     | Input validation passed
#> 2026-11-13T10:43:44.608+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-13T10:43:44.608+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T10:43:44.609+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T10:43:44.615+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T10:43:44.615+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T10:43:44.616+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-11-13T10:43:44.616+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T10:43:44.616+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T10:43:44.619+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T10:43:44.620+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T10:43:44.620+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-11-13T10:43:45.319+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T10:43:45.324+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T10:43:45.324+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T10:43:45.476+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T10:43:45.501+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T10:43:45.501+00:00 | INFO     | Timer 'tree_rendering': 176 ms
#> 2026-11-13T10:43:45.502+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T10:43:45.580+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T10:43:45.581+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T10:43:45.581+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T10:43:45.581+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T10:43:45.582+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T10:43:45.582+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T10:43:45.582+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T10:43:45.582+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T10:43:45.583+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T10:43:45.583+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-13T10:43:46.005+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T10:43:46.005+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T10:43:46.006+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T10:43:46.006+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T10:43:46.006+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T10:43:46.006+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T10:43:46.007+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T10:43:46.007+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T10:43:46.007+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T10:43:46.008+00:00 | INFO     | Input validation passed
#> 2026-11-13T10:43:46.009+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-13T10:43:46.009+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T10:43:46.009+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T10:43:46.014+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T10:43:46.015+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T10:43:46.015+00:00 | INFO     | Timer 'taxonomy_parsing': 6 ms
#> 2026-11-13T10:43:46.015+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T10:43:46.016+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T10:43:46.018+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T10:43:46.018+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T10:43:46.018+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-13T10:43:46.019+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T10:43:46.020+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T10:43:46.020+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T10:43:46.115+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T10:43:46.139+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T10:43:46.140+00:00 | INFO     | Timer 'tree_rendering': 119 ms
#> 2026-11-13T10:43:46.140+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T10:43:46.207+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T10:43:46.207+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T10:43:46.207+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T10:43:46.208+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T10:43:46.208+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T10:43:46.208+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T10:43:46.208+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T10:43:46.209+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T10:43:46.209+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T10:43:46.209+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-13T10:43:46.680+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T10:43:46.681+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T10:43:46.681+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T10:43:46.681+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T10:43:46.681+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T10:43:46.682+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T10:43:46.682+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T10:43:46.683+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T10:43:46.683+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T10:43:46.684+00:00 | INFO     | Input validation passed
#> 2026-11-13T10:43:46.684+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-13T10:43:46.684+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T10:43:46.685+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T10:43:46.690+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T10:43:46.691+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T10:43:46.691+00:00 | INFO     | Timer 'taxonomy_parsing': 6 ms
#> 2026-11-13T10:43:46.691+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T10:43:46.691+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T10:43:46.693+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T10:43:46.694+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T10:43:46.694+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-13T10:43:46.695+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T10:43:46.696+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T10:43:46.697+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T10:43:46.791+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T10:43:46.814+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T10:43:46.815+00:00 | INFO     | Timer 'tree_rendering': 118 ms
#> 2026-11-13T10:43:46.815+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T10:43:46.884+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T10:43:46.884+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T10:43:46.884+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T10:43:46.885+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T10:43:46.885+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T10:43:46.885+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T10:43:46.885+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T10:43:46.885+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T10:43:46.886+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T10:43:46.886+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-11-13T10:43:46.887+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T10:43:46.887+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T10:43:46.887+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T10:43:46.887+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T10:43:46.888+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T10:43:46.888+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T10:43:46.889+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T10:43:46.889+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T10:43:46.889+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T10:43:46.890+00:00 | INFO     | Input validation passed
#> 2026-11-13T10:43:46.890+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-13T10:43:46.890+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T10:43:46.891+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T10:43:46.896+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T10:43:46.896+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T10:43:46.896+00:00 | INFO     | Timer 'taxonomy_parsing': 6 ms
#> 2026-11-13T10:43:46.897+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T10:43:46.897+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T10:43:46.899+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T10:43:46.899+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T10:43:46.900+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-13T10:43:46.900+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T10:43:46.901+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T10:43:46.902+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T10:43:46.991+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T10:43:47.014+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T10:43:47.015+00:00 | INFO     | Timer 'tree_rendering': 113 ms
#> 2026-11-13T10:43:47.015+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T10:43:47.082+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T10:43:47.082+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T10:43:47.082+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T10:43:47.082+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T10:43:47.083+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T10:43:47.083+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T10:43:47.083+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T10:43:47.083+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T10:43:47.084+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T10:43:47.084+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-13T10:43:47.171+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T10:43:47.171+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T10:43:47.171+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T10:43:47.172+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T10:43:47.172+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T10:43:47.172+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T10:43:47.173+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T10:43:47.173+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T10:43:47.174+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T10:43:47.174+00:00 | INFO     | Input validation passed
#> 2026-11-13T10:43:47.175+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-13T10:43:47.175+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T10:43:47.175+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T10:43:47.181+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T10:43:47.181+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T10:43:47.182+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-11-13T10:43:47.182+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T10:43:47.182+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T10:43:47.184+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T10:43:47.185+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T10:43:47.185+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-13T10:43:47.185+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T10:43:47.187+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T10:43:47.187+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T10:43:47.282+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T10:43:47.306+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T10:43:47.306+00:00 | INFO     | Timer 'tree_rendering': 119 ms
#> 2026-11-13T10:43:47.310+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T10:43:47.381+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T10:43:47.381+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T10:43:47.382+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T10:43:47.382+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T10:43:47.382+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T10:43:47.382+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T10:43:47.382+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T10:43:47.383+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T10:43:47.383+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T10:43:47.383+00:00 | INFO     | plot_timetree completed successfully
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
