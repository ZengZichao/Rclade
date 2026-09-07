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
#> 2026-09-07T09:12:11.717+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:12:11.718+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:12:11.718+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:12:11.719+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:12:11.719+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:12:11.721+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:12:11.723+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:12:11.723+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:12:11.724+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:12:11.725+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:12:11.734+00:00 | INFO     | Timer 'input_reading': 13 ms
#> 2026-09-07T09:12:11.734+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:12:11.735+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:12:11.744+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:12:11.745+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:12:11.745+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-07T09:12:11.746+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:12:11.746+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:12:11.750+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:12:11.751+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:12:11.751+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-07T09:12:12.613+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:12:12.622+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:12:12.623+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:12:12.861+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:12:12.893+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:12:12.894+00:00 | INFO     | Timer 'tree_rendering': 270 ms
#> 2026-09-07T09:12:12.895+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:12:13.003+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:12:13.003+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:12:13.003+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:12:13.004+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:12:13.004+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:12:13.005+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:12:13.005+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:12:13.005+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:12:13.006+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:12:13.006+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T09:12:13.682+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:12:13.682+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:12:13.683+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:12:13.683+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:12:13.683+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:12:13.684+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:12:13.685+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:12:13.686+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:12:13.686+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:12:13.687+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:12:13.687+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T09:12:13.688+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:12:13.688+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:12:13.697+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:12:13.697+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:12:13.698+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T09:12:13.698+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:12:13.698+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:12:13.701+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:12:13.702+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:12:13.702+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-07T09:12:13.703+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:12:13.704+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:12:13.705+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:12:13.835+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:12:13.865+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:12:13.866+00:00 | INFO     | Timer 'tree_rendering': 161 ms
#> 2026-09-07T09:12:13.866+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:12:13.954+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:12:13.955+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:12:13.955+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:12:13.956+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:12:13.956+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:12:13.956+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:12:13.957+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:12:13.957+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:12:13.958+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:12:13.958+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T09:12:14.661+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:12:14.662+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:12:14.662+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:12:14.662+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:12:14.663+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:12:14.663+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:12:14.664+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:12:14.665+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:12:14.665+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:12:14.666+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:12:14.667+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T09:12:14.667+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:12:14.667+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:12:14.676+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:12:14.676+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:12:14.677+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T09:12:14.677+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:12:14.677+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:12:14.686+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:12:14.687+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:12:14.687+00:00 | INFO     | Timer 'mrca_computation': 10 ms
#> 2026-09-07T09:12:14.688+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:12:14.690+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:12:14.690+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:12:14.814+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:12:14.847+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:12:14.848+00:00 | INFO     | Timer 'tree_rendering': 158 ms
#> 2026-09-07T09:12:14.849+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:12:14.943+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:12:14.943+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:12:14.943+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:12:14.944+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:12:14.944+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:12:14.945+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:12:14.945+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:12:14.945+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:12:14.946+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:12:14.946+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-07T09:12:14.948+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:12:14.948+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:12:14.949+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:12:14.949+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:12:14.949+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:12:14.950+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:12:14.951+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:12:14.952+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:12:14.952+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:12:14.953+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:12:14.954+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T09:12:14.954+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:12:14.954+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:12:14.963+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:12:14.964+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:12:14.964+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-07T09:12:14.965+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:12:14.965+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:12:14.968+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:12:14.969+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:12:14.969+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-07T09:12:14.970+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:12:14.972+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:12:14.972+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:12:15.098+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:12:15.130+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:12:15.131+00:00 | INFO     | Timer 'tree_rendering': 158 ms
#> 2026-09-07T09:12:15.132+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:12:15.219+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:12:15.219+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:12:15.220+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:12:15.220+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:12:15.220+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:12:15.221+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:12:15.221+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:12:15.222+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:12:15.222+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:12:15.222+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T09:12:15.373+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T09:12:15.373+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T09:12:15.373+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T09:12:15.374+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T09:12:15.374+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T09:12:15.375+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T09:12:15.376+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T09:12:15.376+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T09:12:15.377+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T09:12:15.378+00:00 | INFO     | Input validation passed
#> 2026-09-07T09:12:15.378+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T09:12:15.379+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T09:12:15.379+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T09:12:15.387+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T09:12:15.388+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T09:12:15.389+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-07T09:12:15.389+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T09:12:15.390+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T09:12:15.392+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T09:12:15.393+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T09:12:15.393+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-07T09:12:15.394+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T09:12:15.402+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T09:12:15.403+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T09:12:15.531+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T09:12:15.563+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T09:12:15.563+00:00 | INFO     | Timer 'tree_rendering': 160 ms
#> 2026-09-07T09:12:15.564+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T09:12:15.668+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T09:12:15.669+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T09:12:15.669+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T09:12:15.670+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T09:12:15.670+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T09:12:15.671+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T09:12:15.671+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T09:12:15.671+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T09:12:15.672+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T09:12:15.672+00:00 | INFO     | plot_timetree completed successfully
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
