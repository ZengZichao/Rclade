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
#> 2026-09-04T14:49:14.493+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:49:14.494+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:49:14.495+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:49:14.495+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:49:14.496+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:49:14.497+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:49:14.499+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:49:14.499+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:49:14.500+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:49:14.501+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:49:14.502+00:00 | INFO     | Timer 'input_reading': 4 ms
#> 2026-09-04T14:49:14.502+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:49:14.511+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:49:14.521+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:49:14.521+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:49:14.522+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-04T14:49:14.522+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:49:14.523+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:49:14.527+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:49:14.527+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:49:14.528+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-04T14:49:15.380+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:49:15.388+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:49:15.389+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:49:15.629+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:49:15.663+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:49:15.663+00:00 | INFO     | Timer 'tree_rendering': 274 ms
#> 2026-09-04T14:49:15.664+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:49:15.768+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:49:15.768+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:49:15.769+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:49:15.769+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:49:15.769+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:49:15.770+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:49:15.770+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:49:15.770+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:49:15.771+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:49:15.771+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-04T14:49:16.495+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:49:16.496+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:49:16.496+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:49:16.497+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:49:16.497+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:49:16.498+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:49:16.499+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:49:16.499+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:49:16.499+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:49:16.501+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:49:16.501+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-04T14:49:16.501+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:49:16.502+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:49:16.510+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:49:16.511+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:49:16.511+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-04T14:49:16.512+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:49:16.512+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:49:16.515+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:49:16.515+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:49:16.516+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-04T14:49:16.517+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:49:16.518+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:49:16.519+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:49:16.648+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:49:16.677+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:49:16.678+00:00 | INFO     | Timer 'tree_rendering': 159 ms
#> 2026-09-04T14:49:16.678+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:49:16.763+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:49:16.764+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:49:16.764+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:49:16.764+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:49:16.765+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:49:16.765+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:49:16.766+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:49:16.766+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:49:16.766+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:49:16.767+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-04T14:49:17.470+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:49:17.471+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:49:17.471+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:49:17.471+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:49:17.472+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:49:17.472+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:49:17.474+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:49:17.474+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:49:17.474+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:49:17.475+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:49:17.476+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-04T14:49:17.476+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:49:17.477+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:49:17.485+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:49:17.485+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:49:17.486+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-04T14:49:17.486+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:49:17.487+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:49:17.495+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:49:17.496+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:49:17.496+00:00 | INFO     | Timer 'mrca_computation': 10 ms
#> 2026-09-04T14:49:17.497+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:49:17.499+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:49:17.499+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:49:17.622+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:49:17.653+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:49:17.654+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-09-04T14:49:17.654+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:49:17.749+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:49:17.750+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:49:17.750+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:49:17.751+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:49:17.751+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:49:17.751+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:49:17.752+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:49:17.752+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:49:17.753+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:49:17.753+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-04T14:49:17.755+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:49:17.755+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:49:17.755+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:49:17.756+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:49:17.756+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:49:17.757+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:49:17.758+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:49:17.758+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:49:17.759+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:49:17.760+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:49:17.760+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-04T14:49:17.760+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:49:17.761+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:49:17.769+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:49:17.770+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:49:17.770+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-04T14:49:17.771+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:49:17.771+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:49:17.774+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:49:17.775+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:49:17.775+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-04T14:49:17.776+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:49:17.777+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:49:17.778+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:49:17.908+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:49:17.939+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:49:17.940+00:00 | INFO     | Timer 'tree_rendering': 162 ms
#> 2026-09-04T14:49:17.940+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:49:18.029+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:49:18.029+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:49:18.030+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:49:18.030+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:49:18.031+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:49:18.031+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:49:18.031+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:49:18.032+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:49:18.032+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:49:18.033+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-04T14:49:18.183+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-04T14:49:18.183+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-04T14:49:18.184+00:00 | INFO     | Rank                     : phylum
#> 2026-09-04T14:49:18.184+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-04T14:49:18.185+00:00 | INFO     | Unit                     : auto
#> 2026-09-04T14:49:18.185+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-04T14:49:18.186+00:00 | INFO     | Tips                     : 50
#> 2026-09-04T14:49:18.187+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-04T14:49:18.187+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-04T14:49:18.188+00:00 | INFO     | Input validation passed
#> 2026-09-04T14:49:18.189+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-04T14:49:18.189+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-04T14:49:18.189+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-04T14:49:18.198+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-04T14:49:18.198+00:00 | INFO     | Groups found             : 5
#> 2026-09-04T14:49:18.199+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-04T14:49:18.199+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-04T14:49:18.200+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-04T14:49:18.203+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-04T14:49:18.209+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-04T14:49:18.210+00:00 | INFO     | Timer 'mrca_computation': 10 ms
#> 2026-09-04T14:49:18.211+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-04T14:49:18.213+00:00 | INFO     | Color palette            : viridis
#> 2026-09-04T14:49:18.213+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-04T14:49:18.336+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-04T14:49:18.368+00:00 | INFO     | Clade collapse complete
#> 2026-09-04T14:49:18.369+00:00 | INFO     | Timer 'tree_rendering': 155 ms
#> 2026-09-04T14:49:18.369+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-04T14:49:18.470+00:00 | INFO     |   Tips                        : 50
#> 2026-09-04T14:49:18.471+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-04T14:49:18.471+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-04T14:49:18.471+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-04T14:49:18.472+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-04T14:49:18.472+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-04T14:49:18.473+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-04T14:49:18.473+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-04T14:49:18.473+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-04T14:49:18.474+00:00 | INFO     | plot_timetree completed successfully
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
