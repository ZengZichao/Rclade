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
#> 2026-09-07T08:20:16.488+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:20:16.489+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:20:16.490+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:20:16.490+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:20:16.491+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:20:16.492+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:20:16.494+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:20:16.494+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:20:16.495+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:20:16.496+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:20:16.503+00:00 | INFO     | Timer 'input_reading': 11 ms
#> 2026-09-07T08:20:16.504+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:20:16.504+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:20:16.513+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:20:16.513+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:20:16.514+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-07T08:20:16.514+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:20:16.515+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:20:16.518+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:20:16.519+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:20:16.519+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-07T08:20:17.315+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:20:17.322+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:20:17.323+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:20:17.545+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:20:17.574+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:20:17.575+00:00 | INFO     | Timer 'tree_rendering': 252 ms
#> 2026-09-07T08:20:17.575+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:20:17.671+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:20:17.671+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:20:17.672+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:20:17.672+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:20:17.672+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:20:17.673+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:20:17.673+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:20:17.674+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:20:17.674+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:20:17.674+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T08:20:18.318+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:20:18.318+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:20:18.319+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:20:18.319+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:20:18.319+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:20:18.320+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:20:18.321+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:20:18.321+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:20:18.322+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:20:18.323+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:20:18.323+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T08:20:18.323+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:20:18.324+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:20:18.332+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:20:18.332+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:20:18.333+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T08:20:18.333+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:20:18.333+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:20:18.336+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:20:18.336+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:20:18.337+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-07T08:20:18.338+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:20:18.339+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:20:18.339+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:20:18.460+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:20:18.488+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:20:18.489+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-09-07T08:20:18.489+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:20:18.570+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:20:18.571+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:20:18.571+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:20:18.572+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:20:18.572+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:20:18.572+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:20:18.573+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:20:18.573+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:20:18.574+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:20:18.574+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T08:20:19.234+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:20:19.234+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:20:19.234+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:20:19.235+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:20:19.235+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:20:19.236+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:20:19.237+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:20:19.237+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:20:19.237+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:20:19.238+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:20:19.239+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T08:20:19.239+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:20:19.240+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:20:19.250+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:20:19.250+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:20:19.251+00:00 | INFO     | Timer 'taxonomy_parsing': 11 ms
#> 2026-09-07T08:20:19.252+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:20:19.252+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:20:19.260+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:20:19.260+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:20:19.261+00:00 | INFO     | Timer 'mrca_computation': 8 ms
#> 2026-09-07T08:20:19.261+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:20:19.263+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:20:19.263+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:20:19.378+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:20:19.407+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:20:19.408+00:00 | INFO     | Timer 'tree_rendering': 144 ms
#> 2026-09-07T08:20:19.408+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:20:19.497+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:20:19.498+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:20:19.498+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:20:19.499+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:20:19.499+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:20:19.499+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:20:19.500+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:20:19.500+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:20:19.501+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:20:19.501+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-07T08:20:19.503+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:20:19.503+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:20:19.503+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:20:19.504+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:20:19.504+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:20:19.504+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:20:19.506+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:20:19.506+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:20:19.506+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:20:19.507+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:20:19.508+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T08:20:19.508+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:20:19.508+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:20:19.517+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:20:19.517+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:20:19.517+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T08:20:19.518+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:20:19.518+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:20:19.521+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:20:19.521+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:20:19.522+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-07T08:20:19.522+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:20:19.524+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:20:19.524+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:20:19.644+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:20:19.673+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:20:19.673+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-09-07T08:20:19.674+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:20:19.755+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:20:19.756+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:20:19.756+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:20:19.757+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:20:19.757+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:20:19.757+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:20:19.758+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:20:19.758+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:20:19.758+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:20:19.759+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T08:20:19.907+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:20:19.907+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:20:19.908+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:20:19.908+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:20:19.909+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:20:19.909+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:20:19.910+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:20:19.910+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:20:19.911+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:20:19.912+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:20:19.912+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T08:20:19.913+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:20:19.913+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:20:19.921+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:20:19.922+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:20:19.922+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T08:20:19.922+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:20:19.923+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:20:19.925+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:20:19.926+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:20:19.926+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-07T08:20:19.927+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:20:19.933+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:20:19.934+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:20:20.050+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:20:20.078+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:20:20.079+00:00 | INFO     | Timer 'tree_rendering': 145 ms
#> 2026-09-07T08:20:20.079+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:20:20.173+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:20:20.174+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:20:20.174+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:20:20.174+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:20:20.175+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:20:20.175+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:20:20.176+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:20:20.176+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:20:20.176+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:20:20.177+00:00 | INFO     | plot_timetree completed successfully
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
