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
#> 2026-08-21T11:08:44.494+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:08:44.494+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:08:44.495+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:08:44.495+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:08:44.496+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:08:44.496+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:08:44.498+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:08:44.498+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:08:44.499+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:08:44.500+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:08:44.500+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:08:44.501+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:08:44.501+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:08:44.510+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:08:44.510+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:08:44.511+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-21T11:08:44.511+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:08:44.512+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:08:44.515+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:08:44.516+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:08:44.516+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-21T11:08:45.352+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:08:45.359+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:08:45.360+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:08:45.565+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:08:45.595+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:08:45.595+00:00 | INFO     | Timer 'tree_rendering': 235 ms
#> 2026-08-21T11:08:45.596+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:08:45.692+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:08:45.693+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:08:45.693+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:08:45.694+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:08:45.694+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:08:45.695+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:08:45.695+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T11:08:46.344+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:08:46.344+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:08:46.345+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:08:46.345+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:08:46.345+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:08:46.346+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:08:46.347+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:08:46.347+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:08:46.348+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:08:46.349+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:08:46.349+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:08:46.349+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:08:46.350+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:08:46.358+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:08:46.358+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:08:46.358+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T11:08:46.359+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:08:46.365+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:08:46.368+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:08:46.368+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:08:46.369+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T11:08:46.369+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:08:46.371+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:08:46.371+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:08:46.488+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:08:46.517+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:08:46.517+00:00 | INFO     | Timer 'tree_rendering': 146 ms
#> 2026-08-21T11:08:46.518+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:08:46.647+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:08:46.647+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:08:46.648+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:08:46.648+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:08:46.649+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:08:46.649+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:08:46.649+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T11:08:47.273+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:08:47.273+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:08:47.273+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:08:47.274+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:08:47.274+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:08:47.275+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:08:47.276+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:08:47.276+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:08:47.277+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:08:47.278+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:08:47.278+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:08:47.278+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:08:47.279+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:08:47.287+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:08:47.287+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:08:47.288+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T11:08:47.288+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:08:47.289+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:08:47.291+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:08:47.292+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:08:47.292+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T11:08:47.293+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:08:47.294+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:08:47.295+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:08:47.417+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:08:47.446+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:08:47.446+00:00 | INFO     | Timer 'tree_rendering': 151 ms
#> 2026-08-21T11:08:47.447+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:08:47.531+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:08:47.531+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:08:47.531+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:08:47.532+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:08:47.532+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:08:47.533+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:08:47.533+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T11:08:47.535+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:08:47.535+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:08:47.535+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:08:47.536+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:08:47.536+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:08:47.537+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:08:47.538+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:08:47.538+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:08:47.538+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:08:47.539+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:08:47.540+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:08:47.540+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:08:47.541+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:08:47.554+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:08:47.554+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:08:47.555+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-21T11:08:47.555+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:08:47.556+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:08:47.558+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:08:47.559+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:08:47.559+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T11:08:47.560+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:08:47.561+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:08:47.562+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:08:47.679+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:08:47.708+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:08:47.709+00:00 | INFO     | Timer 'tree_rendering': 147 ms
#> 2026-08-21T11:08:47.709+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:08:47.797+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:08:47.798+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:08:47.798+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:08:47.799+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:08:47.799+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:08:47.799+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:08:47.800+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T11:08:47.948+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:08:47.948+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:08:47.948+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:08:47.949+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:08:47.949+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:08:47.950+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:08:47.951+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:08:47.951+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:08:47.951+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:08:47.952+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:08:47.953+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:08:47.953+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:08:47.954+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:08:47.962+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:08:47.962+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:08:47.963+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T11:08:47.963+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:08:47.963+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:08:47.966+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:08:47.966+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:08:47.967+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T11:08:47.968+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:08:47.969+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:08:47.969+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:08:48.092+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:08:48.120+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:08:48.121+00:00 | INFO     | Timer 'tree_rendering': 151 ms
#> 2026-08-21T11:08:48.121+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:08:48.216+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:08:48.216+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:08:48.217+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:08:48.217+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:08:48.217+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:08:48.218+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:08:48.218+00:00 | INFO     | plot_timetree completed successfully
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
