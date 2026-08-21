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
#> 2026-08-21T13:21:26.370+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:21:26.371+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:21:26.372+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:21:26.372+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:21:26.372+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:21:26.373+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:21:26.375+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:21:26.375+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:21:26.375+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:21:26.376+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:21:26.377+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T13:21:26.377+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:21:26.378+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:21:26.386+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:21:26.386+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:21:26.387+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T13:21:26.387+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:21:26.387+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:21:26.391+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:21:26.391+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:21:26.392+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T13:21:27.245+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:21:27.253+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:21:27.254+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:21:27.453+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:21:27.481+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:21:27.482+00:00 | INFO     | Timer 'tree_rendering': 227 ms
#> 2026-08-21T13:21:27.482+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:21:27.573+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:21:27.573+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:21:27.574+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:21:27.574+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:21:27.574+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:21:27.575+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:21:27.575+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T13:21:28.205+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:21:28.205+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:21:28.206+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:21:28.206+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:21:28.207+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:21:28.207+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:21:28.208+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:21:28.209+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:21:28.209+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:21:28.210+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:21:28.211+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T13:21:28.211+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:21:28.211+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:21:28.220+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:21:28.220+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:21:28.221+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T13:21:28.221+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:21:28.229+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:21:28.232+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:21:28.232+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:21:28.233+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T13:21:28.233+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:21:28.235+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:21:28.236+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:21:28.346+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:21:28.373+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:21:28.374+00:00 | INFO     | Timer 'tree_rendering': 138 ms
#> 2026-08-21T13:21:28.374+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:21:28.504+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:21:28.505+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:21:28.505+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:21:28.505+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:21:28.506+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:21:28.506+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:21:28.506+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T13:21:29.079+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:21:29.079+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:21:29.080+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:21:29.080+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:21:29.080+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:21:29.081+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:21:29.082+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:21:29.082+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:21:29.082+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:21:29.083+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:21:29.084+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T13:21:29.084+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:21:29.084+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:21:29.092+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:21:29.092+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:21:29.093+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T13:21:29.093+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:21:29.093+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:21:29.096+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:21:29.096+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:21:29.097+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T13:21:29.097+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:21:29.099+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:21:29.099+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:21:29.213+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:21:29.240+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:21:29.240+00:00 | INFO     | Timer 'tree_rendering': 141 ms
#> 2026-08-21T13:21:29.241+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:21:29.318+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:21:29.318+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:21:29.319+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:21:29.319+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:21:29.319+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:21:29.320+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:21:29.320+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T13:21:29.322+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:21:29.322+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:21:29.322+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:21:29.323+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:21:29.323+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:21:29.323+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:21:29.324+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:21:29.325+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:21:29.325+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:21:29.326+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:21:29.326+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T13:21:29.327+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:21:29.327+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:21:29.341+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:21:29.341+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:21:29.341+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-21T13:21:29.342+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:21:29.342+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:21:29.345+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:21:29.345+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:21:29.345+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T13:21:29.346+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:21:29.347+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:21:29.348+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:21:29.456+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:21:29.483+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:21:29.484+00:00 | INFO     | Timer 'tree_rendering': 135 ms
#> 2026-08-21T13:21:29.484+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:21:29.566+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:21:29.567+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:21:29.567+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:21:29.567+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:21:29.568+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:21:29.568+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:21:29.568+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T13:21:29.701+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:21:29.701+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:21:29.702+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:21:29.702+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:21:29.702+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:21:29.703+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:21:29.704+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:21:29.704+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:21:29.704+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:21:29.705+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:21:29.706+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T13:21:29.706+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:21:29.706+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:21:29.714+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:21:29.715+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:21:29.715+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T13:21:29.715+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:21:29.716+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:21:29.718+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:21:29.718+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:21:29.719+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T13:21:29.719+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:21:29.721+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:21:29.721+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:21:29.835+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:21:29.862+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:21:29.863+00:00 | INFO     | Timer 'tree_rendering': 141 ms
#> 2026-08-21T13:21:29.863+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:21:29.951+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:21:29.952+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:21:29.952+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:21:29.952+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:21:29.952+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:21:29.953+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:21:29.953+00:00 | INFO     | plot_timetree completed successfully
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
