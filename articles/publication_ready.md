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
#> 2026-11-02T12:59:41.938+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-02T12:59:41.939+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-02T12:59:41.939+00:00 | INFO     | Rank                     : phylum
#> 2026-11-02T12:59:41.940+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-02T12:59:41.940+00:00 | INFO     | Unit                     : auto
#> 2026-11-02T12:59:41.941+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-02T12:59:41.943+00:00 | INFO     | Tips                     : 50
#> 2026-11-02T12:59:41.943+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-02T12:59:41.944+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-02T12:59:41.944+00:00 | INFO     | Input validation passed
#> 2026-11-02T12:59:41.945+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-11-02T12:59:41.946+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-02T12:59:41.946+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-02T12:59:41.955+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-02T12:59:41.955+00:00 | INFO     | Groups found             : 5
#> 2026-11-02T12:59:41.956+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-11-02T12:59:41.956+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-02T12:59:41.957+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-02T12:59:41.961+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-02T12:59:41.961+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-02T12:59:41.962+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-11-02T12:59:42.834+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-02T12:59:42.840+00:00 | INFO     | Color palette            : viridis
#> 2026-11-02T12:59:42.841+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-02T12:59:43.036+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-02T12:59:43.068+00:00 | INFO     | Clade collapse complete
#> 2026-11-02T12:59:43.069+00:00 | INFO     | Timer 'tree_rendering': 228 ms
#> 2026-11-02T12:59:43.070+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-02T12:59:43.173+00:00 | INFO     |   Tips                        : 50
#> 2026-11-02T12:59:43.174+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-02T12:59:43.174+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-02T12:59:43.174+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-02T12:59:43.175+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-02T12:59:43.175+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-02T12:59:43.176+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-02T12:59:43.176+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-02T12:59:43.177+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-02T12:59:43.177+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-02T12:59:43.843+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-02T12:59:43.844+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-02T12:59:43.844+00:00 | INFO     | Rank                     : phylum
#> 2026-11-02T12:59:43.844+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-02T12:59:43.845+00:00 | INFO     | Unit                     : auto
#> 2026-11-02T12:59:43.845+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-02T12:59:43.846+00:00 | INFO     | Tips                     : 50
#> 2026-11-02T12:59:43.847+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-02T12:59:43.847+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-02T12:59:43.848+00:00 | INFO     | Input validation passed
#> 2026-11-02T12:59:43.848+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-11-02T12:59:43.849+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-02T12:59:43.849+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-02T12:59:43.857+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-02T12:59:43.858+00:00 | INFO     | Groups found             : 5
#> 2026-11-02T12:59:43.858+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-11-02T12:59:43.859+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-02T12:59:43.859+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-02T12:59:43.862+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-02T12:59:43.862+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-02T12:59:43.863+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-11-02T12:59:43.863+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-02T12:59:43.865+00:00 | INFO     | Color palette            : viridis
#> 2026-11-02T12:59:43.865+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-02T12:59:43.985+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-02T12:59:44.014+00:00 | INFO     | Clade collapse complete
#> 2026-11-02T12:59:44.015+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-11-02T12:59:44.015+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-02T12:59:44.107+00:00 | INFO     |   Tips                        : 50
#> 2026-11-02T12:59:44.108+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-02T12:59:44.108+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-02T12:59:44.108+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-02T12:59:44.109+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-02T12:59:44.109+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-02T12:59:44.110+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-02T12:59:44.110+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-02T12:59:44.110+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-02T12:59:44.111+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-02T12:59:44.796+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-02T12:59:44.796+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-02T12:59:44.796+00:00 | INFO     | Rank                     : phylum
#> 2026-11-02T12:59:44.797+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-02T12:59:44.797+00:00 | INFO     | Unit                     : auto
#> 2026-11-02T12:59:44.798+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-02T12:59:44.799+00:00 | INFO     | Tips                     : 50
#> 2026-11-02T12:59:44.799+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-02T12:59:44.800+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-02T12:59:44.801+00:00 | INFO     | Input validation passed
#> 2026-11-02T12:59:44.801+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-11-02T12:59:44.801+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-02T12:59:44.802+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-02T12:59:44.810+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-02T12:59:44.810+00:00 | INFO     | Groups found             : 5
#> 2026-11-02T12:59:44.811+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-11-02T12:59:44.811+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-02T12:59:44.812+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-02T12:59:44.815+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-02T12:59:44.815+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-02T12:59:44.815+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-11-02T12:59:44.816+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-02T12:59:44.818+00:00 | INFO     | Color palette            : viridis
#> 2026-11-02T12:59:44.818+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-02T12:59:44.944+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-02T12:59:44.973+00:00 | INFO     | Clade collapse complete
#> 2026-11-02T12:59:44.974+00:00 | INFO     | Timer 'tree_rendering': 155 ms
#> 2026-11-02T12:59:44.974+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-02T12:59:45.066+00:00 | INFO     |   Tips                        : 50
#> 2026-11-02T12:59:45.067+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-02T12:59:45.067+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-02T12:59:45.068+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-02T12:59:45.068+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-02T12:59:45.068+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-02T12:59:45.069+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-02T12:59:45.069+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-02T12:59:45.069+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-02T12:59:45.070+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-11-02T12:59:45.072+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-02T12:59:45.072+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-02T12:59:45.072+00:00 | INFO     | Rank                     : phylum
#> 2026-11-02T12:59:45.073+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-02T12:59:45.073+00:00 | INFO     | Unit                     : auto
#> 2026-11-02T12:59:45.073+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-02T12:59:45.075+00:00 | INFO     | Tips                     : 50
#> 2026-11-02T12:59:45.075+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-02T12:59:45.075+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-02T12:59:45.077+00:00 | INFO     | Input validation passed
#> 2026-11-02T12:59:45.077+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-11-02T12:59:45.077+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-02T12:59:45.078+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-02T12:59:45.086+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-02T12:59:45.087+00:00 | INFO     | Groups found             : 5
#> 2026-11-02T12:59:45.087+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-11-02T12:59:45.087+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-02T12:59:45.088+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-02T12:59:45.091+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-02T12:59:45.091+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-02T12:59:45.091+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-11-02T12:59:45.092+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-02T12:59:45.094+00:00 | INFO     | Color palette            : viridis
#> 2026-11-02T12:59:45.094+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-02T12:59:45.214+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-02T12:59:45.244+00:00 | INFO     | Clade collapse complete
#> 2026-11-02T12:59:45.245+00:00 | INFO     | Timer 'tree_rendering': 151 ms
#> 2026-11-02T12:59:45.251+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-02T12:59:45.338+00:00 | INFO     |   Tips                        : 50
#> 2026-11-02T12:59:45.338+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-02T12:59:45.339+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-02T12:59:45.339+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-02T12:59:45.339+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-02T12:59:45.340+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-02T12:59:45.340+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-02T12:59:45.341+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-02T12:59:45.341+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-02T12:59:45.341+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-02T12:59:45.487+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-02T12:59:45.488+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-02T12:59:45.488+00:00 | INFO     | Rank                     : phylum
#> 2026-11-02T12:59:45.489+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-02T12:59:45.489+00:00 | INFO     | Unit                     : auto
#> 2026-11-02T12:59:45.489+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-02T12:59:45.491+00:00 | INFO     | Tips                     : 50
#> 2026-11-02T12:59:45.491+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-02T12:59:45.491+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-02T12:59:45.492+00:00 | INFO     | Input validation passed
#> 2026-11-02T12:59:45.493+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-11-02T12:59:45.493+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-02T12:59:45.494+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-02T12:59:45.502+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-02T12:59:45.502+00:00 | INFO     | Groups found             : 5
#> 2026-11-02T12:59:45.503+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-11-02T12:59:45.503+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-02T12:59:45.504+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-02T12:59:45.506+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-02T12:59:45.507+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-02T12:59:45.507+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-11-02T12:59:45.508+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-02T12:59:45.510+00:00 | INFO     | Color palette            : viridis
#> 2026-11-02T12:59:45.510+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-02T12:59:45.636+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-02T12:59:45.665+00:00 | INFO     | Clade collapse complete
#> 2026-11-02T12:59:45.666+00:00 | INFO     | Timer 'tree_rendering': 155 ms
#> 2026-11-02T12:59:45.669+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-02T12:59:45.765+00:00 | INFO     |   Tips                        : 50
#> 2026-11-02T12:59:45.766+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-02T12:59:45.766+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-02T12:59:45.767+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-02T12:59:45.767+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-02T12:59:45.767+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-02T12:59:45.768+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-02T12:59:45.768+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-02T12:59:45.769+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-02T12:59:45.769+00:00 | INFO     | plot_timetree completed successfully
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
