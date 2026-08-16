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
#> 2026-08-16T06:54:56.762+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T06:54:56.763+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T06:54:56.763+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T06:54:56.764+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T06:54:56.764+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T06:54:56.766+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T06:54:56.775+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T06:54:56.775+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T06:54:56.775+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T06:54:56.776+00:00 | INFO     | Input validation passed
#> 2026-08-16T06:54:56.777+00:00 | INFO     | Timer 'input_reading': 11 ms
#> 2026-08-16T06:54:56.778+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T06:54:56.778+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T06:54:56.787+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T06:54:56.787+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T06:54:56.788+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-16T06:54:56.788+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T06:54:56.789+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T06:54:56.793+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T06:54:56.793+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T06:54:56.793+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-16T06:54:57.648+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T06:54:57.656+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T06:54:57.657+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T06:54:57.909+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T06:54:57.957+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T06:54:57.958+00:00 | INFO     | Timer 'tree_rendering': 300 ms
#> 2026-08-16T06:54:57.959+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T06:54:58.067+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T06:54:58.068+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T06:54:58.068+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T06:54:58.069+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T06:54:58.069+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T06:54:58.070+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T06:54:58.070+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T06:54:58.697+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T06:54:58.697+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T06:54:58.698+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T06:54:58.698+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T06:54:58.699+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T06:54:58.699+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T06:54:58.700+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T06:54:58.701+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T06:54:58.701+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T06:54:58.702+00:00 | INFO     | Input validation passed
#> 2026-08-16T06:54:58.702+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T06:54:58.703+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T06:54:58.703+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T06:54:58.711+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T06:54:58.712+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T06:54:58.712+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T06:54:58.713+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T06:54:58.713+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T06:54:58.716+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T06:54:58.717+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T06:54:58.717+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-16T06:54:58.718+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T06:54:58.720+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T06:54:58.720+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T06:54:58.867+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T06:54:58.907+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T06:54:58.908+00:00 | INFO     | Timer 'tree_rendering': 187 ms
#> 2026-08-16T06:54:58.908+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T06:54:59.006+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T06:54:59.006+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T06:54:59.007+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T06:54:59.007+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T06:54:59.008+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T06:54:59.008+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T06:54:59.008+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T06:54:59.736+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T06:54:59.737+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T06:54:59.737+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T06:54:59.738+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T06:54:59.738+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T06:54:59.739+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T06:54:59.740+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T06:54:59.740+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T06:54:59.741+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T06:54:59.742+00:00 | INFO     | Input validation passed
#> 2026-08-16T06:54:59.742+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T06:54:59.743+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T06:54:59.743+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T06:54:59.751+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T06:54:59.752+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T06:54:59.753+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-16T06:54:59.753+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T06:54:59.754+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T06:54:59.763+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T06:54:59.764+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T06:54:59.764+00:00 | INFO     | Timer 'mrca_computation': 11 ms
#> 2026-08-16T06:54:59.765+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T06:54:59.767+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T06:54:59.767+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T06:54:59.911+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T06:54:59.951+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T06:54:59.952+00:00 | INFO     | Timer 'tree_rendering': 184 ms
#> 2026-08-16T06:54:59.952+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T06:55:00.063+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T06:55:00.064+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T06:55:00.064+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T06:55:00.065+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T06:55:00.065+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T06:55:00.066+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T06:55:00.066+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-16T06:55:00.068+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T06:55:00.069+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T06:55:00.069+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T06:55:00.069+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T06:55:00.070+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T06:55:00.070+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T06:55:00.072+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T06:55:00.072+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T06:55:00.072+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T06:55:00.074+00:00 | INFO     | Input validation passed
#> 2026-08-16T06:55:00.074+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T06:55:00.074+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T06:55:00.075+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T06:55:00.084+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T06:55:00.085+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T06:55:00.085+00:00 | INFO     | Timer 'taxonomy_parsing': 11 ms
#> 2026-08-16T06:55:00.086+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T06:55:00.087+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T06:55:00.090+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T06:55:00.091+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T06:55:00.091+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-16T06:55:00.092+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T06:55:00.094+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T06:55:00.095+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T06:55:00.246+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T06:55:00.288+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T06:55:00.288+00:00 | INFO     | Timer 'tree_rendering': 193 ms
#> 2026-08-16T06:55:00.289+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T06:55:00.392+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T06:55:00.393+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T06:55:00.393+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T06:55:00.393+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T06:55:00.394+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T06:55:00.394+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T06:55:00.395+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T06:55:00.549+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T06:55:00.549+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T06:55:00.550+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T06:55:00.550+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T06:55:00.551+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T06:55:00.551+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T06:55:00.552+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T06:55:00.553+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T06:55:00.553+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T06:55:00.554+00:00 | INFO     | Input validation passed
#> 2026-08-16T06:55:00.555+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T06:55:00.555+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T06:55:00.556+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T06:55:00.564+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T06:55:00.565+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T06:55:00.566+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-16T06:55:00.566+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T06:55:00.567+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T06:55:00.570+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T06:55:00.571+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T06:55:00.579+00:00 | INFO     | Timer 'mrca_computation': 12 ms
#> 2026-08-16T06:55:00.580+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T06:55:00.582+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T06:55:00.582+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T06:55:00.722+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T06:55:00.762+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T06:55:00.763+00:00 | INFO     | Timer 'tree_rendering': 180 ms
#> 2026-08-16T06:55:00.763+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T06:55:00.872+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T06:55:00.872+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T06:55:00.873+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T06:55:00.873+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T06:55:00.874+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T06:55:00.874+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T06:55:00.874+00:00 | INFO     | plot_timetree completed successfully
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
Chronostratigraphic Chart 2023/02 (<https://stratigraphy.org/chart>).
