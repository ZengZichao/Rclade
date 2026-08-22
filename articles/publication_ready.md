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
#> 2026-08-22T16:23:41.637+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:23:41.638+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:23:41.638+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:23:41.639+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:23:41.639+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:23:41.640+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:23:41.641+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:23:41.642+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:23:41.642+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:23:41.643+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:23:41.644+00:00 | INFO     | Timer 'input_reading': 4 ms
#> 2026-08-22T16:23:41.644+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:23:41.645+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:23:41.654+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:23:41.655+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:23:41.655+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-22T16:23:41.656+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:23:41.656+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:23:41.660+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:23:41.661+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:23:41.661+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-22T16:23:42.572+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:23:42.580+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:23:42.581+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:23:42.814+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:23:42.849+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:23:42.849+00:00 | INFO     | Timer 'tree_rendering': 268 ms
#> 2026-08-22T16:23:42.850+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:23:42.959+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:23:42.959+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:23:42.960+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:23:42.960+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:23:42.961+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:23:42.961+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:23:42.962+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T16:23:43.629+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:23:43.630+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:23:43.630+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:23:43.631+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:23:43.631+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:23:43.632+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:23:43.633+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:23:43.633+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:23:43.634+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:23:43.635+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:23:43.635+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:23:43.635+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:23:43.636+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:23:43.644+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:23:43.645+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:23:43.646+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-22T16:23:43.646+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:23:43.654+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:23:43.657+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:23:43.658+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:23:43.658+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T16:23:43.659+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:23:43.661+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:23:43.662+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:23:43.790+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:23:43.826+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:23:43.826+00:00 | INFO     | Timer 'tree_rendering': 164 ms
#> 2026-08-22T16:23:43.827+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:23:43.970+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:23:43.970+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:23:43.971+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:23:43.971+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:23:43.972+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:23:43.972+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:23:43.972+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T16:23:44.639+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:23:44.639+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:23:44.640+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:23:44.640+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:23:44.640+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:23:44.641+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:23:44.642+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:23:44.643+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:23:44.643+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:23:44.644+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:23:44.645+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:23:44.645+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:23:44.645+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:23:44.654+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:23:44.654+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:23:44.655+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-22T16:23:44.655+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:23:44.656+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:23:44.659+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:23:44.659+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:23:44.660+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T16:23:44.661+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:23:44.662+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:23:44.663+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:23:44.799+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:23:44.832+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:23:44.833+00:00 | INFO     | Timer 'tree_rendering': 169 ms
#> 2026-08-22T16:23:44.833+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:23:44.926+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:23:44.926+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:23:44.927+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:23:44.927+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:23:44.928+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:23:44.928+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:23:44.928+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-22T16:23:44.930+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:23:44.931+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:23:44.931+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:23:44.931+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:23:44.932+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:23:44.932+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:23:44.933+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:23:44.934+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:23:44.934+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:23:44.935+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:23:44.936+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:23:44.936+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:23:44.936+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:23:44.951+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:23:44.952+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:23:44.952+00:00 | INFO     | Timer 'taxonomy_parsing': 16 ms
#> 2026-08-22T16:23:44.953+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:23:44.953+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:23:44.956+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:23:44.957+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:23:44.957+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T16:23:44.958+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:23:44.960+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:23:44.960+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:23:45.090+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:23:45.122+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:23:45.123+00:00 | INFO     | Timer 'tree_rendering': 162 ms
#> 2026-08-22T16:23:45.123+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:23:45.220+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:23:45.221+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:23:45.221+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:23:45.222+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:23:45.222+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:23:45.222+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:23:45.223+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T16:23:45.373+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:23:45.373+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:23:45.374+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:23:45.374+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:23:45.375+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:23:45.375+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:23:45.376+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:23:45.377+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:23:45.377+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:23:45.378+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:23:45.379+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:23:45.379+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:23:45.379+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:23:45.388+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:23:45.389+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:23:45.389+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-22T16:23:45.390+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:23:45.390+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:23:45.393+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:23:45.394+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:23:45.394+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T16:23:45.395+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:23:45.396+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:23:45.397+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:23:45.533+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:23:45.567+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:23:45.568+00:00 | INFO     | Timer 'tree_rendering': 171 ms
#> 2026-08-22T16:23:45.569+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:23:45.674+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:23:45.675+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:23:45.675+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:23:45.676+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:23:45.676+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:23:45.677+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:23:45.677+00:00 | INFO     | plot_timetree completed successfully
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
