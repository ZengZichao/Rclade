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
#> 2026-09-15T16:12:50.396+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:12:50.396+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:12:50.397+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:12:50.397+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:12:50.398+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:12:50.399+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:12:50.400+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:12:50.400+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:12:50.401+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:12:50.402+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:12:50.402+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:12:50.403+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:12:50.403+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:12:50.412+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:12:50.413+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:12:50.413+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-15T16:12:50.414+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:12:50.414+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:12:50.418+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:12:50.418+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:12:50.419+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-15T16:12:51.251+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:12:51.258+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:12:51.259+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:12:51.468+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:12:51.498+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:12:51.498+00:00 | INFO     | Timer 'tree_rendering': 239 ms
#> 2026-09-15T16:12:51.499+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:12:51.595+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:12:51.596+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:12:51.596+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:12:51.596+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:12:51.597+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:12:51.597+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:12:51.598+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:12:51.598+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:12:51.598+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:12:51.599+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-15T16:12:52.213+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:12:52.213+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:12:52.214+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:12:52.214+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:12:52.214+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:12:52.215+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:12:52.216+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:12:52.216+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:12:52.217+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:12:52.218+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:12:52.218+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:12:52.219+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:12:52.219+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:12:52.227+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:12:52.227+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:12:52.228+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-15T16:12:52.228+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:12:52.229+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:12:52.237+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:12:52.238+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:12:52.238+00:00 | INFO     | Timer 'mrca_computation': 10 ms
#> 2026-09-15T16:12:52.239+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:12:52.240+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:12:52.241+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:12:52.358+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:12:52.386+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:12:52.387+00:00 | INFO     | Timer 'tree_rendering': 145 ms
#> 2026-09-15T16:12:52.387+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:12:52.518+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:12:52.519+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:12:52.519+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:12:52.519+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:12:52.520+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:12:52.520+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:12:52.521+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:12:52.521+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:12:52.521+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:12:52.522+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-15T16:12:53.154+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:12:53.154+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:12:53.154+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:12:53.155+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:12:53.155+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:12:53.156+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:12:53.157+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:12:53.157+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:12:53.158+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:12:53.159+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:12:53.159+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:12:53.160+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:12:53.160+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:12:53.168+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:12:53.169+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:12:53.169+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-15T16:12:53.169+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:12:53.170+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:12:53.172+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:12:53.173+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:12:53.173+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-15T16:12:53.174+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:12:53.175+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:12:53.176+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:12:53.308+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:12:53.337+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:12:53.338+00:00 | INFO     | Timer 'tree_rendering': 161 ms
#> 2026-09-15T16:12:53.338+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:12:53.422+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:12:53.422+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:12:53.422+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:12:53.423+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:12:53.423+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:12:53.424+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:12:53.424+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:12:53.424+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:12:53.425+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:12:53.425+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-15T16:12:53.427+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:12:53.427+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:12:53.428+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:12:53.428+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:12:53.428+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:12:53.429+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:12:53.430+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:12:53.430+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:12:53.431+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:12:53.431+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:12:53.432+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:12:53.432+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:12:53.433+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:12:53.446+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:12:53.447+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:12:53.447+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-09-15T16:12:53.448+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:12:53.448+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:12:53.451+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:12:53.451+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:12:53.452+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-15T16:12:53.452+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:12:53.454+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:12:53.454+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:12:53.571+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:12:53.600+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:12:53.600+00:00 | INFO     | Timer 'tree_rendering': 146 ms
#> 2026-09-15T16:12:53.601+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:12:53.689+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:12:53.690+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:12:53.690+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:12:53.691+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:12:53.691+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:12:53.691+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:12:53.692+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:12:53.692+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:12:53.693+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:12:53.693+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-15T16:12:53.843+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:12:53.843+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:12:53.844+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:12:53.844+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:12:53.844+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:12:53.845+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:12:53.846+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:12:53.846+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:12:53.847+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:12:53.848+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:12:53.848+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:12:53.849+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:12:53.849+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:12:53.857+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:12:53.858+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:12:53.858+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-15T16:12:53.858+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:12:53.859+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:12:53.861+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:12:53.862+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:12:53.862+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-15T16:12:53.863+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:12:53.864+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:12:53.865+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:12:53.987+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:12:54.016+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:12:54.016+00:00 | INFO     | Timer 'tree_rendering': 151 ms
#> 2026-09-15T16:12:54.017+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:12:54.112+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:12:54.113+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:12:54.113+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:12:54.113+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:12:54.114+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:12:54.114+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:12:54.115+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:12:54.115+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:12:54.115+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:12:54.116+00:00 | INFO     | plot_timetree completed successfully
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
