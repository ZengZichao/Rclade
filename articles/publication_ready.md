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
#> 2026-08-16T14:01:42.386+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T14:01:42.387+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T14:01:42.388+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T14:01:42.388+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T14:01:42.389+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T14:01:42.389+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T14:01:42.391+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T14:01:42.391+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T14:01:42.392+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T14:01:42.393+00:00 | INFO     | Input validation passed
#> 2026-08-16T14:01:42.393+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T14:01:42.394+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T14:01:42.394+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T14:01:42.403+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T14:01:42.404+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T14:01:42.404+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-16T14:01:42.405+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T14:01:42.405+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T14:01:42.409+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T14:01:42.409+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T14:01:42.410+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-16T14:01:43.270+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T14:01:43.277+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T14:01:43.278+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T14:01:43.490+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T14:01:43.522+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T14:01:43.523+00:00 | INFO     | Timer 'tree_rendering': 244 ms
#> 2026-08-16T14:01:43.523+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T14:01:43.628+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T14:01:43.628+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T14:01:43.629+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T14:01:43.629+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T14:01:43.630+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T14:01:43.630+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T14:01:43.631+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T14:01:44.286+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T14:01:44.287+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T14:01:44.287+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T14:01:44.287+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T14:01:44.288+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T14:01:44.289+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T14:01:44.290+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T14:01:44.290+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T14:01:44.291+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T14:01:44.292+00:00 | INFO     | Input validation passed
#> 2026-08-16T14:01:44.292+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T14:01:44.292+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T14:01:44.293+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T14:01:44.301+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T14:01:44.301+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T14:01:44.302+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T14:01:44.302+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T14:01:44.308+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T14:01:44.311+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T14:01:44.312+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T14:01:44.312+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-16T14:01:44.313+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T14:01:44.314+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T14:01:44.315+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T14:01:44.435+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T14:01:44.468+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T14:01:44.469+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-08-16T14:01:44.469+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T14:01:44.630+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T14:01:44.631+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T14:01:44.631+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T14:01:44.632+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T14:01:44.632+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T14:01:44.633+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T14:01:44.633+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T14:01:45.277+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T14:01:45.278+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T14:01:45.278+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T14:01:45.278+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T14:01:45.279+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T14:01:45.279+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T14:01:45.281+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T14:01:45.281+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T14:01:45.281+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T14:01:45.282+00:00 | INFO     | Input validation passed
#> 2026-08-16T14:01:45.283+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T14:01:45.283+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T14:01:45.284+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T14:01:45.292+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T14:01:45.292+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T14:01:45.293+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T14:01:45.293+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T14:01:45.294+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T14:01:45.296+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T14:01:45.297+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T14:01:45.297+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-16T14:01:45.298+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T14:01:45.300+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T14:01:45.300+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T14:01:45.426+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T14:01:45.455+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T14:01:45.456+00:00 | INFO     | Timer 'tree_rendering': 155 ms
#> 2026-08-16T14:01:45.456+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T14:01:45.543+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T14:01:45.543+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T14:01:45.544+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T14:01:45.544+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T14:01:45.544+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T14:01:45.545+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T14:01:45.545+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-16T14:01:45.547+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T14:01:45.547+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T14:01:45.548+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T14:01:45.548+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T14:01:45.548+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T14:01:45.549+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T14:01:45.550+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T14:01:45.550+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T14:01:45.551+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T14:01:45.552+00:00 | INFO     | Input validation passed
#> 2026-08-16T14:01:45.552+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T14:01:45.552+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T14:01:45.553+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T14:01:45.567+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T14:01:45.567+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T14:01:45.568+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-16T14:01:45.568+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T14:01:45.569+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T14:01:45.571+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T14:01:45.572+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T14:01:45.572+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-16T14:01:45.573+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T14:01:45.574+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T14:01:45.575+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T14:01:45.697+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T14:01:45.726+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T14:01:45.727+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-08-16T14:01:45.727+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T14:01:45.818+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T14:01:45.818+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T14:01:45.819+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T14:01:45.819+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T14:01:45.820+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T14:01:45.820+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T14:01:45.820+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T14:01:45.968+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T14:01:45.969+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T14:01:45.969+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T14:01:45.969+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T14:01:45.970+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T14:01:45.970+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T14:01:45.971+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T14:01:45.972+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T14:01:45.972+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T14:01:45.973+00:00 | INFO     | Input validation passed
#> 2026-08-16T14:01:45.974+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T14:01:45.974+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T14:01:45.974+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T14:01:45.983+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T14:01:45.983+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T14:01:45.984+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T14:01:45.984+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T14:01:45.984+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T14:01:45.987+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T14:01:45.987+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T14:01:45.988+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-16T14:01:45.989+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T14:01:45.990+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T14:01:45.991+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T14:01:46.115+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T14:01:46.152+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T14:01:46.152+00:00 | INFO     | Timer 'tree_rendering': 161 ms
#> 2026-08-16T14:01:46.153+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T14:01:46.251+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T14:01:46.252+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T14:01:46.252+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T14:01:46.253+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T14:01:46.253+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T14:01:46.253+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T14:01:46.254+00:00 | INFO     | plot_timetree completed successfully
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
