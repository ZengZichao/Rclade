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
#> 2026-08-21T11:11:23.406+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:11:23.407+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:11:23.408+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:11:23.408+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:11:23.409+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:11:23.409+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:11:23.411+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:11:23.411+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:11:23.412+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:11:23.413+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:11:23.413+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:11:23.414+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:11:23.414+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:11:23.423+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:11:23.424+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:11:23.424+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-21T11:11:23.425+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:11:23.425+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:11:23.429+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:11:23.430+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:11:23.430+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-21T11:11:24.297+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:11:24.305+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:11:24.306+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:11:24.520+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:11:24.550+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:11:24.551+00:00 | INFO     | Timer 'tree_rendering': 244 ms
#> 2026-08-21T11:11:24.551+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:11:24.650+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:11:24.650+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:11:24.650+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:11:24.651+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:11:24.651+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:11:24.652+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:11:24.652+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T11:11:25.347+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:11:25.347+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:11:25.348+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:11:25.348+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:11:25.348+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:11:25.349+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:11:25.350+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:11:25.350+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:11:25.351+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:11:25.352+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:11:25.352+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:11:25.353+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:11:25.353+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:11:25.361+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:11:25.362+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:11:25.362+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T11:11:25.363+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:11:25.370+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:11:25.373+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:11:25.373+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:11:25.374+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T11:11:25.374+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:11:25.376+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:11:25.376+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:11:25.497+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:11:25.527+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:11:25.528+00:00 | INFO     | Timer 'tree_rendering': 151 ms
#> 2026-08-21T11:11:25.528+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:11:25.662+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:11:25.663+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:11:25.663+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:11:25.663+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:11:25.664+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:11:25.664+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:11:25.665+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T11:11:26.300+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:11:26.300+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:11:26.301+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:11:26.301+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:11:26.302+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:11:26.302+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:11:26.303+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:11:26.304+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:11:26.304+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:11:26.305+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:11:26.306+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:11:26.306+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:11:26.306+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:11:26.315+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:11:26.315+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:11:26.316+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T11:11:26.316+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:11:26.316+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:11:26.319+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:11:26.320+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:11:26.320+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T11:11:26.321+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:11:26.322+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:11:26.323+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:11:26.449+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:11:26.480+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:11:26.480+00:00 | INFO     | Timer 'tree_rendering': 157 ms
#> 2026-08-21T11:11:26.481+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:11:26.566+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:11:26.566+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:11:26.567+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:11:26.567+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:11:26.568+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:11:26.568+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:11:26.569+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T11:11:26.570+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:11:26.571+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:11:26.571+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:11:26.572+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:11:26.572+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:11:26.572+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:11:26.574+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:11:26.574+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:11:26.574+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:11:26.575+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:11:26.576+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:11:26.576+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:11:26.577+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:11:26.590+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:11:26.591+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:11:26.591+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-21T11:11:26.592+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:11:26.592+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:11:26.595+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:11:26.595+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:11:26.596+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T11:11:26.596+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:11:26.598+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:11:26.598+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:11:26.724+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:11:26.753+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:11:26.754+00:00 | INFO     | Timer 'tree_rendering': 155 ms
#> 2026-08-21T11:11:26.754+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:11:26.843+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:11:26.843+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:11:26.844+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:11:26.844+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:11:26.844+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:11:26.845+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:11:26.845+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T11:11:26.994+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T11:11:26.994+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T11:11:26.995+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T11:11:26.995+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T11:11:26.996+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T11:11:26.996+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T11:11:26.997+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T11:11:26.998+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T11:11:26.998+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T11:11:26.999+00:00 | INFO     | Input validation passed
#> 2026-08-21T11:11:26.999+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T11:11:26.1000+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T11:11:27.000+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T11:11:27.008+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T11:11:27.009+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T11:11:27.009+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T11:11:27.010+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T11:11:27.010+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T11:11:27.013+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T11:11:27.013+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T11:11:27.014+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T11:11:27.014+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T11:11:27.016+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T11:11:27.016+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T11:11:27.141+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T11:11:27.172+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T11:11:27.172+00:00 | INFO     | Timer 'tree_rendering': 155 ms
#> 2026-08-21T11:11:27.173+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T11:11:27.270+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T11:11:27.271+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T11:11:27.271+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T11:11:27.272+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T11:11:27.272+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T11:11:27.272+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T11:11:27.273+00:00 | INFO     | plot_timetree completed successfully
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
