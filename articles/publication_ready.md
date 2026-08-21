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
#> 2026-08-21T13:20:29.088+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:20:29.088+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:20:29.089+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:20:29.089+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:20:29.089+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:20:29.090+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:20:29.091+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:20:29.091+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:20:29.091+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:20:29.092+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:20:29.093+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T13:20:29.093+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:20:29.093+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:20:29.100+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:20:29.100+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:20:29.101+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T13:20:29.101+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:20:29.101+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:20:29.104+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:20:29.105+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:20:29.105+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T13:20:29.837+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:20:29.843+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:20:29.844+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:20:30.007+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:20:30.029+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:20:30.029+00:00 | INFO     | Timer 'tree_rendering': 185 ms
#> 2026-08-21T13:20:30.030+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:20:30.104+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:20:30.104+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:20:30.105+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:20:30.105+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:20:30.105+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:20:30.106+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:20:30.106+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T13:20:30.713+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:20:30.714+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:20:30.714+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:20:30.714+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:20:30.715+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:20:30.715+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:20:30.716+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:20:30.716+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:20:30.716+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:20:30.717+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:20:30.717+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T13:20:30.717+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:20:30.718+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:20:30.724+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:20:30.724+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:20:30.724+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T13:20:30.724+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:20:30.731+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:20:30.732+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:20:30.733+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:20:30.733+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T13:20:30.734+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:20:30.735+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:20:30.735+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:20:30.822+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:20:30.843+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:20:30.844+00:00 | INFO     | Timer 'tree_rendering': 108 ms
#> 2026-08-21T13:20:30.844+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:20:30.956+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:20:30.956+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:20:30.957+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:20:30.957+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:20:30.957+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:20:30.958+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:20:30.958+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T13:20:31.412+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:20:31.412+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:20:31.412+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:20:31.413+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:20:31.413+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:20:31.413+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:20:31.414+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:20:31.414+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:20:31.415+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:20:31.415+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:20:31.416+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T13:20:31.416+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:20:31.416+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:20:31.422+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:20:31.423+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:20:31.423+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T13:20:31.423+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:20:31.424+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:20:31.426+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:20:31.426+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:20:31.426+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T13:20:31.427+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:20:31.428+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:20:31.428+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:20:31.523+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:20:31.545+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:20:31.545+00:00 | INFO     | Timer 'tree_rendering': 116 ms
#> 2026-08-21T13:20:31.545+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:20:31.608+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:20:31.608+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:20:31.608+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:20:31.609+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:20:31.609+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:20:31.609+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:20:31.610+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T13:20:31.611+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:20:31.611+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:20:31.611+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:20:31.611+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:20:31.612+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:20:31.612+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:20:31.613+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:20:31.613+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:20:31.613+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:20:31.614+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:20:31.614+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T13:20:31.614+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:20:31.615+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:20:31.626+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:20:31.626+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:20:31.626+00:00 | INFO     | Timer 'taxonomy_parsing': 12 ms
#> 2026-08-21T13:20:31.627+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:20:31.627+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:20:31.629+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:20:31.629+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:20:31.629+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T13:20:31.630+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:20:31.631+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:20:31.631+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:20:31.720+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:20:31.742+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:20:31.743+00:00 | INFO     | Timer 'tree_rendering': 111 ms
#> 2026-08-21T13:20:31.743+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:20:31.812+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:20:31.812+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:20:31.812+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:20:31.812+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:20:31.813+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:20:31.813+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:20:31.813+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T13:20:31.919+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T13:20:31.919+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T13:20:31.919+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T13:20:31.919+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T13:20:31.920+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T13:20:31.920+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T13:20:31.921+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T13:20:31.921+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T13:20:31.921+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T13:20:31.922+00:00 | INFO     | Input validation passed
#> 2026-08-21T13:20:31.922+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T13:20:31.923+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T13:20:31.923+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T13:20:31.929+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T13:20:31.929+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T13:20:31.930+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T13:20:31.930+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T13:20:31.930+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T13:20:31.932+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T13:20:31.933+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T13:20:31.933+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T13:20:31.933+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T13:20:31.935+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T13:20:31.935+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T13:20:32.027+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T13:20:32.049+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T13:20:32.050+00:00 | INFO     | Timer 'tree_rendering': 114 ms
#> 2026-08-21T13:20:32.050+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T13:20:32.122+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T13:20:32.122+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T13:20:32.123+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T13:20:32.123+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T13:20:32.123+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T13:20:32.123+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T13:20:32.124+00:00 | INFO     | plot_timetree completed successfully
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
