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
#> 2026-09-04T14:48:37.309+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:48:37.310+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:48:37.310+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:48:37.311+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:48:37.311+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:48:37.312+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:48:37.313+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:48:37.314+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:48:37.314+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:48:37.315+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:48:37.315+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-04T14:48:37.316+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:48:37.323+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:48:37.329+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:48:37.330+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:48:37.330+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-09-04T14:48:37.330+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:48:37.331+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:48:37.334+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:48:37.334+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:48:37.334+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-04T14:48:38.042+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:48:38.048+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:48:38.049+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:48:38.222+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:48:38.245+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:48:38.245+00:00 | INFO     | Timer 'tree_rendering': 196 ms
#> 2026-09-04T14:48:38.246+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:48:38.319+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:48:38.320+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:48:38.320+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:48:38.320+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:48:38.320+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:48:38.321+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:48:38.321+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:48:38.321+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:48:38.321+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:48:38.322+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-04T14:48:38.837+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:48:38.838+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:48:38.838+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:48:38.838+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:48:38.838+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:48:38.839+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:48:38.840+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:48:38.840+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:48:38.840+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:48:38.841+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:48:38.841+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-09-04T14:48:38.842+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:48:38.842+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:48:38.848+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:48:38.848+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:48:38.848+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-09-04T14:48:38.849+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:48:38.849+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:48:38.851+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:48:38.851+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:48:38.852+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-04T14:48:38.852+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:48:38.853+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:48:38.853+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:48:38.945+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:48:38.967+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:48:38.967+00:00 | INFO     | Timer 'tree_rendering': 113 ms
#> 2026-09-04T14:48:38.968+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:48:39.029+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:48:39.029+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:48:39.030+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:48:39.030+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:48:39.030+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:48:39.030+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:48:39.031+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:48:39.031+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:48:39.031+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:48:39.031+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-04T14:48:39.532+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:48:39.533+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:48:39.533+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:48:39.533+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:48:39.533+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:48:39.534+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:48:39.535+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:48:39.535+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:48:39.535+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:48:39.536+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:48:39.536+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-09-04T14:48:39.536+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:48:39.537+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:48:39.543+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:48:39.543+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:48:39.543+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-09-04T14:48:39.544+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:48:39.544+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:48:39.551+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:48:39.551+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:48:39.552+00:00 | INFO     | Timer 'mrca_computation': 8 ms
#> 2026-09-04T14:48:39.552+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:48:39.553+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:48:39.554+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:48:39.641+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:48:39.662+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:48:39.663+00:00 | INFO     | Timer 'tree_rendering': 109 ms
#> 2026-09-04T14:48:39.663+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:48:39.730+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:48:39.730+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:48:39.730+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:48:39.731+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:48:39.731+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:48:39.731+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:48:39.731+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:48:39.732+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:48:39.732+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:48:39.732+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-04T14:48:39.733+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:48:39.734+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:48:39.734+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:48:39.734+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:48:39.734+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:48:39.735+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:48:39.735+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:48:39.736+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:48:39.736+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:48:39.737+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:48:39.737+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-09-04T14:48:39.737+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:48:39.737+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:48:39.744+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:48:39.744+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:48:39.744+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-09-04T14:48:39.745+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:48:39.745+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:48:39.747+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:48:39.747+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:48:39.748+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-04T14:48:39.748+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:48:39.749+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:48:39.750+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:48:39.841+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:48:39.863+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:48:39.863+00:00 | INFO     | Timer 'tree_rendering': 113 ms
#> 2026-09-04T14:48:39.864+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:48:39.925+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:48:39.925+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:48:39.926+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:48:39.926+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:48:39.926+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:48:39.926+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:48:39.927+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:48:39.927+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:48:39.927+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:48:39.927+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-04T14:48:40.032+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:48:40.032+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:48:40.033+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:48:40.033+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:48:40.033+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:48:40.034+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:48:40.034+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:48:40.035+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:48:40.035+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:48:40.036+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:48:40.036+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-09-04T14:48:40.036+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:48:40.037+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:48:40.043+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:48:40.043+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:48:40.043+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-09-04T14:48:40.044+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:48:40.044+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:48:40.046+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:48:40.052+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:48:40.052+00:00 | INFO     | Timer 'mrca_computation': 8 ms
#> 2026-09-04T14:48:40.053+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:48:40.054+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:48:40.054+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:48:40.141+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:48:40.163+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:48:40.163+00:00 | INFO     | Timer 'tree_rendering': 108 ms
#> 2026-09-04T14:48:40.163+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:48:40.235+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:48:40.235+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:48:40.235+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:48:40.236+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:48:40.236+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:48:40.236+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:48:40.236+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:48:40.237+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:48:40.237+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:48:40.237+00:00 | INFO     | plot_timetree completed successfully
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
