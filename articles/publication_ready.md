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
#> 2026-08-22T16:22:47.960+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:22:47.961+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:22:47.962+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:22:47.962+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:22:47.962+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:22:47.963+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:22:47.965+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:22:47.965+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:22:47.966+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:22:47.966+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:22:47.967+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:22:47.968+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:22:47.968+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:22:47.977+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:22:47.978+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:22:47.978+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-22T16:22:47.979+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:22:47.979+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:22:47.983+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:22:47.983+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:22:47.984+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-22T16:22:48.801+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:22:48.809+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:22:48.810+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:22:49.015+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:22:49.045+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:22:49.045+00:00 | INFO     | Timer 'tree_rendering': 235 ms
#> 2026-08-22T16:22:49.046+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:22:49.142+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:22:49.142+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:22:49.143+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:22:49.143+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:22:49.144+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:22:49.144+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:22:49.144+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T16:22:49.719+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:22:49.719+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:22:49.720+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:22:49.720+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:22:49.721+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:22:49.721+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:22:49.722+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:22:49.723+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:22:49.723+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:22:49.724+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:22:49.724+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:22:49.725+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:22:49.725+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:22:49.733+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:22:49.733+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:22:49.734+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T16:22:49.734+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:22:49.740+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:22:49.743+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:22:49.743+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:22:49.744+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-22T16:22:49.745+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:22:49.746+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:22:49.746+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:22:49.863+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:22:49.892+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:22:49.892+00:00 | INFO     | Timer 'tree_rendering': 145 ms
#> 2026-08-22T16:22:49.892+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:22:50.018+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:22:50.019+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:22:50.019+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:22:50.020+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:22:50.020+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:22:50.021+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:22:50.021+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T16:22:50.644+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:22:50.645+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:22:50.645+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:22:50.645+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:22:50.646+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:22:50.646+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:22:50.647+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:22:50.648+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:22:50.648+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:22:50.649+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:22:50.650+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:22:50.650+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:22:50.650+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:22:50.659+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:22:50.659+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:22:50.659+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T16:22:50.660+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:22:50.660+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:22:50.663+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:22:50.663+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:22:50.664+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T16:22:50.664+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:22:50.666+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:22:50.666+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:22:50.787+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:22:50.816+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:22:50.816+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-08-22T16:22:50.817+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:22:50.901+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:22:50.901+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:22:50.901+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:22:50.902+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:22:50.902+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:22:50.903+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:22:50.903+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-22T16:22:50.905+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:22:50.905+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:22:50.905+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:22:50.906+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:22:50.906+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:22:50.907+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:22:50.908+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:22:50.908+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:22:50.908+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:22:50.909+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:22:50.910+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:22:50.910+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:22:50.911+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:22:50.924+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:22:50.924+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:22:50.924+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-22T16:22:50.925+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:22:50.925+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:22:50.928+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:22:50.928+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:22:50.929+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-22T16:22:50.929+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:22:50.931+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:22:50.931+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:22:51.048+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:22:51.076+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:22:51.077+00:00 | INFO     | Timer 'tree_rendering': 145 ms
#> 2026-08-22T16:22:51.077+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:22:51.164+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:22:51.165+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:22:51.165+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:22:51.166+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:22:51.166+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:22:51.166+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:22:51.167+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T16:22:51.313+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:22:51.314+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:22:51.314+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:22:51.315+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:22:51.315+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:22:51.316+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:22:51.317+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:22:51.317+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:22:51.317+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:22:51.318+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:22:51.319+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:22:51.319+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:22:51.320+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:22:51.328+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:22:51.328+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:22:51.329+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T16:22:51.329+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:22:51.330+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:22:51.332+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:22:51.333+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:22:51.333+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T16:22:51.334+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:22:51.335+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:22:51.336+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:22:51.457+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:22:51.485+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:22:51.486+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-08-22T16:22:51.486+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:22:51.580+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:22:51.580+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:22:51.581+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:22:51.581+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:22:51.581+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:22:51.582+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:22:51.582+00:00 | INFO     | plot_timetree completed successfully
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
