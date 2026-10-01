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
#> 2026-10-01T05:49:10.825+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-01T05:49:10.826+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-01T05:49:10.827+00:00 | INFO     | Rank                     : phylum
#> 2026-10-01T05:49:10.827+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-01T05:49:10.827+00:00 | INFO     | Unit                     : auto
#> 2026-10-01T05:49:10.828+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-01T05:49:10.830+00:00 | INFO     | Tips                     : 50
#> 2026-10-01T05:49:10.830+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-01T05:49:10.830+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-01T05:49:10.831+00:00 | INFO     | Input validation passed
#> 2026-10-01T05:49:10.832+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-10-01T05:49:10.832+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-01T05:49:10.833+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-01T05:49:10.840+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-01T05:49:10.841+00:00 | INFO     | Groups found             : 5
#> 2026-10-01T05:49:10.841+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-10-01T05:49:10.841+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-01T05:49:10.842+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-01T05:49:10.845+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-01T05:49:10.846+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-01T05:49:10.846+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-10-01T05:49:11.609+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-01T05:49:11.616+00:00 | INFO     | Color palette            : viridis
#> 2026-10-01T05:49:11.617+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-01T05:49:11.810+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-01T05:49:11.838+00:00 | INFO     | Clade collapse complete
#> 2026-10-01T05:49:11.839+00:00 | INFO     | Timer 'tree_rendering': 222 ms
#> 2026-10-01T05:49:11.840+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-01T05:49:11.926+00:00 | INFO     |   Tips                        : 50
#> 2026-10-01T05:49:11.926+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-01T05:49:11.926+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-01T05:49:11.927+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-01T05:49:11.927+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-01T05:49:11.927+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-01T05:49:11.928+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-01T05:49:11.928+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-01T05:49:11.928+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-01T05:49:11.929+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-10-01T05:49:12.469+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-01T05:49:12.470+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-01T05:49:12.470+00:00 | INFO     | Rank                     : phylum
#> 2026-10-01T05:49:12.470+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-01T05:49:12.471+00:00 | INFO     | Unit                     : auto
#> 2026-10-01T05:49:12.471+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-01T05:49:12.472+00:00 | INFO     | Tips                     : 50
#> 2026-10-01T05:49:12.472+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-01T05:49:12.472+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-01T05:49:12.473+00:00 | INFO     | Input validation passed
#> 2026-10-01T05:49:12.474+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-10-01T05:49:12.474+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-01T05:49:12.475+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-01T05:49:12.482+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-01T05:49:12.482+00:00 | INFO     | Groups found             : 5
#> 2026-10-01T05:49:12.482+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-10-01T05:49:12.483+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-01T05:49:12.483+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-01T05:49:12.492+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-01T05:49:12.493+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-01T05:49:12.493+00:00 | INFO     | Timer 'mrca_computation': 10 ms
#> 2026-10-01T05:49:12.494+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-01T05:49:12.495+00:00 | INFO     | Color palette            : viridis
#> 2026-10-01T05:49:12.496+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-01T05:49:12.602+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-01T05:49:12.629+00:00 | INFO     | Clade collapse complete
#> 2026-10-01T05:49:12.630+00:00 | INFO     | Timer 'tree_rendering': 134 ms
#> 2026-10-01T05:49:12.630+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-01T05:49:12.753+00:00 | INFO     |   Tips                        : 50
#> 2026-10-01T05:49:12.753+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-01T05:49:12.754+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-01T05:49:12.754+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-01T05:49:12.754+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-01T05:49:12.755+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-01T05:49:12.755+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-01T05:49:12.755+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-01T05:49:12.755+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-01T05:49:12.756+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-10-01T05:49:13.270+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-01T05:49:13.270+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-01T05:49:13.270+00:00 | INFO     | Rank                     : phylum
#> 2026-10-01T05:49:13.271+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-01T05:49:13.271+00:00 | INFO     | Unit                     : auto
#> 2026-10-01T05:49:13.271+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-01T05:49:13.272+00:00 | INFO     | Tips                     : 50
#> 2026-10-01T05:49:13.273+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-01T05:49:13.273+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-01T05:49:13.274+00:00 | INFO     | Input validation passed
#> 2026-10-01T05:49:13.274+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-10-01T05:49:13.275+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-01T05:49:13.275+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-01T05:49:13.282+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-01T05:49:13.283+00:00 | INFO     | Groups found             : 5
#> 2026-10-01T05:49:13.283+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-10-01T05:49:13.283+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-01T05:49:13.284+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-01T05:49:13.286+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-01T05:49:13.287+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-01T05:49:13.287+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-10-01T05:49:13.288+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-01T05:49:13.289+00:00 | INFO     | Color palette            : viridis
#> 2026-10-01T05:49:13.290+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-01T05:49:13.401+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-01T05:49:13.428+00:00 | INFO     | Clade collapse complete
#> 2026-10-01T05:49:13.429+00:00 | INFO     | Timer 'tree_rendering': 139 ms
#> 2026-10-01T05:49:13.429+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-01T05:49:13.504+00:00 | INFO     |   Tips                        : 50
#> 2026-10-01T05:49:13.504+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-01T05:49:13.505+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-01T05:49:13.505+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-01T05:49:13.505+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-01T05:49:13.506+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-01T05:49:13.506+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-01T05:49:13.506+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-01T05:49:13.507+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-01T05:49:13.507+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-10-01T05:49:13.508+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-01T05:49:13.508+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-01T05:49:13.509+00:00 | INFO     | Rank                     : phylum
#> 2026-10-01T05:49:13.509+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-01T05:49:13.509+00:00 | INFO     | Unit                     : auto
#> 2026-10-01T05:49:13.510+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-01T05:49:13.511+00:00 | INFO     | Tips                     : 50
#> 2026-10-01T05:49:13.511+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-01T05:49:13.511+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-01T05:49:13.512+00:00 | INFO     | Input validation passed
#> 2026-10-01T05:49:13.513+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-10-01T05:49:13.513+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-01T05:49:13.513+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-01T05:49:13.525+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-01T05:49:13.526+00:00 | INFO     | Groups found             : 5
#> 2026-10-01T05:49:13.526+00:00 | INFO     | Timer 'taxonomy_parsing': 13 ms
#> 2026-10-01T05:49:13.526+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-01T05:49:13.527+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-01T05:49:13.529+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-01T05:49:13.529+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-01T05:49:13.530+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-10-01T05:49:13.530+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-01T05:49:13.532+00:00 | INFO     | Color palette            : viridis
#> 2026-10-01T05:49:13.532+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-01T05:49:13.634+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-01T05:49:13.661+00:00 | INFO     | Clade collapse complete
#> 2026-10-01T05:49:13.661+00:00 | INFO     | Timer 'tree_rendering': 129 ms
#> 2026-10-01T05:49:13.662+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-01T05:49:13.740+00:00 | INFO     |   Tips                        : 50
#> 2026-10-01T05:49:13.740+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-01T05:49:13.740+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-01T05:49:13.741+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-01T05:49:13.741+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-01T05:49:13.741+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-01T05:49:13.742+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-01T05:49:13.742+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-01T05:49:13.742+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-01T05:49:13.742+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-10-01T05:49:13.850+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-10-01T05:49:13.850+00:00 | INFO     | Tree input               : phylo object
#> 2026-10-01T05:49:13.851+00:00 | INFO     | Rank                     : phylum
#> 2026-10-01T05:49:13.851+00:00 | INFO     | Layout                   : rectangular
#> 2026-10-01T05:49:13.851+00:00 | INFO     | Unit                     : auto
#> 2026-10-01T05:49:13.852+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-10-01T05:49:13.852+00:00 | INFO     | Tips                     : 50
#> 2026-10-01T05:49:13.853+00:00 | INFO     | Internal nodes           : 49
#> 2026-10-01T05:49:13.853+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-10-01T05:49:13.854+00:00 | INFO     | Input validation passed
#> 2026-10-01T05:49:13.854+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-10-01T05:49:13.855+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-10-01T05:49:13.855+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-10-01T05:49:13.862+00:00 | INFO     | Detected format          : GTDB
#> 2026-10-01T05:49:13.863+00:00 | INFO     | Groups found             : 5
#> 2026-10-01T05:49:13.863+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-10-01T05:49:13.863+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-10-01T05:49:13.864+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-10-01T05:49:13.866+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-10-01T05:49:13.867+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-10-01T05:49:13.867+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-10-01T05:49:13.868+00:00 | INFO     | Step 4/7: Color generation
#> 2026-10-01T05:49:13.869+00:00 | INFO     | Color palette            : viridis
#> 2026-10-01T05:49:13.869+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-10-01T05:49:13.979+00:00 | INFO     | Collapsing 5 clades...
#> 2026-10-01T05:49:14.006+00:00 | INFO     | Clade collapse complete
#> 2026-10-01T05:49:14.007+00:00 | INFO     | Timer 'tree_rendering': 137 ms
#> 2026-10-01T05:49:14.007+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-10-01T05:49:14.091+00:00 | INFO     |   Tips                        : 50
#> 2026-10-01T05:49:14.091+00:00 | INFO     |   Groups parsed               : 5
#> 2026-10-01T05:49:14.092+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-10-01T05:49:14.092+00:00 | INFO     |   Singleton groups            : 0
#> 2026-10-01T05:49:14.092+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-10-01T05:49:14.093+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-10-01T05:49:14.093+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-10-01T05:49:14.093+00:00 | INFO     |   Layout                      : rectangular
#> 2026-10-01T05:49:14.093+00:00 | INFO     |   Timescale                   : disabled
#> 2026-10-01T05:49:14.094+00:00 | INFO     | plot_timetree completed successfully
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
