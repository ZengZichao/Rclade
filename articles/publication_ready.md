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
#> 2026-08-21T09:50:23.346+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:50:23.347+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:50:23.348+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:50:23.348+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:50:23.348+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:50:23.349+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:50:23.351+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:50:23.351+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:50:23.351+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:50:23.352+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:50:23.353+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:50:23.353+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:50:23.354+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:50:23.362+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:50:23.363+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:50:23.363+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T09:50:23.363+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:50:23.364+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:50:23.367+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:50:23.368+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:50:23.368+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T09:50:24.254+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:50:24.262+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:50:24.263+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:50:24.469+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:50:24.497+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:50:24.497+00:00 | INFO     | Timer 'tree_rendering': 234 ms
#> 2026-08-21T09:50:24.498+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:50:24.595+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:50:24.596+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:50:24.596+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:50:24.597+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:50:24.597+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:50:24.597+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:50:24.598+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T09:50:25.289+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:50:25.289+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:50:25.289+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:50:25.290+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:50:25.290+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:50:25.290+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:50:25.291+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:50:25.292+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:50:25.292+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:50:25.293+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:50:25.293+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:50:25.294+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:50:25.294+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:50:25.301+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:50:25.302+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:50:25.302+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T09:50:25.303+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:50:25.309+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:50:25.312+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:50:25.312+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:50:25.313+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T09:50:25.313+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:50:25.315+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:50:25.315+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:50:25.424+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:50:25.451+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:50:25.452+00:00 | INFO     | Timer 'tree_rendering': 136 ms
#> 2026-08-21T09:50:25.452+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:50:25.585+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:50:25.585+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:50:25.586+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:50:25.586+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:50:25.586+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:50:25.587+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:50:25.587+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T09:50:26.167+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:50:26.168+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:50:26.168+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:50:26.168+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:50:26.169+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:50:26.169+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:50:26.170+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:50:26.170+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:50:26.171+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:50:26.172+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:50:26.172+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:50:26.172+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:50:26.173+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:50:26.180+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:50:26.181+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:50:26.181+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T09:50:26.182+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:50:26.182+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:50:26.184+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:50:26.185+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:50:26.185+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T09:50:26.186+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:50:26.187+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:50:26.188+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:50:26.304+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:50:26.330+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:50:26.331+00:00 | INFO     | Timer 'tree_rendering': 143 ms
#> 2026-08-21T09:50:26.331+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:50:26.409+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:50:26.409+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:50:26.410+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:50:26.410+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:50:26.410+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:50:26.411+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:50:26.411+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T09:50:26.413+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:50:26.413+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:50:26.413+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:50:26.413+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:50:26.414+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:50:26.414+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:50:26.415+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:50:26.415+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:50:26.416+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:50:26.417+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:50:26.417+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T09:50:26.417+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:50:26.418+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:50:26.431+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:50:26.431+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:50:26.432+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-21T09:50:26.432+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:50:26.432+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:50:26.435+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:50:26.435+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:50:26.436+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T09:50:26.436+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:50:26.437+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:50:26.438+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:50:26.550+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:50:26.577+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:50:26.577+00:00 | INFO     | Timer 'tree_rendering': 139 ms
#> 2026-08-21T09:50:26.578+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:50:26.660+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:50:26.661+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:50:26.661+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:50:26.661+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:50:26.662+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:50:26.662+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:50:26.662+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T09:50:26.795+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:50:26.795+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:50:26.796+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:50:26.796+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:50:26.796+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:50:26.797+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:50:26.798+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:50:26.798+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:50:26.798+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:50:26.799+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:50:26.800+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:50:26.800+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:50:26.800+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:50:26.808+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:50:26.808+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:50:26.809+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T09:50:26.809+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:50:26.809+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:50:26.812+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:50:26.812+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:50:26.813+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T09:50:26.813+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:50:26.815+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:50:26.815+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:50:26.931+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:50:26.959+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:50:26.960+00:00 | INFO     | Timer 'tree_rendering': 145 ms
#> 2026-08-21T09:50:26.961+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:50:27.051+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:50:27.052+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:50:27.052+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:50:27.052+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:50:27.053+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:50:27.053+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:50:27.053+00:00 | INFO     | plot_timetree completed successfully
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
