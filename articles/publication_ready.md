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
#> 2026-09-15T16:10:23.128+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:10:23.129+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:10:23.129+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:10:23.129+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:10:23.130+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:10:23.131+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:10:23.132+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:10:23.133+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:10:23.133+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:10:23.134+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:10:23.135+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:10:23.135+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:10:23.136+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:10:23.145+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:10:23.145+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:10:23.145+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-09-15T16:10:23.146+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:10:23.146+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:10:23.150+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:10:23.151+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:10:23.151+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-09-15T16:10:24.001+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:10:24.009+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:10:24.010+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:10:24.223+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:10:24.254+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:10:24.254+00:00 | INFO     | Timer 'tree_rendering': 244 ms
#> 2026-09-15T16:10:24.255+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:10:24.355+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:10:24.355+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:10:24.355+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:10:24.356+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:10:24.356+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:10:24.357+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:10:24.357+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:10:24.357+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:10:24.358+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:10:24.358+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-15T16:10:24.994+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:10:24.995+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:10:24.995+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:10:24.996+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:10:24.996+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:10:24.996+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:10:24.998+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:10:24.998+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:10:24.998+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:10:24.999+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:10:24.1000+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:10:25.000+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:10:25.001+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:10:25.009+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:10:25.009+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:10:25.010+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-15T16:10:25.010+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:10:25.010+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:10:25.020+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:10:25.020+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:10:25.021+00:00 | INFO     | Timer 'mrca_computation': 10 ms
#> 2026-09-15T16:10:25.021+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:10:25.023+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:10:25.023+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:10:25.143+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:10:25.173+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:10:25.174+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-09-15T16:10:25.174+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:10:25.308+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:10:25.308+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:10:25.309+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:10:25.309+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:10:25.309+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:10:25.310+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:10:25.310+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:10:25.311+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:10:25.311+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:10:25.311+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-15T16:10:25.965+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:10:25.966+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:10:25.966+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:10:25.967+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:10:25.967+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:10:25.967+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:10:25.969+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:10:25.969+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:10:25.969+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:10:25.970+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:10:25.971+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:10:25.971+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:10:25.972+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:10:25.980+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:10:25.980+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:10:25.981+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-15T16:10:25.981+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:10:25.981+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:10:25.984+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:10:25.984+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:10:25.985+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-09-15T16:10:25.986+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:10:25.987+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:10:25.987+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:10:26.110+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:10:26.140+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:10:26.140+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-09-15T16:10:26.141+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:10:26.225+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:10:26.226+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:10:26.226+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:10:26.227+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:10:26.227+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:10:26.227+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:10:26.228+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:10:26.228+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:10:26.228+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:10:26.229+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-09-15T16:10:26.230+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:10:26.231+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:10:26.231+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:10:26.232+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:10:26.232+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:10:26.232+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:10:26.234+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:10:26.234+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:10:26.234+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:10:26.235+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:10:26.236+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:10:26.236+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:10:26.237+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:10:26.251+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:10:26.251+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:10:26.252+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-09-15T16:10:26.252+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:10:26.253+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:10:26.255+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:10:26.256+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:10:26.256+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-15T16:10:26.257+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:10:26.258+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:10:26.259+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:10:26.379+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:10:26.409+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:10:26.409+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-09-15T16:10:26.410+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:10:26.500+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:10:26.501+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:10:26.501+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:10:26.502+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:10:26.502+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:10:26.502+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:10:26.503+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:10:26.503+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:10:26.504+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:10:26.504+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-09-15T16:10:26.656+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-09-15T16:10:26.656+00:00 | INFO     | Tree input               : phylo object
#> 2026-09-15T16:10:26.656+00:00 | INFO     | Rank                     : phylum
#> 2026-09-15T16:10:26.657+00:00 | INFO     | Layout                   : rectangular
#> 2026-09-15T16:10:26.657+00:00 | INFO     | Unit                     : auto
#> 2026-09-15T16:10:26.658+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-09-15T16:10:26.659+00:00 | INFO     | Tips                     : 50
#> 2026-09-15T16:10:26.659+00:00 | INFO     | Internal nodes           : 49
#> 2026-09-15T16:10:26.660+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-09-15T16:10:26.661+00:00 | INFO     | Input validation passed
#> 2026-09-15T16:10:26.661+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-09-15T16:10:26.661+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-09-15T16:10:26.662+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-09-15T16:10:26.670+00:00 | INFO     | Detected format          : GTDB
#> 2026-09-15T16:10:26.671+00:00 | INFO     | Groups found             : 5
#> 2026-09-15T16:10:26.671+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-09-15T16:10:26.672+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-09-15T16:10:26.672+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-09-15T16:10:26.675+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-09-15T16:10:26.675+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-09-15T16:10:26.676+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-09-15T16:10:26.677+00:00 | INFO     | Step 4/7: Color generation
#> 2026-09-15T16:10:26.678+00:00 | INFO     | Color palette            : viridis
#> 2026-09-15T16:10:26.679+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-09-15T16:10:26.804+00:00 | INFO     | Collapsing 5 clades...
#> 2026-09-15T16:10:26.835+00:00 | INFO     | Clade collapse complete
#> 2026-09-15T16:10:26.836+00:00 | INFO     | Timer 'tree_rendering': 157 ms
#> 2026-09-15T16:10:26.837+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-09-15T16:10:26.934+00:00 | INFO     |   Tips                        : 50
#> 2026-09-15T16:10:26.934+00:00 | INFO     |   Groups parsed               : 5
#> 2026-09-15T16:10:26.934+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-09-15T16:10:26.935+00:00 | INFO     |   Singleton groups            : 0
#> 2026-09-15T16:10:26.935+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-09-15T16:10:26.936+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-09-15T16:10:26.936+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-09-15T16:10:26.936+00:00 | INFO     |   Layout                      : rectangular
#> 2026-09-15T16:10:26.937+00:00 | INFO     |   Timescale                   : disabled
#> 2026-09-15T16:10:26.937+00:00 | INFO     | plot_timetree completed successfully
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
