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
#> 2026-08-26T05:53:19.782+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:53:19.783+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:53:19.784+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:53:19.784+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:53:19.784+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:53:19.785+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:53:19.787+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:53:19.787+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:53:19.787+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:53:19.788+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:53:19.789+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:53:19.789+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:53:19.790+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:53:19.798+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:53:19.798+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:53:19.799+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-26T05:53:19.799+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:53:19.800+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:53:19.803+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:53:19.804+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:53:19.804+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-26T05:53:20.690+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:53:20.698+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:53:20.699+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:53:20.902+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:53:20.930+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:53:20.931+00:00 | INFO     | Timer 'tree_rendering': 232 ms
#> 2026-08-26T05:53:20.931+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:53:21.024+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:53:21.025+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:53:21.025+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:53:21.025+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:53:21.026+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:53:21.026+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:53:21.026+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:53:21.027+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:53:21.027+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:53:21.027+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T05:53:21.598+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:53:21.598+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:53:21.598+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:53:21.599+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:53:21.599+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:53:21.600+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:53:21.601+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:53:21.601+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:53:21.601+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:53:21.602+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:53:21.603+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:53:21.603+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:53:21.603+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:53:21.617+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:53:21.617+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:53:21.618+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-26T05:53:21.618+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:53:21.619+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:53:21.621+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:53:21.621+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:53:21.622+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-26T05:53:21.622+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:53:21.624+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:53:21.624+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:53:21.734+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:53:21.762+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:53:21.762+00:00 | INFO     | Timer 'tree_rendering': 138 ms
#> 2026-08-26T05:53:21.763+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:53:21.896+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:53:21.896+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:53:21.897+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:53:21.897+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:53:21.897+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:53:21.898+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:53:21.898+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:53:21.898+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:53:21.899+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:53:21.899+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T05:53:22.477+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:53:22.477+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:53:22.478+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:53:22.478+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:53:22.478+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:53:22.479+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:53:22.480+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:53:22.480+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:53:22.481+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:53:22.482+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:53:22.482+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:53:22.482+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:53:22.483+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:53:22.490+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:53:22.491+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:53:22.491+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-26T05:53:22.491+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:53:22.492+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:53:22.494+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:53:22.495+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:53:22.495+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-26T05:53:22.496+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:53:22.497+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:53:22.498+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:53:22.612+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:53:22.639+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:53:22.639+00:00 | INFO     | Timer 'tree_rendering': 142 ms
#> 2026-08-26T05:53:22.640+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:53:22.717+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:53:22.717+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:53:22.718+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:53:22.718+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:53:22.718+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:53:22.719+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:53:22.719+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:53:22.719+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:53:22.720+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:53:22.720+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-26T05:53:22.721+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:53:22.722+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:53:22.722+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:53:22.722+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:53:22.722+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:53:22.723+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:53:22.724+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:53:22.724+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:53:22.724+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:53:22.725+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:53:22.726+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:53:22.726+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:53:22.726+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:53:22.740+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:53:22.740+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:53:22.741+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-26T05:53:22.741+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:53:22.741+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:53:22.744+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:53:22.744+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:53:22.744+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-26T05:53:22.745+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:53:22.746+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:53:22.747+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:53:22.856+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:53:22.882+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:53:22.883+00:00 | INFO     | Timer 'tree_rendering': 136 ms
#> 2026-08-26T05:53:22.883+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:53:22.969+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:53:22.970+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:53:22.970+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:53:22.970+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:53:22.971+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:53:22.971+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:53:22.971+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:53:22.972+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:53:22.972+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:53:22.972+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T05:53:23.105+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:53:23.105+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:53:23.105+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:53:23.106+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:53:23.106+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:53:23.107+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:53:23.108+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:53:23.108+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:53:23.108+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:53:23.109+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:53:23.110+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:53:23.110+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:53:23.110+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:53:23.118+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:53:23.118+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:53:23.119+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-26T05:53:23.119+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:53:23.119+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:53:23.122+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:53:23.122+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:53:23.123+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-26T05:53:23.123+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:53:23.125+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:53:23.125+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:53:23.239+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:53:23.265+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:53:23.266+00:00 | INFO     | Timer 'tree_rendering': 141 ms
#> 2026-08-26T05:53:23.266+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:53:23.354+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:53:23.355+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:53:23.355+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:53:23.356+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:53:23.356+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:53:23.356+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:53:23.356+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:53:23.357+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:53:23.357+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:53:23.357+00:00 | INFO     | plot_timetree completed successfully
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
