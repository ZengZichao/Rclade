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
#> 2026-08-21T11:05:00.998+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:05:00.999+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:05:00.999+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:05:00.999+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:05:00.1000+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:05:01.001+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:05:01.002+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:05:01.003+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:05:01.003+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:05:01.004+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:05:01.004+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:05:01.005+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:05:01.005+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:05:01.014+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:05:01.015+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:05:01.015+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-21T11:05:01.016+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:05:01.016+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:05:01.020+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:05:01.020+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:05:01.021+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-21T11:05:01.843+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:05:01.850+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:05:01.851+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:05:02.058+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:05:02.088+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:05:02.089+00:00 | INFO     | Timer 'tree_rendering': 237 ms
#> 2026-08-21T11:05:02.089+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:05:02.185+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:05:02.185+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:05:02.185+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:05:02.186+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:05:02.186+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:05:02.187+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:05:02.187+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T11:05:02.892+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:05:02.892+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:05:02.892+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:05:02.893+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:05:02.893+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:05:02.894+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:05:02.895+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:05:02.895+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:05:02.895+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:05:02.896+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:05:02.897+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:05:02.897+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:05:02.898+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:05:02.906+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:05:02.906+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:05:02.906+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T11:05:02.907+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:05:02.913+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:05:02.915+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:05:02.916+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:05:02.916+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T11:05:02.917+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:05:02.918+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:05:02.919+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:05:03.035+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:05:03.063+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:05:03.064+00:00 | INFO     | Timer 'tree_rendering': 144 ms
#> 2026-08-21T11:05:03.064+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:05:03.189+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:05:03.189+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:05:03.190+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:05:03.190+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:05:03.191+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:05:03.191+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:05:03.191+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T11:05:03.814+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:05:03.815+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:05:03.815+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:05:03.816+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:05:03.816+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:05:03.817+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:05:03.818+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:05:03.818+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:05:03.818+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:05:03.819+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:05:03.820+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:05:03.820+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:05:03.821+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:05:03.829+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:05:03.829+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:05:03.830+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T11:05:03.830+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:05:03.830+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:05:03.833+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:05:03.834+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:05:03.834+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T11:05:03.835+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:05:03.836+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:05:03.837+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:05:03.957+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:05:03.986+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:05:03.986+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-08-21T11:05:03.987+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:05:04.069+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:05:04.070+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:05:04.070+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:05:04.071+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:05:04.071+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:05:04.071+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:05:04.072+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T11:05:04.073+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:05:04.074+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:05:04.074+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:05:04.075+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:05:04.075+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:05:04.075+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:05:04.076+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:05:04.077+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:05:04.077+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:05:04.078+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:05:04.078+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:05:04.079+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:05:04.079+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:05:04.092+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:05:04.093+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:05:04.093+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-21T11:05:04.093+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:05:04.094+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:05:04.096+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:05:04.097+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:05:04.097+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T11:05:04.098+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:05:04.099+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:05:04.100+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:05:04.215+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:05:04.244+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:05:04.245+00:00 | INFO     | Timer 'tree_rendering': 144 ms
#> 2026-08-21T11:05:04.245+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:05:04.332+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:05:04.333+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:05:04.333+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:05:04.333+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:05:04.334+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:05:04.334+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:05:04.334+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T11:05:04.482+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:05:04.483+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:05:04.483+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:05:04.483+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:05:04.484+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:05:04.484+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:05:04.485+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:05:04.486+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:05:04.486+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:05:04.487+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:05:04.488+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:05:04.488+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:05:04.488+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:05:04.497+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:05:04.497+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:05:04.497+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T11:05:04.498+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:05:04.498+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:05:04.501+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:05:04.501+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:05:04.502+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T11:05:04.502+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:05:04.504+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:05:04.504+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:05:04.624+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:05:04.653+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:05:04.654+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-08-21T11:05:04.654+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:05:04.747+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:05:04.748+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:05:04.748+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:05:04.749+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:05:04.749+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:05:04.749+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:05:04.750+00:00 | INFO     | plot_timetree completed successfully
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
