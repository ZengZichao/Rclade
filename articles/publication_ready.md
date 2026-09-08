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
#> 2026-09-08T07:09:25.780+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-08T07:09:25.781+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-08T07:09:25.782+00:00 | INFO     | Rank                     : phylum
#> 2026-09-08T07:09:25.782+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-08T07:09:25.783+00:00 | INFO     | Unit                     : auto
#> 2026-09-08T07:09:25.784+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-08T07:09:25.786+00:00 | INFO     | Tips                     : 50
#> 2026-09-08T07:09:25.786+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-08T07:09:25.787+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-08T07:09:25.788+00:00 | INFO     | Input validation passed
#> 2026-09-08T07:09:25.796+00:00 | INFO     | Timer 'input_reading': 12 ms
#> 2026-09-08T07:09:25.797+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-08T07:09:25.797+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-08T07:09:25.806+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-08T07:09:25.806+00:00 | INFO     | Groups found             : 5
#> 2026-09-08T07:09:25.807+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-08T07:09:25.807+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-08T07:09:25.807+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-08T07:09:25.811+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-08T07:09:25.812+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-08T07:09:25.812+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-08T07:09:26.648+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-08T07:09:26.656+00:00 | INFO     | Color palette            : viridis
#> 2026-09-08T07:09:26.656+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-08T07:09:26.884+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-08T07:09:26.914+00:00 | INFO     | Clade collapse complete
#> 2026-09-08T07:09:26.915+00:00 | INFO     | Timer 'tree_rendering': 258 ms
#> 2026-09-08T07:09:26.915+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-08T07:09:27.019+00:00 | INFO     |   Tips                        : 50
#> 2026-09-08T07:09:27.020+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-08T07:09:27.020+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-08T07:09:27.020+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-08T07:09:27.021+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-08T07:09:27.021+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-08T07:09:27.022+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-08T07:09:27.022+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-08T07:09:27.022+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-08T07:09:27.023+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-08T07:09:27.675+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-08T07:09:27.676+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-08T07:09:27.676+00:00 | INFO     | Rank                     : phylum
#> 2026-09-08T07:09:27.677+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-08T07:09:27.677+00:00 | INFO     | Unit                     : auto
#> 2026-09-08T07:09:27.678+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-08T07:09:27.679+00:00 | INFO     | Tips                     : 50
#> 2026-09-08T07:09:27.679+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-08T07:09:27.679+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-08T07:09:27.680+00:00 | INFO     | Input validation passed
#> 2026-09-08T07:09:27.681+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-08T07:09:27.681+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-08T07:09:27.682+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-08T07:09:27.690+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-08T07:09:27.690+00:00 | INFO     | Groups found             : 5
#> 2026-09-08T07:09:27.691+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-08T07:09:27.691+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-08T07:09:27.691+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-08T07:09:27.694+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-08T07:09:27.695+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-08T07:09:27.695+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-08T07:09:27.696+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-08T07:09:27.697+00:00 | INFO     | Color palette            : viridis
#> 2026-09-08T07:09:27.698+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-08T07:09:27.821+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-08T07:09:27.851+00:00 | INFO     | Clade collapse complete
#> 2026-09-08T07:09:27.852+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-09-08T07:09:27.852+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-08T07:09:27.936+00:00 | INFO     |   Tips                        : 50
#> 2026-09-08T07:09:27.937+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-08T07:09:27.937+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-08T07:09:27.938+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-08T07:09:27.938+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-08T07:09:27.939+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-08T07:09:27.939+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-08T07:09:27.939+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-08T07:09:27.940+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-08T07:09:27.940+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-08T07:09:28.624+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-08T07:09:28.625+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-08T07:09:28.625+00:00 | INFO     | Rank                     : phylum
#> 2026-09-08T07:09:28.626+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-08T07:09:28.626+00:00 | INFO     | Unit                     : auto
#> 2026-09-08T07:09:28.627+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-08T07:09:28.628+00:00 | INFO     | Tips                     : 50
#> 2026-09-08T07:09:28.628+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-08T07:09:28.629+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-08T07:09:28.630+00:00 | INFO     | Input validation passed
#> 2026-09-08T07:09:28.630+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-08T07:09:28.630+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-08T07:09:28.631+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-08T07:09:28.639+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-08T07:09:28.640+00:00 | INFO     | Groups found             : 5
#> 2026-09-08T07:09:28.640+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-08T07:09:28.640+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-08T07:09:28.641+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-08T07:09:28.650+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-08T07:09:28.650+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-08T07:09:28.651+00:00 | INFO     | Timer 'mrca_computation': 10 ms
#> 2026-09-08T07:09:28.652+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-08T07:09:28.653+00:00 | INFO     | Color palette            : viridis
#> 2026-09-08T07:09:28.653+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-08T07:09:28.772+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-08T07:09:28.802+00:00 | INFO     | Clade collapse complete
#> 2026-09-08T07:09:28.802+00:00 | INFO     | Timer 'tree_rendering': 148 ms
#> 2026-09-08T07:09:28.803+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-08T07:09:28.894+00:00 | INFO     |   Tips                        : 50
#> 2026-09-08T07:09:28.895+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-08T07:09:28.895+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-08T07:09:28.895+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-08T07:09:28.896+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-08T07:09:28.896+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-08T07:09:28.897+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-08T07:09:28.897+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-08T07:09:28.897+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-08T07:09:28.898+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-08T07:09:28.899+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-08T07:09:28.900+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-08T07:09:28.900+00:00 | INFO     | Rank                     : phylum
#> 2026-09-08T07:09:28.901+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-08T07:09:28.901+00:00 | INFO     | Unit                     : auto
#> 2026-09-08T07:09:28.901+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-08T07:09:28.902+00:00 | INFO     | Tips                     : 50
#> 2026-09-08T07:09:28.903+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-08T07:09:28.903+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-08T07:09:28.904+00:00 | INFO     | Input validation passed
#> 2026-09-08T07:09:28.905+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-08T07:09:28.905+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-08T07:09:28.905+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-08T07:09:28.914+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-08T07:09:28.914+00:00 | INFO     | Groups found             : 5
#> 2026-09-08T07:09:28.915+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-08T07:09:28.915+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-08T07:09:28.916+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-08T07:09:28.918+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-08T07:09:28.919+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-08T07:09:28.919+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-08T07:09:28.920+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-08T07:09:28.921+00:00 | INFO     | Color palette            : viridis
#> 2026-09-08T07:09:28.922+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-08T07:09:29.046+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-08T07:09:29.075+00:00 | INFO     | Clade collapse complete
#> 2026-09-08T07:09:29.075+00:00 | INFO     | Timer 'tree_rendering': 153 ms
#> 2026-09-08T07:09:29.076+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-08T07:09:29.159+00:00 | INFO     |   Tips                        : 50
#> 2026-09-08T07:09:29.159+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-08T07:09:29.160+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-08T07:09:29.160+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-08T07:09:29.161+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-08T07:09:29.161+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-08T07:09:29.161+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-08T07:09:29.162+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-08T07:09:29.162+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-08T07:09:29.162+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-08T07:09:29.310+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-08T07:09:29.311+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-08T07:09:29.311+00:00 | INFO     | Rank                     : phylum
#> 2026-09-08T07:09:29.312+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-08T07:09:29.312+00:00 | INFO     | Unit                     : auto
#> 2026-09-08T07:09:29.312+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-08T07:09:29.313+00:00 | INFO     | Tips                     : 50
#> 2026-09-08T07:09:29.314+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-08T07:09:29.314+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-08T07:09:29.315+00:00 | INFO     | Input validation passed
#> 2026-09-08T07:09:29.316+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-08T07:09:29.316+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-08T07:09:29.316+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-08T07:09:29.325+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-08T07:09:29.325+00:00 | INFO     | Groups found             : 5
#> 2026-09-08T07:09:29.325+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-08T07:09:29.326+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-08T07:09:29.326+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-08T07:09:29.329+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-08T07:09:29.329+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-08T07:09:29.330+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-08T07:09:29.330+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-08T07:09:29.337+00:00 | INFO     | Color palette            : viridis
#> 2026-09-08T07:09:29.338+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-08T07:09:29.455+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-08T07:09:29.484+00:00 | INFO     | Clade collapse complete
#> 2026-09-08T07:09:29.484+00:00 | INFO     | Timer 'tree_rendering': 146 ms
#> 2026-09-08T07:09:29.485+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-08T07:09:29.580+00:00 | INFO     |   Tips                        : 50
#> 2026-09-08T07:09:29.580+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-08T07:09:29.581+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-08T07:09:29.581+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-08T07:09:29.581+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-08T07:09:29.582+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-08T07:09:29.582+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-08T07:09:29.583+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-08T07:09:29.583+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-08T07:09:29.583+00:00 | INFO     | plot_timetree completed successfully
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
