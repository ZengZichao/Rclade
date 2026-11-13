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
#> 2026-11-13T12:02:54.385+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T12:02:54.386+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T12:02:54.386+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T12:02:54.387+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T12:02:54.387+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T12:02:54.388+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T12:02:54.389+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T12:02:54.389+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T12:02:54.389+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T12:02:54.390+00:00 | INFO     | Input validation passed
#> 2026-11-13T12:02:54.390+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-11-13T12:02:54.391+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T12:02:54.391+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T12:02:54.398+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T12:02:54.399+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T12:02:54.399+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-11-13T12:02:54.399+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T12:02:54.399+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T12:02:54.402+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T12:02:54.403+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T12:02:54.403+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-11-13T12:02:55.180+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T12:02:55.186+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T12:02:55.186+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T12:02:55.342+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T12:02:55.366+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T12:02:55.367+00:00 | INFO     | Timer 'tree_rendering': 180 ms
#> 2026-11-13T12:02:55.367+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T12:02:55.450+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T12:02:55.450+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T12:02:55.450+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T12:02:55.451+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T12:02:55.451+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T12:02:55.451+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T12:02:55.452+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T12:02:55.452+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T12:02:55.452+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T12:02:55.452+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-13T12:02:55.880+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T12:02:55.880+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T12:02:55.880+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T12:02:55.880+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T12:02:55.881+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T12:02:55.881+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T12:02:55.882+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T12:02:55.882+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T12:02:55.882+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T12:02:55.883+00:00 | INFO     | Input validation passed
#> 2026-11-13T12:02:55.883+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-13T12:02:55.884+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T12:02:55.884+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T12:02:55.890+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T12:02:55.890+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T12:02:55.890+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-11-13T12:02:55.891+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T12:02:55.891+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T12:02:55.893+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T12:02:55.893+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T12:02:55.894+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-13T12:02:55.894+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T12:02:55.895+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T12:02:55.896+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T12:02:55.990+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T12:02:56.013+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T12:02:56.014+00:00 | INFO     | Timer 'tree_rendering': 118 ms
#> 2026-11-13T12:02:56.014+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T12:02:56.084+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T12:02:56.084+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T12:02:56.085+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T12:02:56.085+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T12:02:56.085+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T12:02:56.086+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T12:02:56.086+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T12:02:56.086+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T12:02:56.086+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T12:02:56.087+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-13T12:02:56.590+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T12:02:56.590+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T12:02:56.590+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T12:02:56.591+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T12:02:56.591+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T12:02:56.591+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T12:02:56.592+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T12:02:56.592+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T12:02:56.593+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T12:02:56.593+00:00 | INFO     | Input validation passed
#> 2026-11-13T12:02:56.594+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-13T12:02:56.594+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T12:02:56.594+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T12:02:56.600+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T12:02:56.601+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T12:02:56.601+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-11-13T12:02:56.601+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T12:02:56.602+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T12:02:56.604+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T12:02:56.604+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T12:02:56.604+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-13T12:02:56.605+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T12:02:56.606+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T12:02:56.606+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T12:02:56.701+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T12:02:56.725+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T12:02:56.725+00:00 | INFO     | Timer 'tree_rendering': 119 ms
#> 2026-11-13T12:02:56.726+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T12:02:56.797+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T12:02:56.798+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T12:02:56.798+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T12:02:56.798+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T12:02:56.798+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T12:02:56.799+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T12:02:56.799+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T12:02:56.799+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T12:02:56.799+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T12:02:56.800+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-11-13T12:02:56.801+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T12:02:56.801+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T12:02:56.801+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T12:02:56.801+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T12:02:56.802+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T12:02:56.802+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T12:02:56.803+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T12:02:56.803+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T12:02:56.803+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T12:02:56.804+00:00 | INFO     | Input validation passed
#> 2026-11-13T12:02:56.804+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-13T12:02:56.805+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T12:02:56.805+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T12:02:56.811+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T12:02:56.811+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T12:02:56.812+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-11-13T12:02:56.812+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T12:02:56.812+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T12:02:56.814+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T12:02:56.815+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T12:02:56.815+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-13T12:02:56.815+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T12:02:56.817+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T12:02:56.817+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T12:02:56.910+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T12:02:56.933+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T12:02:56.933+00:00 | INFO     | Timer 'tree_rendering': 116 ms
#> 2026-11-13T12:02:56.939+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T12:02:57.004+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T12:02:57.004+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T12:02:57.005+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T12:02:57.005+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T12:02:57.005+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T12:02:57.005+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T12:02:57.006+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T12:02:57.006+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T12:02:57.006+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T12:02:57.006+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-13T12:02:57.105+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-13T12:02:57.105+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-13T12:02:57.105+00:00 | INFO     | Rank                     : phylum
#> 2026-11-13T12:02:57.106+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-13T12:02:57.106+00:00 | INFO     | Unit                     : auto
#> 2026-11-13T12:02:57.106+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-13T12:02:57.107+00:00 | INFO     | Tips                     : 50
#> 2026-11-13T12:02:57.107+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-13T12:02:57.108+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-13T12:02:57.108+00:00 | INFO     | Input validation passed
#> 2026-11-13T12:02:57.109+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-13T12:02:57.109+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-13T12:02:57.109+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-13T12:02:57.115+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-13T12:02:57.116+00:00 | INFO     | Groups found             : 5
#> 2026-11-13T12:02:57.116+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-11-13T12:02:57.116+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-13T12:02:57.117+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-13T12:02:57.119+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-13T12:02:57.119+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-13T12:02:57.119+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-13T12:02:57.120+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-13T12:02:57.121+00:00 | INFO     | Color palette            : viridis
#> 2026-11-13T12:02:57.121+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-13T12:02:57.216+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-13T12:02:57.239+00:00 | INFO     | Clade collapse complete
#> 2026-11-13T12:02:57.239+00:00 | INFO     | Timer 'tree_rendering': 117 ms
#> 2026-11-13T12:02:57.241+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-13T12:02:57.322+00:00 | INFO     |   Tips                        : 50
#> 2026-11-13T12:02:57.322+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-13T12:02:57.322+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-13T12:02:57.322+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-13T12:02:57.323+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-13T12:02:57.323+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-13T12:02:57.323+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-13T12:02:57.323+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-13T12:02:57.324+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-13T12:02:57.324+00:00 | INFO     | plot_timetree completed successfully
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
