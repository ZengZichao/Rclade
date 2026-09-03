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
#> 2026-09-03T07:22:13.560+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:22:13.561+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:22:13.561+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:22:13.562+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:22:13.562+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:22:13.563+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:22:13.565+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:22:13.566+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:22:13.566+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:22:13.568+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:22:13.568+00:00 | INFO     | Timer 'input_reading': 4 ms
#> 2026-09-03T07:22:13.569+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:22:13.577+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:22:13.586+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:22:13.587+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:22:13.587+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-03T07:22:13.588+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:22:13.588+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:22:13.593+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:22:13.593+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:22:13.594+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-03T07:22:14.446+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:22:14.453+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:22:14.454+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:22:14.686+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:22:14.719+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:22:14.720+00:00 | INFO     | Timer 'tree_rendering': 265 ms
#> 2026-09-03T07:22:14.720+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:22:14.823+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:22:14.824+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:22:14.824+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:22:14.824+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:22:14.825+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:22:14.825+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:22:14.825+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:22:14.826+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:22:14.826+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:22:14.827+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-03T07:22:15.477+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:22:15.478+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:22:15.478+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:22:15.478+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:22:15.479+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:22:15.479+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:22:15.480+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:22:15.481+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:22:15.481+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:22:15.482+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:22:15.483+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:22:15.483+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:22:15.483+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:22:15.492+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:22:15.492+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:22:15.493+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:22:15.493+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:22:15.493+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:22:15.496+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:22:15.497+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:22:15.497+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-03T07:22:15.498+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:22:15.499+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:22:15.500+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:22:15.628+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:22:15.658+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:22:15.659+00:00 | INFO     | Timer 'tree_rendering': 159 ms
#> 2026-09-03T07:22:15.659+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:22:15.745+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:22:15.745+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:22:15.745+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:22:15.746+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:22:15.746+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:22:15.747+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:22:15.747+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:22:15.747+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:22:15.748+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:22:15.748+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-03T07:22:16.433+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:22:16.433+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:22:16.434+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:22:16.434+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:22:16.434+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:22:16.435+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:22:16.436+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:22:16.436+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:22:16.437+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:22:16.438+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:22:16.438+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:22:16.439+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:22:16.439+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:22:16.447+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:22:16.448+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:22:16.449+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:22:16.449+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:22:16.449+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:22:16.458+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:22:16.459+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:22:16.459+00:00 | INFO     | Timer 'mrca_computation': 10 ms
#> 2026-09-03T07:22:16.460+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:22:16.461+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:22:16.462+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:22:16.585+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:22:16.616+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:22:16.617+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-09-03T07:22:16.617+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:22:16.710+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:22:16.711+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:22:16.711+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:22:16.711+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:22:16.712+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:22:16.712+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:22:16.713+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:22:16.713+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:22:16.713+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:22:16.714+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-03T07:22:16.715+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:22:16.716+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:22:16.716+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:22:16.717+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:22:16.717+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:22:16.717+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:22:16.718+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:22:16.719+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:22:16.719+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:22:16.720+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:22:16.721+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:22:16.721+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:22:16.722+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:22:16.730+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:22:16.730+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:22:16.731+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:22:16.731+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:22:16.732+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:22:16.734+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:22:16.735+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:22:16.735+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-03T07:22:16.736+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:22:16.738+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:22:16.738+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:22:16.865+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:22:16.896+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:22:16.897+00:00 | INFO     | Timer 'tree_rendering': 158 ms
#> 2026-09-03T07:22:16.897+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:22:16.983+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:22:16.984+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:22:16.984+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:22:16.985+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:22:16.985+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:22:16.985+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:22:16.986+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:22:16.986+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:22:16.987+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:22:16.987+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-03T07:22:17.140+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-03T07:22:17.141+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-03T07:22:17.141+00:00 | INFO     | Rank                     : phylum
#> 2026-09-03T07:22:17.142+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-03T07:22:17.142+00:00 | INFO     | Unit                     : auto
#> 2026-09-03T07:22:17.142+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-03T07:22:17.143+00:00 | INFO     | Tips                     : 50
#> 2026-09-03T07:22:17.144+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-03T07:22:17.144+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-03T07:22:17.145+00:00 | INFO     | Input validation passed
#> 2026-09-03T07:22:17.146+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-03T07:22:17.146+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-03T07:22:17.147+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-03T07:22:17.155+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-03T07:22:17.155+00:00 | INFO     | Groups found             : 5
#> 2026-09-03T07:22:17.156+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-03T07:22:17.156+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-03T07:22:17.156+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-03T07:22:17.159+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-03T07:22:17.165+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-03T07:22:17.166+00:00 | INFO     | Timer 'mrca_computation': 9 ms
#> 2026-09-03T07:22:17.166+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-03T07:22:17.168+00:00 | INFO     | Color palette            : viridis
#> 2026-09-03T07:22:17.168+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-03T07:22:17.290+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-03T07:22:17.321+00:00 | INFO     | Clade collapse complete
#> 2026-09-03T07:22:17.322+00:00 | INFO     | Timer 'tree_rendering': 153 ms
#> 2026-09-03T07:22:17.322+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-03T07:22:17.422+00:00 | INFO     |   Tips                        : 50
#> 2026-09-03T07:22:17.422+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-03T07:22:17.423+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-03T07:22:17.423+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-03T07:22:17.423+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-03T07:22:17.424+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-03T07:22:17.424+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-03T07:22:17.425+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-03T07:22:17.425+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-03T07:22:17.425+00:00 | INFO     | plot_timetree completed successfully
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
