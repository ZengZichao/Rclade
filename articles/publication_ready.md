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
#> 2026-09-03T07:12:56.788+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:12:56.789+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:12:56.789+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:12:56.790+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:12:56.790+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:12:56.791+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:12:56.793+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:12:56.794+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:12:56.794+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:12:56.795+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:12:56.796+00:00 | INFO     | Timer 'input_reading': 4 ms
#> 2026-09-03T07:12:56.796+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:12:56.805+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:12:56.813+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:12:56.813+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:12:56.814+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:12:56.814+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:12:56.815+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:12:56.818+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:12:56.819+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:12:56.819+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-03T07:12:57.679+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:12:57.686+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:12:57.687+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:12:57.906+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:12:57.934+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:12:57.935+00:00 | INFO     | Timer 'tree_rendering': 247 ms
#> 2026-09-03T07:12:57.935+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:12:58.027+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:12:58.027+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:12:58.028+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:12:58.028+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:12:58.028+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:12:58.028+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:12:58.029+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:12:58.029+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:12:58.029+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:12:58.030+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-03T07:12:58.615+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:12:58.615+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:12:58.616+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:12:58.616+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:12:58.616+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:12:58.617+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:12:58.618+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:12:58.618+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:12:58.618+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:12:58.619+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:12:58.620+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:12:58.620+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:12:58.620+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:12:58.628+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:12:58.628+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:12:58.629+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:12:58.629+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:12:58.629+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:12:58.632+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:12:58.632+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:12:58.633+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-03T07:12:58.633+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:12:58.635+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:12:58.635+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:12:58.749+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:12:58.776+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:12:58.777+00:00 | INFO     | Timer 'tree_rendering': 141 ms
#> 2026-09-03T07:12:58.777+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:12:58.855+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:12:58.856+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:12:58.856+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:12:58.856+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:12:58.856+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:12:58.857+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:12:58.857+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:12:58.857+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:12:58.858+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:12:58.858+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-03T07:12:59.491+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:12:59.492+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:12:59.492+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:12:59.492+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:12:59.493+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:12:59.493+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:12:59.494+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:12:59.494+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:12:59.495+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:12:59.496+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:12:59.496+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:12:59.496+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:12:59.497+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:12:59.504+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:12:59.505+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:12:59.505+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-09-03T07:12:59.505+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:12:59.506+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:12:59.514+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:12:59.515+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:12:59.515+00:00 | INFO     | Timer 'mrca_computation': 9 ms
#> 2026-09-03T07:12:59.516+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:12:59.517+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:12:59.518+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:12:59.628+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:12:59.655+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:12:59.656+00:00 | INFO     | Timer 'tree_rendering': 138 ms
#> 2026-09-03T07:12:59.656+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:12:59.740+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:12:59.741+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:12:59.741+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:12:59.741+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:12:59.742+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:12:59.742+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:12:59.742+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:12:59.743+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:12:59.743+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:12:59.744+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-03T07:12:59.745+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:12:59.746+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:12:59.746+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:12:59.746+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:12:59.746+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:12:59.747+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:12:59.748+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:12:59.748+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:12:59.748+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:12:59.749+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:12:59.750+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:12:59.750+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:12:59.750+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:12:59.758+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:12:59.759+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:12:59.759+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:12:59.759+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:12:59.760+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:12:59.762+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:12:59.763+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:12:59.763+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-03T07:12:59.764+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:12:59.765+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:12:59.766+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:12:59.908+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:12:59.939+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:12:59.939+00:00 | INFO     | Timer 'tree_rendering': 173 ms
#> 2026-09-03T07:12:59.940+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:13:00.025+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:13:00.026+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:13:00.026+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:13:00.027+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:13:00.027+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:13:00.027+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:13:00.028+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:13:00.028+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:13:00.028+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:13:00.029+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-03T07:13:00.167+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:13:00.168+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:13:00.168+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:13:00.168+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:13:00.169+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:13:00.169+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:13:00.170+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:13:00.171+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:13:00.171+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:13:00.172+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:13:00.172+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:13:00.173+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:13:00.173+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:13:00.181+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:13:00.181+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:13:00.182+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:13:00.182+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:13:00.182+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:13:00.185+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:13:00.192+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:13:00.192+00:00 | INFO     | Timer 'mrca_computation': 10 ms
#> 2026-09-03T07:13:00.193+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:13:00.194+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:13:00.195+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:13:00.304+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:13:00.331+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:13:00.332+00:00 | INFO     | Timer 'tree_rendering': 136 ms
#> 2026-09-03T07:13:00.332+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:13:00.421+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:13:00.421+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:13:00.422+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:13:00.422+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:13:00.423+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:13:00.423+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:13:00.423+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:13:00.423+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:13:00.424+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:13:00.424+00:00 | INFO     | plot_timetree completed successfully
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
