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
#> 2026-09-07T08:24:02.810+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:24:02.811+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:24:02.812+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:24:02.812+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:24:02.813+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:24:02.814+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:24:02.816+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:24:02.816+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:24:02.817+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:24:02.818+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:24:02.826+00:00 | INFO     | Timer 'input_reading': 11 ms
#> 2026-09-07T08:24:02.826+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:24:02.827+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:24:02.835+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:24:02.836+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:24:02.836+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-07T08:24:02.837+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:24:02.837+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:24:02.841+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:24:02.842+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:24:02.842+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-07T08:24:03.670+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:24:03.677+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:24:03.678+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:24:03.910+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:24:03.942+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:24:03.943+00:00 | INFO     | Timer 'tree_rendering': 264 ms
#> 2026-09-07T08:24:03.943+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:24:04.043+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:24:04.044+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:24:04.044+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:24:04.045+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:24:04.045+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:24:04.045+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:24:04.046+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:24:04.046+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:24:04.046+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:24:04.047+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T08:24:04.664+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:24:04.664+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:24:04.665+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:24:04.665+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:24:04.666+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:24:04.666+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:24:04.667+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:24:04.667+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:24:04.668+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:24:04.669+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:24:04.669+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T08:24:04.670+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:24:04.670+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:24:04.679+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:24:04.679+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:24:04.679+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T08:24:04.680+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:24:04.680+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:24:04.683+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:24:04.683+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:24:04.684+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-07T08:24:04.684+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:24:04.686+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:24:04.686+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:24:04.810+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:24:04.840+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:24:04.841+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-09-07T08:24:04.841+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:24:04.928+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:24:04.928+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:24:04.929+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:24:04.929+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:24:04.929+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:24:04.930+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:24:04.930+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:24:04.931+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:24:04.931+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:24:04.931+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T08:24:05.605+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:24:05.606+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:24:05.606+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:24:05.607+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:24:05.607+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:24:05.607+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:24:05.609+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:24:05.609+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:24:05.609+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:24:05.610+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:24:05.611+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T08:24:05.611+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:24:05.612+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:24:05.620+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:24:05.620+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:24:05.621+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T08:24:05.621+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:24:05.621+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:24:05.629+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:24:05.630+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:24:05.630+00:00 | INFO     | Timer 'mrca_computation': 9 ms
#> 2026-09-07T08:24:05.631+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:24:05.632+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:24:05.633+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:24:05.752+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:24:05.783+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:24:05.783+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-09-07T08:24:05.784+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:24:05.874+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:24:05.875+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:24:05.875+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:24:05.876+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:24:05.876+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:24:05.876+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:24:05.877+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:24:05.877+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:24:05.877+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:24:05.878+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-07T08:24:05.880+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:24:05.880+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:24:05.880+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:24:05.881+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:24:05.881+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:24:05.882+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:24:05.883+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:24:05.883+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:24:05.884+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:24:05.885+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:24:05.885+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T08:24:05.886+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:24:05.886+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:24:05.895+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:24:05.895+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:24:05.896+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T08:24:05.896+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:24:05.896+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:24:05.899+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:24:05.900+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:24:05.900+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-07T08:24:05.901+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:24:05.902+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:24:05.903+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:24:06.029+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:24:06.059+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:24:06.060+00:00 | INFO     | Timer 'tree_rendering': 156 ms
#> 2026-09-07T08:24:06.060+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:24:06.148+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:24:06.148+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:24:06.149+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:24:06.149+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:24:06.150+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:24:06.150+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:24:06.150+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:24:06.151+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:24:06.151+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:24:06.152+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-07T08:24:06.301+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-07T08:24:06.301+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-07T08:24:06.302+00:00 | INFO     | Rank                     : phylum
#> 2026-09-07T08:24:06.302+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-07T08:24:06.302+00:00 | INFO     | Unit                     : auto
#> 2026-09-07T08:24:06.303+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-07T08:24:06.304+00:00 | INFO     | Tips                     : 50
#> 2026-09-07T08:24:06.304+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-07T08:24:06.305+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-07T08:24:06.306+00:00 | INFO     | Input validation passed
#> 2026-09-07T08:24:06.306+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-07T08:24:06.307+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-07T08:24:06.307+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-07T08:24:06.315+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-07T08:24:06.315+00:00 | INFO     | Groups found             : 5
#> 2026-09-07T08:24:06.316+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-07T08:24:06.316+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-07T08:24:06.317+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-07T08:24:06.319+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-07T08:24:06.320+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-07T08:24:06.320+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-07T08:24:06.321+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-07T08:24:06.328+00:00 | INFO     | Color palette            : viridis
#> 2026-09-07T08:24:06.328+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-07T08:24:06.448+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-07T08:24:06.477+00:00 | INFO     | Clade collapse complete
#> 2026-09-07T08:24:06.478+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-09-07T08:24:06.478+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-07T08:24:06.576+00:00 | INFO     |   Tips                        : 50
#> 2026-09-07T08:24:06.576+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-07T08:24:06.577+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-07T08:24:06.577+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-07T08:24:06.578+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-07T08:24:06.578+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-07T08:24:06.578+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-07T08:24:06.579+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-07T08:24:06.579+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-07T08:24:06.579+00:00 | INFO     | plot_timetree completed successfully
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
