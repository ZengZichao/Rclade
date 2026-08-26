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
#> 2026-08-26T06:33:12.255+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T06:33:12.256+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T06:33:12.257+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T06:33:12.257+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T06:33:12.257+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T06:33:12.258+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T06:33:12.260+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T06:33:12.260+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T06:33:12.261+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T06:33:12.261+00:00 | INFO     | Input validation passed
#> 2026-08-26T06:33:12.262+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T06:33:12.263+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T06:33:12.263+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T06:33:12.272+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T06:33:12.272+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T06:33:12.273+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-26T06:33:12.273+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T06:33:12.274+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T06:33:12.277+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T06:33:12.278+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T06:33:12.278+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-26T06:33:13.098+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T06:33:13.105+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T06:33:13.106+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T06:33:13.310+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T06:33:13.340+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T06:33:13.341+00:00 | INFO     | Timer 'tree_rendering': 235 ms
#> 2026-08-26T06:33:13.341+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T06:33:13.438+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T06:33:13.438+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T06:33:13.438+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T06:33:13.439+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T06:33:13.439+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T06:33:13.440+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T06:33:13.440+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T06:33:13.440+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T06:33:13.441+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T06:33:13.441+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T06:33:14.132+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T06:33:14.132+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T06:33:14.132+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T06:33:14.133+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T06:33:14.133+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T06:33:14.134+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T06:33:14.135+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T06:33:14.135+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T06:33:14.135+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T06:33:14.136+00:00 | INFO     | Input validation passed
#> 2026-08-26T06:33:14.137+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T06:33:14.137+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T06:33:14.138+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T06:33:14.151+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T06:33:14.152+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T06:33:14.153+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-26T06:33:14.153+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T06:33:14.153+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T06:33:14.156+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T06:33:14.156+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T06:33:14.157+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-26T06:33:14.158+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T06:33:14.159+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T06:33:14.159+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T06:33:14.275+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T06:33:14.304+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T06:33:14.304+00:00 | INFO     | Timer 'tree_rendering': 144 ms
#> 2026-08-26T06:33:14.305+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T06:33:14.430+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T06:33:14.431+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T06:33:14.431+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T06:33:14.432+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T06:33:14.432+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T06:33:14.432+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T06:33:14.433+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T06:33:14.433+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T06:33:14.434+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T06:33:14.434+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T06:33:15.122+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T06:33:15.122+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T06:33:15.123+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T06:33:15.123+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T06:33:15.123+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T06:33:15.124+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T06:33:15.125+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T06:33:15.125+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T06:33:15.126+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T06:33:15.127+00:00 | INFO     | Input validation passed
#> 2026-08-26T06:33:15.127+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T06:33:15.128+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T06:33:15.128+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T06:33:15.136+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T06:33:15.136+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T06:33:15.137+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-26T06:33:15.137+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T06:33:15.138+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T06:33:15.140+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T06:33:15.141+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T06:33:15.141+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-26T06:33:15.142+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T06:33:15.143+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T06:33:15.144+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T06:33:15.264+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T06:33:15.293+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T06:33:15.293+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-08-26T06:33:15.294+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T06:33:15.376+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T06:33:15.376+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T06:33:15.377+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T06:33:15.377+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T06:33:15.378+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T06:33:15.378+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T06:33:15.378+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T06:33:15.379+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T06:33:15.379+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T06:33:15.379+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-26T06:33:15.381+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T06:33:15.381+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T06:33:15.382+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T06:33:15.382+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T06:33:15.383+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T06:33:15.383+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T06:33:15.384+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T06:33:15.384+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T06:33:15.385+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T06:33:15.386+00:00 | INFO     | Input validation passed
#> 2026-08-26T06:33:15.386+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T06:33:15.387+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T06:33:15.387+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T06:33:15.400+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T06:33:15.400+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T06:33:15.401+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-26T06:33:15.401+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T06:33:15.401+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T06:33:15.404+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T06:33:15.404+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T06:33:15.405+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-26T06:33:15.406+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T06:33:15.407+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T06:33:15.407+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T06:33:15.523+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T06:33:15.552+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T06:33:15.552+00:00 | INFO     | Timer 'tree_rendering': 144 ms
#> 2026-08-26T06:33:15.552+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T06:33:15.640+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T06:33:15.640+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T06:33:15.640+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T06:33:15.641+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T06:33:15.641+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T06:33:15.642+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T06:33:15.642+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T06:33:15.642+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T06:33:15.643+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T06:33:15.643+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-26T06:33:15.822+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-26T06:33:15.823+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-26T06:33:15.823+00:00 | INFO     | Rank                     : phylum
#> 2026-08-26T06:33:15.824+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-26T06:33:15.824+00:00 | INFO     | Unit                     : auto
#> 2026-08-26T06:33:15.825+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-26T06:33:15.826+00:00 | INFO     | Tips                     : 50
#> 2026-08-26T06:33:15.826+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-26T06:33:15.826+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-26T06:33:15.827+00:00 | INFO     | Input validation passed
#> 2026-08-26T06:33:15.828+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-26T06:33:15.828+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-26T06:33:15.829+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-26T06:33:15.837+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-26T06:33:15.837+00:00 | INFO     | Groups found             : 5
#> 2026-08-26T06:33:15.838+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-26T06:33:15.838+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-26T06:33:15.838+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-26T06:33:15.841+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-26T06:33:15.842+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-26T06:33:15.842+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-26T06:33:15.843+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-26T06:33:15.844+00:00 | INFO     | Color palette            : viridis
#> 2026-08-26T06:33:15.845+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-26T06:33:15.965+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-26T06:33:15.994+00:00 | INFO     | Clade collapse complete
#> 2026-08-26T06:33:15.994+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-08-26T06:33:15.995+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-26T06:33:16.089+00:00 | INFO     |   Tips                        : 50
#> 2026-08-26T06:33:16.089+00:00 | INFO     |   Groups parsed               : 5
#> 2026-08-26T06:33:16.090+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-08-26T06:33:16.090+00:00 | INFO     |   Singleton groups            : 0
#> 2026-08-26T06:33:16.090+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-08-26T06:33:16.091+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-08-26T06:33:16.091+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-08-26T06:33:16.091+00:00 | INFO     |   Layout                      : rectangular
#> 2026-08-26T06:33:16.092+00:00 | INFO     |   Timescale                   : disabled
#> 2026-08-26T06:33:16.092+00:00 | INFO     | plot_timetree completed successfully
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
