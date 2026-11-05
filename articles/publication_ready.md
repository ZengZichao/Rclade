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
#> 2026-11-05T05:59:15.543+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-05T05:59:15.544+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-05T05:59:15.544+00:00 | INFO     | Rank                     : phylum
#> 2026-11-05T05:59:15.544+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-05T05:59:15.545+00:00 | INFO     | Unit                     : auto
#> 2026-11-05T05:59:15.545+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-05T05:59:15.546+00:00 | INFO     | Tips                     : 50
#> 2026-11-05T05:59:15.546+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-05T05:59:15.547+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-05T05:59:15.547+00:00 | INFO     | Input validation passed
#> 2026-11-05T05:59:15.548+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-05T05:59:15.548+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-05T05:59:15.549+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-05T05:59:15.555+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-05T05:59:15.555+00:00 | INFO     | Groups found             : 5
#> 2026-11-05T05:59:15.555+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-11-05T05:59:15.556+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-05T05:59:15.556+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-05T05:59:15.559+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-05T05:59:15.559+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-05T05:59:15.559+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-11-05T05:59:16.170+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-05T05:59:16.175+00:00 | INFO     | Color palette            : viridis
#> 2026-11-05T05:59:16.175+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-05T05:59:16.319+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-05T05:59:16.343+00:00 | INFO     | Clade collapse complete
#> 2026-11-05T05:59:16.343+00:00 | INFO     | Timer 'tree_rendering': 167 ms
#> 2026-11-05T05:59:16.344+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-05T05:59:16.417+00:00 | INFO     |   Tips                        : 50
#> 2026-11-05T05:59:16.418+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-05T05:59:16.418+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-05T05:59:16.418+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-05T05:59:16.418+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-05T05:59:16.419+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-05T05:59:16.419+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-05T05:59:16.419+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-05T05:59:16.420+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-05T05:59:16.420+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-05T05:59:16.979+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-05T05:59:16.979+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-05T05:59:16.980+00:00 | INFO     | Rank                     : phylum
#> 2026-11-05T05:59:16.980+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-05T05:59:16.980+00:00 | INFO     | Unit                     : auto
#> 2026-11-05T05:59:16.980+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-05T05:59:16.981+00:00 | INFO     | Tips                     : 50
#> 2026-11-05T05:59:16.981+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-05T05:59:16.982+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-05T05:59:16.982+00:00 | INFO     | Input validation passed
#> 2026-11-05T05:59:16.983+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-05T05:59:16.983+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-05T05:59:16.983+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-05T05:59:16.988+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-05T05:59:16.989+00:00 | INFO     | Groups found             : 5
#> 2026-11-05T05:59:16.989+00:00 | INFO     | Timer 'taxonomy_parsing': 6 ms
#> 2026-11-05T05:59:16.989+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-05T05:59:16.990+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-05T05:59:16.992+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-05T05:59:16.992+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-05T05:59:16.992+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-05T05:59:16.993+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-05T05:59:16.994+00:00 | INFO     | Color palette            : viridis
#> 2026-11-05T05:59:16.994+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-05T05:59:17.084+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-05T05:59:17.107+00:00 | INFO     | Clade collapse complete
#> 2026-11-05T05:59:17.108+00:00 | INFO     | Timer 'tree_rendering': 113 ms
#> 2026-11-05T05:59:17.108+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-05T05:59:17.172+00:00 | INFO     |   Tips                        : 50
#> 2026-11-05T05:59:17.172+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-05T05:59:17.173+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-05T05:59:17.173+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-05T05:59:17.173+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-05T05:59:17.173+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-05T05:59:17.174+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-05T05:59:17.174+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-05T05:59:17.174+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-05T05:59:17.174+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-05T05:59:17.630+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-05T05:59:17.630+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-05T05:59:17.631+00:00 | INFO     | Rank                     : phylum
#> 2026-11-05T05:59:17.631+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-05T05:59:17.631+00:00 | INFO     | Unit                     : auto
#> 2026-11-05T05:59:17.632+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-05T05:59:17.632+00:00 | INFO     | Tips                     : 50
#> 2026-11-05T05:59:17.633+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-05T05:59:17.633+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-05T05:59:17.634+00:00 | INFO     | Input validation passed
#> 2026-11-05T05:59:17.634+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-05T05:59:17.634+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-05T05:59:17.634+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-05T05:59:17.640+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-05T05:59:17.640+00:00 | INFO     | Groups found             : 5
#> 2026-11-05T05:59:17.641+00:00 | INFO     | Timer 'taxonomy_parsing': 6 ms
#> 2026-11-05T05:59:17.641+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-05T05:59:17.641+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-05T05:59:17.643+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-05T05:59:17.644+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-05T05:59:17.644+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-05T05:59:17.645+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-05T05:59:17.646+00:00 | INFO     | Color palette            : viridis
#> 2026-11-05T05:59:17.646+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-05T05:59:17.739+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-05T05:59:17.762+00:00 | INFO     | Clade collapse complete
#> 2026-11-05T05:59:17.762+00:00 | INFO     | Timer 'tree_rendering': 116 ms
#> 2026-11-05T05:59:17.763+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-05T05:59:17.829+00:00 | INFO     |   Tips                        : 50
#> 2026-11-05T05:59:17.829+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-05T05:59:17.830+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-05T05:59:17.830+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-05T05:59:17.830+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-05T05:59:17.830+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-05T05:59:17.830+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-05T05:59:17.831+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-05T05:59:17.831+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-05T05:59:17.831+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-11-05T05:59:17.832+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-05T05:59:17.832+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-05T05:59:17.833+00:00 | INFO     | Rank                     : phylum
#> 2026-11-05T05:59:17.833+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-05T05:59:17.833+00:00 | INFO     | Unit                     : auto
#> 2026-11-05T05:59:17.833+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-05T05:59:17.834+00:00 | INFO     | Tips                     : 50
#> 2026-11-05T05:59:17.834+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-05T05:59:17.834+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-05T05:59:17.835+00:00 | INFO     | Input validation passed
#> 2026-11-05T05:59:17.835+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-05T05:59:17.836+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-05T05:59:17.836+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-05T05:59:17.841+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-05T05:59:17.841+00:00 | INFO     | Groups found             : 5
#> 2026-11-05T05:59:17.842+00:00 | INFO     | Timer 'taxonomy_parsing': 6 ms
#> 2026-11-05T05:59:17.842+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-05T05:59:17.842+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-05T05:59:17.844+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-05T05:59:17.844+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-05T05:59:17.845+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-05T05:59:17.845+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-05T05:59:17.846+00:00 | INFO     | Color palette            : viridis
#> 2026-11-05T05:59:17.847+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-05T05:59:17.932+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-05T05:59:17.954+00:00 | INFO     | Clade collapse complete
#> 2026-11-05T05:59:17.954+00:00 | INFO     | Timer 'tree_rendering': 107 ms
#> 2026-11-05T05:59:17.959+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-05T05:59:18.018+00:00 | INFO     |   Tips                        : 50
#> 2026-11-05T05:59:18.018+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-05T05:59:18.019+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-05T05:59:18.019+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-05T05:59:18.019+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-05T05:59:18.019+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-05T05:59:18.020+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-05T05:59:18.020+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-05T05:59:18.020+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-05T05:59:18.020+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-11-05T05:59:18.111+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-05T05:59:18.111+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-05T05:59:18.112+00:00 | INFO     | Rank                     : phylum
#> 2026-11-05T05:59:18.112+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-05T05:59:18.112+00:00 | INFO     | Unit                     : auto
#> 2026-11-05T05:59:18.112+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-05T05:59:18.113+00:00 | INFO     | Tips                     : 50
#> 2026-11-05T05:59:18.113+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-05T05:59:18.114+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-05T05:59:18.114+00:00 | INFO     | Input validation passed
#> 2026-11-05T05:59:18.115+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-11-05T05:59:18.115+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-05T05:59:18.115+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-05T05:59:18.121+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-05T05:59:18.121+00:00 | INFO     | Groups found             : 5
#> 2026-11-05T05:59:18.122+00:00 | INFO     | Timer 'taxonomy_parsing': 6 ms
#> 2026-11-05T05:59:18.122+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-05T05:59:18.122+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-05T05:59:18.124+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-05T05:59:18.124+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-05T05:59:18.125+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-11-05T05:59:18.125+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-05T05:59:18.126+00:00 | INFO     | Color palette            : viridis
#> 2026-11-05T05:59:18.127+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-05T05:59:18.217+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-05T05:59:18.240+00:00 | INFO     | Clade collapse complete
#> 2026-11-05T05:59:18.241+00:00 | INFO     | Timer 'tree_rendering': 114 ms
#> 2026-11-05T05:59:18.243+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-05T05:59:18.312+00:00 | INFO     |   Tips                        : 50
#> 2026-11-05T05:59:18.312+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-05T05:59:18.313+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-05T05:59:18.313+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-05T05:59:18.313+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-05T05:59:18.313+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-05T05:59:18.314+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-05T05:59:18.314+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-05T05:59:18.314+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-05T05:59:18.314+00:00 | INFO     | plot_timetree completed successfully
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
