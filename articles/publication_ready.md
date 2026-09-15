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
#> 2026-09-15T15:45:42.853+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T15:45:42.854+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T15:45:42.855+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T15:45:42.855+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T15:45:42.855+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T15:45:42.856+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T15:45:42.858+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T15:45:42.858+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T15:45:42.859+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T15:45:42.860+00:00 | INFO     | Input validation passed
#> 2026-09-15T15:45:42.860+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T15:45:42.861+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T15:45:42.861+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T15:45:42.870+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T15:45:42.871+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T15:45:42.871+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-15T15:45:42.872+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T15:45:42.872+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T15:45:42.876+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T15:45:42.876+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T15:45:42.877+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-15T15:45:43.834+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T15:45:43.842+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T15:45:43.843+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T15:45:44.067+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T15:45:44.100+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T15:45:44.101+00:00 | INFO     | Timer 'tree_rendering': 257 ms
#> 2026-09-15T15:45:44.102+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T15:45:44.203+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T15:45:44.203+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T15:45:44.204+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T15:45:44.204+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T15:45:44.204+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T15:45:44.205+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T15:45:44.205+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T15:45:44.205+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T15:45:44.206+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T15:45:44.206+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-15T15:45:44.858+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T15:45:44.859+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T15:45:44.859+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T15:45:44.859+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T15:45:44.860+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T15:45:44.860+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T15:45:44.861+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T15:45:44.861+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T15:45:44.862+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T15:45:44.863+00:00 | INFO     | Input validation passed
#> 2026-09-15T15:45:44.863+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T15:45:44.864+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T15:45:44.864+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T15:45:44.872+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T15:45:44.872+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T15:45:44.873+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-15T15:45:44.873+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T15:45:44.874+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T15:45:44.884+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T15:45:44.884+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T15:45:44.885+00:00 | INFO     | Timer 'mrca_computation': 11 ms
#> 2026-09-15T15:45:44.885+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T15:45:44.887+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T15:45:44.887+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T15:45:45.007+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T15:45:45.040+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T15:45:45.041+00:00 | INFO     | Timer 'tree_rendering': 153 ms
#> 2026-09-15T15:45:45.041+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T15:45:45.190+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T15:45:45.190+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T15:45:45.190+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T15:45:45.191+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T15:45:45.191+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T15:45:45.191+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T15:45:45.192+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T15:45:45.192+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T15:45:45.193+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T15:45:45.193+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-15T15:45:45.793+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T15:45:45.794+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T15:45:45.794+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T15:45:45.794+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T15:45:45.795+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T15:45:45.795+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T15:45:45.796+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T15:45:45.796+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T15:45:45.797+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T15:45:45.798+00:00 | INFO     | Input validation passed
#> 2026-09-15T15:45:45.798+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T15:45:45.799+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T15:45:45.799+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T15:45:45.807+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T15:45:45.807+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T15:45:45.808+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-15T15:45:45.808+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T15:45:45.809+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T15:45:45.811+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T15:45:45.812+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T15:45:45.812+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-15T15:45:45.813+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T15:45:45.814+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T15:45:45.815+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T15:45:45.942+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T15:45:45.975+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T15:45:45.976+00:00 | INFO     | Timer 'tree_rendering': 161 ms
#> 2026-09-15T15:45:45.977+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T15:45:46.061+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T15:45:46.061+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T15:45:46.061+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T15:45:46.062+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T15:45:46.062+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T15:45:46.062+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T15:45:46.063+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T15:45:46.063+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T15:45:46.063+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T15:45:46.064+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-15T15:45:46.065+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T15:45:46.065+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T15:45:46.066+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T15:45:46.066+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T15:45:46.066+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T15:45:46.067+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T15:45:46.068+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T15:45:46.068+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T15:45:46.068+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T15:45:46.069+00:00 | INFO     | Input validation passed
#> 2026-09-15T15:45:46.070+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T15:45:46.070+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T15:45:46.071+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T15:45:46.085+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T15:45:46.086+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T15:45:46.087+00:00 | INFO     | Timer 'taxonomy_parsing': 16 ms
#> 2026-09-15T15:45:46.087+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T15:45:46.087+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T15:45:46.090+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T15:45:46.090+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T15:45:46.091+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-15T15:45:46.091+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T15:45:46.093+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T15:45:46.093+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T15:45:46.214+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T15:45:46.248+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T15:45:46.248+00:00 | INFO     | Timer 'tree_rendering': 155 ms
#> 2026-09-15T15:45:46.249+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T15:45:46.340+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T15:45:46.340+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T15:45:46.341+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T15:45:46.341+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T15:45:46.341+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T15:45:46.342+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T15:45:46.342+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T15:45:46.342+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T15:45:46.343+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T15:45:46.343+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-15T15:45:46.482+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T15:45:46.482+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T15:45:46.483+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T15:45:46.483+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T15:45:46.483+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T15:45:46.484+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T15:45:46.485+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T15:45:46.485+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T15:45:46.485+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T15:45:46.486+00:00 | INFO     | Input validation passed
#> 2026-09-15T15:45:46.487+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T15:45:46.487+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T15:45:46.487+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T15:45:46.495+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T15:45:46.496+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T15:45:46.496+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-15T15:45:46.497+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T15:45:46.497+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T15:45:46.499+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T15:45:46.500+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T15:45:46.500+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-15T15:45:46.501+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T15:45:46.503+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T15:45:46.503+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T15:45:46.625+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T15:45:46.656+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T15:45:46.657+00:00 | INFO     | Timer 'tree_rendering': 153 ms
#> 2026-09-15T15:45:46.657+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T15:45:46.751+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T15:45:46.751+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T15:45:46.751+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T15:45:46.752+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T15:45:46.752+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T15:45:46.752+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T15:45:46.753+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T15:45:46.753+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T15:45:46.753+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T15:45:46.754+00:00 | INFO     | plot_timetree completed successfully
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
