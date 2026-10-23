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
#> 2026-10-23T14:51:28.959+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-23T14:51:28.960+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-23T14:51:28.960+00:00 | INFO     | Rank                     : phylum
#> 2026-10-23T14:51:28.961+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-23T14:51:28.961+00:00 | INFO     | Unit                     : auto
#> 2026-10-23T14:51:28.962+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-23T14:51:28.963+00:00 | INFO     | Tips                     : 50
#> 2026-10-23T14:51:28.964+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-23T14:51:28.964+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-23T14:51:28.965+00:00 | INFO     | Input validation passed
#> 2026-10-23T14:51:28.966+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-10-23T14:51:28.966+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-23T14:51:28.967+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-23T14:51:28.976+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-23T14:51:28.976+00:00 | INFO     | Groups found             : 5
#> 2026-10-23T14:51:28.977+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-10-23T14:51:28.977+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-23T14:51:28.978+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-23T14:51:28.981+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-23T14:51:28.982+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-23T14:51:28.982+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-10-23T14:51:29.832+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-23T14:51:29.838+00:00 | INFO     | Color palette            : viridis
#> 2026-10-23T14:51:29.839+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-23T14:51:30.032+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-23T14:51:30.063+00:00 | INFO     | Clade collapse complete
#> 2026-10-23T14:51:30.063+00:00 | INFO     | Timer 'tree_rendering': 224 ms
#> 2026-10-23T14:51:30.064+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-23T14:51:30.165+00:00 | INFO     |   Tips                        : 50
#> 2026-10-23T14:51:30.165+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-23T14:51:30.166+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-23T14:51:30.166+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-23T14:51:30.166+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-23T14:51:30.167+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-23T14:51:30.167+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-23T14:51:30.168+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-23T14:51:30.168+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-23T14:51:30.168+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-10-23T14:51:30.771+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-23T14:51:30.772+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-23T14:51:30.772+00:00 | INFO     | Rank                     : phylum
#> 2026-10-23T14:51:30.772+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-23T14:51:30.773+00:00 | INFO     | Unit                     : auto
#> 2026-10-23T14:51:30.773+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-23T14:51:30.774+00:00 | INFO     | Tips                     : 50
#> 2026-10-23T14:51:30.775+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-23T14:51:30.775+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-23T14:51:30.776+00:00 | INFO     | Input validation passed
#> 2026-10-23T14:51:30.777+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-10-23T14:51:30.777+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-23T14:51:30.777+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-23T14:51:30.785+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-23T14:51:30.786+00:00 | INFO     | Groups found             : 5
#> 2026-10-23T14:51:30.786+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-10-23T14:51:30.787+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-23T14:51:30.787+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-23T14:51:30.790+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-23T14:51:30.790+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-23T14:51:30.791+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-10-23T14:51:30.791+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-23T14:51:30.793+00:00 | INFO     | Color palette            : viridis
#> 2026-10-23T14:51:30.793+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-23T14:51:30.912+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-23T14:51:30.941+00:00 | INFO     | Clade collapse complete
#> 2026-10-23T14:51:30.942+00:00 | INFO     | Timer 'tree_rendering': 148 ms
#> 2026-10-23T14:51:30.942+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-23T14:51:31.030+00:00 | INFO     |   Tips                        : 50
#> 2026-10-23T14:51:31.031+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-23T14:51:31.031+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-23T14:51:31.032+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-23T14:51:31.032+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-23T14:51:31.032+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-23T14:51:31.033+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-23T14:51:31.033+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-23T14:51:31.033+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-23T14:51:31.034+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-10-23T14:51:31.708+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-23T14:51:31.708+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-23T14:51:31.709+00:00 | INFO     | Rank                     : phylum
#> 2026-10-23T14:51:31.709+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-23T14:51:31.709+00:00 | INFO     | Unit                     : auto
#> 2026-10-23T14:51:31.710+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-23T14:51:31.711+00:00 | INFO     | Tips                     : 50
#> 2026-10-23T14:51:31.711+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-23T14:51:31.712+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-23T14:51:31.713+00:00 | INFO     | Input validation passed
#> 2026-10-23T14:51:31.713+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-10-23T14:51:31.714+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-23T14:51:31.714+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-23T14:51:31.722+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-23T14:51:31.722+00:00 | INFO     | Groups found             : 5
#> 2026-10-23T14:51:31.723+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-10-23T14:51:31.723+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-23T14:51:31.724+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-23T14:51:31.726+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-23T14:51:31.727+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-23T14:51:31.727+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-10-23T14:51:31.728+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-23T14:51:31.729+00:00 | INFO     | Color palette            : viridis
#> 2026-10-23T14:51:31.730+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-23T14:51:31.853+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-23T14:51:31.882+00:00 | INFO     | Clade collapse complete
#> 2026-10-23T14:51:31.882+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-10-23T14:51:31.883+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-23T14:51:31.972+00:00 | INFO     |   Tips                        : 50
#> 2026-10-23T14:51:31.972+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-23T14:51:31.973+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-23T14:51:31.973+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-23T14:51:31.973+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-23T14:51:31.974+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-23T14:51:31.974+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-23T14:51:31.975+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-23T14:51:31.975+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-23T14:51:31.975+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-10-23T14:51:31.977+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-23T14:51:31.977+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-23T14:51:31.978+00:00 | INFO     | Rank                     : phylum
#> 2026-10-23T14:51:31.978+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-23T14:51:31.978+00:00 | INFO     | Unit                     : auto
#> 2026-10-23T14:51:31.979+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-23T14:51:31.980+00:00 | INFO     | Tips                     : 50
#> 2026-10-23T14:51:31.981+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-23T14:51:31.981+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-23T14:51:31.982+00:00 | INFO     | Input validation passed
#> 2026-10-23T14:51:31.982+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-10-23T14:51:31.983+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-23T14:51:31.983+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-23T14:51:31.991+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-23T14:51:31.992+00:00 | INFO     | Groups found             : 5
#> 2026-10-23T14:51:31.992+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-10-23T14:51:31.993+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-23T14:51:31.993+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-23T14:51:31.996+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-23T14:51:31.996+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-23T14:51:31.996+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-10-23T14:51:31.997+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-23T14:51:31.999+00:00 | INFO     | Color palette            : viridis
#> 2026-10-23T14:51:31.999+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-23T14:51:32.118+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-23T14:51:32.147+00:00 | INFO     | Clade collapse complete
#> 2026-10-23T14:51:32.147+00:00 | INFO     | Timer 'tree_rendering': 148 ms
#> 2026-10-23T14:51:32.148+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-23T14:51:32.237+00:00 | INFO     |   Tips                        : 50
#> 2026-10-23T14:51:32.238+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-23T14:51:32.238+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-23T14:51:32.239+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-23T14:51:32.239+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-23T14:51:32.239+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-23T14:51:32.240+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-23T14:51:32.240+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-23T14:51:32.240+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-23T14:51:32.241+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-10-23T14:51:32.388+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-23T14:51:32.388+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-23T14:51:32.389+00:00 | INFO     | Rank                     : phylum
#> 2026-10-23T14:51:32.389+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-23T14:51:32.390+00:00 | INFO     | Unit                     : auto
#> 2026-10-23T14:51:32.390+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-23T14:51:32.391+00:00 | INFO     | Tips                     : 50
#> 2026-10-23T14:51:32.392+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-23T14:51:32.392+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-23T14:51:32.393+00:00 | INFO     | Input validation passed
#> 2026-10-23T14:51:32.394+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-10-23T14:51:32.394+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-23T14:51:32.394+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-23T14:51:32.403+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-23T14:51:32.403+00:00 | INFO     | Groups found             : 5
#> 2026-10-23T14:51:32.404+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-10-23T14:51:32.404+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-23T14:51:32.404+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-23T14:51:32.407+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-23T14:51:32.407+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-23T14:51:32.408+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-10-23T14:51:32.409+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-23T14:51:32.410+00:00 | INFO     | Color palette            : viridis
#> 2026-10-23T14:51:32.411+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-23T14:51:32.534+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-23T14:51:32.564+00:00 | INFO     | Clade collapse complete
#> 2026-10-23T14:51:32.565+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-10-23T14:51:32.565+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-23T14:51:32.662+00:00 | INFO     |   Tips                        : 50
#> 2026-10-23T14:51:32.663+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-23T14:51:32.663+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-23T14:51:32.663+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-23T14:51:32.664+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-23T14:51:32.664+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-23T14:51:32.665+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-23T14:51:32.665+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-23T14:51:32.665+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-23T14:51:32.666+00:00 | INFO     | plot_timetree completed successfully
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
