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
#> 2026-09-03T07:14:21.444+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:14:21.445+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:14:21.446+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:14:21.446+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:14:21.447+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:14:21.448+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:14:21.450+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:14:21.450+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:14:21.451+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:14:21.452+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:14:21.453+00:00 | INFO     | Timer 'input_reading': 4 ms
#> 2026-09-03T07:14:21.453+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:14:21.461+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:14:21.470+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:14:21.470+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:14:21.471+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-03T07:14:21.471+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:14:21.471+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:14:21.475+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:14:21.476+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:14:21.476+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-03T07:14:22.296+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:14:22.303+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:14:22.304+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:14:22.526+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:14:22.556+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:14:22.556+00:00 | INFO     | Timer 'tree_rendering': 251 ms
#> 2026-09-03T07:14:22.557+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:14:22.655+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:14:22.655+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:14:22.656+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:14:22.656+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:14:22.657+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:14:22.657+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:14:22.657+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:14:22.658+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:14:22.658+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:14:22.659+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-03T07:14:23.280+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:14:23.280+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:14:23.281+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:14:23.281+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:14:23.281+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:14:23.282+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:14:23.283+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:14:23.283+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:14:23.284+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:14:23.285+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:14:23.285+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:14:23.286+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:14:23.286+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:14:23.294+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:14:23.295+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:14:23.295+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:14:23.295+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:14:23.296+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:14:23.298+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:14:23.299+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:14:23.299+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-03T07:14:23.300+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:14:23.301+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:14:23.302+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:14:23.422+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:14:23.451+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:14:23.451+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-09-03T07:14:23.452+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:14:23.533+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:14:23.534+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:14:23.534+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:14:23.535+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:14:23.535+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:14:23.535+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:14:23.536+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:14:23.536+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:14:23.536+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:14:23.537+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-03T07:14:24.198+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:14:24.198+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:14:24.198+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:14:24.199+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:14:24.199+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:14:24.200+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:14:24.201+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:14:24.201+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:14:24.202+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:14:24.203+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:14:24.203+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:14:24.203+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:14:24.204+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:14:24.212+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:14:24.212+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:14:24.213+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:14:24.213+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:14:24.213+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:14:24.221+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:14:24.222+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:14:24.222+00:00 | INFO     | Timer 'mrca_computation': 9 ms
#> 2026-09-03T07:14:24.223+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:14:24.225+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:14:24.225+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:14:24.345+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:14:24.374+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:14:24.375+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-09-03T07:14:24.375+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:14:24.464+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:14:24.465+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:14:24.465+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:14:24.465+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:14:24.466+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:14:24.466+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:14:24.467+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:14:24.467+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:14:24.467+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:14:24.468+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-03T07:14:24.469+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:14:24.470+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:14:24.470+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:14:24.471+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:14:24.471+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:14:24.471+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:14:24.472+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:14:24.473+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:14:24.473+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:14:24.474+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:14:24.475+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:14:24.475+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:14:24.475+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:14:24.484+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:14:24.484+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:14:24.484+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:14:24.485+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:14:24.485+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:14:24.488+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:14:24.488+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:14:24.489+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-03T07:14:24.490+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:14:24.491+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:14:24.491+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:14:24.612+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:14:24.641+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:14:24.642+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-09-03T07:14:24.642+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:14:24.725+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:14:24.725+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:14:24.725+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:14:24.726+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:14:24.726+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:14:24.727+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:14:24.727+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:14:24.727+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:14:24.728+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:14:24.728+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-03T07:14:24.877+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:14:24.877+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:14:24.877+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:14:24.878+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:14:24.878+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:14:24.879+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:14:24.880+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:14:24.880+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:14:24.881+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:14:24.881+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:14:24.882+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:14:24.882+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:14:24.883+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:14:24.891+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:14:24.891+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:14:24.892+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:14:24.892+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:14:24.892+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:14:24.895+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:14:24.900+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:14:24.901+00:00 | INFO     | Timer 'mrca_computation': 8 ms
#> 2026-09-03T07:14:24.901+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:14:24.903+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:14:24.903+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:14:25.019+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:14:25.047+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:14:25.048+00:00 | INFO     | Timer 'tree_rendering': 144 ms
#> 2026-09-03T07:14:25.048+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:14:25.143+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:14:25.143+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:14:25.144+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:14:25.144+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:14:25.145+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:14:25.145+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:14:25.145+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:14:25.146+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:14:25.146+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:14:25.147+00:00 | INFO     | plot_timetree completed successfully
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
