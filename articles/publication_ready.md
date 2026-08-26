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
#> 2026-08-26T05:56:12.526+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:56:12.527+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:56:12.527+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:56:12.528+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:56:12.528+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:56:12.529+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:56:12.531+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:56:12.531+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:56:12.531+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:56:12.532+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:56:12.533+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:56:12.533+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:56:12.534+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:56:12.543+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:56:12.543+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:56:12.544+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-26T05:56:12.544+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:56:12.545+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:56:12.548+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:56:12.549+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:56:12.549+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-26T05:56:13.417+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:56:13.425+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:56:13.427+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:56:13.645+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:56:13.677+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:56:13.677+00:00 | INFO     | Timer 'tree_rendering': 250 ms
#> 2026-08-26T05:56:13.678+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:56:13.782+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:56:13.782+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:56:13.783+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:56:13.783+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:56:13.784+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:56:13.784+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:56:13.784+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:56:13.785+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:56:13.785+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:56:13.786+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T05:56:14.439+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:56:14.439+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:56:14.439+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:56:14.440+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:56:14.440+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:56:14.441+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:56:14.442+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:56:14.442+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:56:14.443+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:56:14.444+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:56:14.444+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:56:14.444+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:56:14.445+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:56:14.460+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:56:14.460+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:56:14.461+00:00 | INFO     | Timer 'taxonomy_parsing': 16 ms
#> 2026-08-26T05:56:14.461+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:56:14.462+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:56:14.464+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:56:14.465+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:56:14.465+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-26T05:56:14.466+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:56:14.468+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:56:14.468+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:56:14.591+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:56:14.622+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:56:14.622+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-08-26T05:56:14.623+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:56:14.764+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:56:14.765+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:56:14.765+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:56:14.766+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:56:14.766+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:56:14.766+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:56:14.767+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:56:14.767+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:56:14.768+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:56:14.768+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T05:56:15.403+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:56:15.404+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:56:15.404+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:56:15.405+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:56:15.405+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:56:15.406+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:56:15.407+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:56:15.407+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:56:15.407+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:56:15.408+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:56:15.409+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:56:15.409+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:56:15.410+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:56:15.418+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:56:15.419+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:56:15.419+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-26T05:56:15.420+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:56:15.420+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:56:15.423+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:56:15.424+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:56:15.424+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-26T05:56:15.425+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:56:15.427+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:56:15.427+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:56:15.557+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:56:15.588+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:56:15.589+00:00 | INFO     | Timer 'tree_rendering': 162 ms
#> 2026-08-26T05:56:15.590+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:56:15.675+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:56:15.675+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:56:15.676+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:56:15.676+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:56:15.676+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:56:15.677+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:56:15.677+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:56:15.678+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:56:15.678+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:56:15.678+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-26T05:56:15.680+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:56:15.680+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:56:15.681+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:56:15.681+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:56:15.681+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:56:15.682+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:56:15.683+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:56:15.683+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:56:15.684+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:56:15.685+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:56:15.685+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:56:15.686+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:56:15.686+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:56:15.700+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:56:15.701+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:56:15.701+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-26T05:56:15.702+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:56:15.702+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:56:15.705+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:56:15.705+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:56:15.706+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-26T05:56:15.707+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:56:15.708+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:56:15.708+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:56:15.831+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:56:15.861+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:56:15.861+00:00 | INFO     | Timer 'tree_rendering': 153 ms
#> 2026-08-26T05:56:15.862+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:56:15.952+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:56:15.953+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:56:15.953+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:56:15.954+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:56:15.954+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:56:15.955+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:56:15.955+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:56:15.955+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:56:15.956+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:56:15.956+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T05:56:16.106+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T05:56:16.107+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T05:56:16.107+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T05:56:16.107+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T05:56:16.108+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T05:56:16.108+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T05:56:16.109+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T05:56:16.110+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T05:56:16.110+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T05:56:16.111+00:00 | INFO     | Input validation passed
#> 2026-08-26T05:56:16.112+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T05:56:16.112+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T05:56:16.112+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T05:56:16.121+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T05:56:16.121+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T05:56:16.121+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-26T05:56:16.122+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T05:56:16.122+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T05:56:16.125+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T05:56:16.125+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T05:56:16.126+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-26T05:56:16.126+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T05:56:16.128+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T05:56:16.128+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T05:56:16.256+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T05:56:16.287+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T05:56:16.287+00:00 | INFO     | Timer 'tree_rendering': 159 ms
#> 2026-08-26T05:56:16.288+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T05:56:16.388+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T05:56:16.388+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T05:56:16.389+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T05:56:16.389+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T05:56:16.390+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T05:56:16.390+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T05:56:16.390+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T05:56:16.391+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T05:56:16.391+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T05:56:16.391+00:00 | INFO     | plot_timetree completed successfully
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
