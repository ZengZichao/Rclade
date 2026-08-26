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
#> 2026-08-26T05:58:50.144+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:58:50.145+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:58:50.145+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:58:50.145+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:58:50.146+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:58:50.147+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:58:50.148+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:58:50.149+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:58:50.149+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:58:50.150+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:58:50.150+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:58:50.151+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:58:50.151+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:58:50.160+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:58:50.161+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:58:50.161+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-26T05:58:50.162+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:58:50.162+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:58:50.166+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:58:50.166+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:58:50.167+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-26T05:58:50.997+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:58:51.004+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:58:51.005+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:58:51.217+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:58:51.248+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:58:51.249+00:00 | INFO     | Timer 'tree_rendering': 243 ms
#> 2026-08-26T05:58:51.249+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:58:51.348+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:58:51.349+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:58:51.349+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:58:51.350+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:58:51.350+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:58:51.351+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:58:51.351+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:58:51.351+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:58:51.352+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:58:51.352+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T05:58:52.016+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:58:52.017+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:58:52.017+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:58:52.018+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:58:52.018+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:58:52.018+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:58:52.019+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:58:52.020+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:58:52.020+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:58:52.021+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:58:52.022+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:58:52.022+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:58:52.022+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:58:52.036+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:58:52.036+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:58:52.037+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-26T05:58:52.037+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:58:52.038+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:58:52.040+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:58:52.041+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:58:52.041+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-26T05:58:52.042+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:58:52.043+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:58:52.044+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:58:52.160+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:58:52.188+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:58:52.189+00:00 | INFO     | Timer 'tree_rendering': 145 ms
#> 2026-08-26T05:58:52.189+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:58:52.316+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:58:52.316+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:58:52.317+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:58:52.317+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:58:52.318+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:58:52.318+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:58:52.318+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:58:52.319+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:58:52.319+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:58:52.319+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T05:58:52.951+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:58:52.952+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:58:52.952+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:58:52.953+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:58:52.953+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:58:52.954+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:58:52.955+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:58:52.955+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:58:52.956+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:58:52.957+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:58:52.957+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:58:52.958+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:58:52.958+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:58:52.966+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:58:52.967+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:58:52.967+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-26T05:58:52.968+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:58:52.968+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:58:52.971+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:58:52.971+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:58:52.972+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-26T05:58:52.972+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:58:52.974+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:58:52.974+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:58:53.096+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:58:53.125+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:58:53.125+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-08-26T05:58:53.126+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:58:53.209+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:58:53.209+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:58:53.210+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:58:53.210+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:58:53.210+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:58:53.211+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:58:53.211+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:58:53.211+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:58:53.212+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:58:53.212+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-26T05:58:53.214+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:58:53.214+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:58:53.215+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:58:53.215+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:58:53.215+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:58:53.216+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:58:53.217+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:58:53.217+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:58:53.218+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:58:53.219+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:58:53.219+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:58:53.219+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:58:53.220+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:58:53.233+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:58:53.233+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:58:53.234+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-26T05:58:53.234+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:58:53.235+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:58:53.237+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:58:53.238+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:58:53.238+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-26T05:58:53.239+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:58:53.240+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:58:53.241+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:58:53.358+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:58:53.386+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:58:53.387+00:00 | INFO     | Timer 'tree_rendering': 146 ms
#> 2026-08-26T05:58:53.387+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:58:53.475+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:58:53.476+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:58:53.476+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:58:53.477+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:58:53.477+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:58:53.477+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:58:53.478+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:58:53.478+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:58:53.478+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:58:53.479+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T05:58:53.627+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:58:53.627+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:58:53.628+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:58:53.628+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:58:53.629+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:58:53.629+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:58:53.630+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:58:53.631+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:58:53.631+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:58:53.632+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:58:53.632+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:58:53.633+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:58:53.633+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:58:53.641+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:58:53.642+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:58:53.642+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-26T05:58:53.643+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:58:53.643+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:58:53.645+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:58:53.646+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:58:53.646+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-26T05:58:53.647+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:58:53.649+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:58:53.649+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:58:53.771+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:58:53.800+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:58:53.801+00:00 | INFO     | Timer 'tree_rendering': 151 ms
#> 2026-08-26T05:58:53.801+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:58:53.899+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:58:53.900+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:58:53.900+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:58:53.901+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:58:53.901+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:58:53.901+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:58:53.902+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:58:53.902+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:58:53.903+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:58:53.903+00:00 | INFO     | plot_timetree completed successfully
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
