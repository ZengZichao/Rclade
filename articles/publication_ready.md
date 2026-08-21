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
#> 2026-08-21T14:17:31.795+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:31.796+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:31.796+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:31.796+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:31.797+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:31.798+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:31.799+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:31.800+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:31.800+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:31.801+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:31.802+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T14:17:31.802+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:31.803+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:31.812+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:31.812+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:31.813+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-21T14:17:31.813+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:31.814+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:31.818+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:31.818+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:31.819+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-21T14:17:32.709+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:32.717+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:32.718+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:32.935+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:32.967+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:32.968+00:00 | INFO     | Timer 'tree_rendering': 249 ms
#> 2026-08-21T14:17:32.968+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:33.074+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:33.075+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:33.075+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:33.076+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:33.076+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:33.077+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:33.077+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T14:17:33.720+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:33.720+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:33.721+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:33.721+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:33.722+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:33.722+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:33.723+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:33.724+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:33.724+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:33.725+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:33.726+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T14:17:33.726+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:33.726+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:33.735+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:33.735+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:33.736+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T14:17:33.736+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:33.744+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:33.746+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:33.747+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:33.747+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T14:17:33.748+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:33.750+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:33.750+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:33.874+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:33.907+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:33.908+00:00 | INFO     | Timer 'tree_rendering': 157 ms
#> 2026-08-21T14:17:33.908+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:34.049+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:34.049+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:34.049+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:34.050+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:34.050+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:34.051+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:34.051+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T14:17:34.695+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:34.696+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:34.696+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:34.697+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:34.697+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:34.697+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:34.699+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:34.699+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:34.699+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:34.701+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:34.701+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T14:17:34.701+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:34.702+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:34.710+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:34.711+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:34.711+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T14:17:34.712+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:34.712+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:34.715+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:34.715+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:34.716+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T14:17:34.716+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:34.718+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:34.718+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:34.845+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:34.876+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:34.877+00:00 | INFO     | Timer 'tree_rendering': 158 ms
#> 2026-08-21T14:17:34.877+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:34.963+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:34.963+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:34.964+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:34.964+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:34.965+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:34.965+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:34.965+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T14:17:34.967+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:34.967+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:34.968+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:34.968+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:34.969+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:34.969+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:34.970+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:34.970+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:34.971+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:34.972+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:34.972+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T14:17:34.973+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:34.973+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:34.987+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:34.988+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:34.988+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-21T14:17:34.989+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:34.989+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:34.992+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:34.992+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:34.992+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T14:17:34.993+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:34.995+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:34.995+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:35.116+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:35.147+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:35.147+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-08-21T14:17:35.148+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:35.239+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:35.239+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:35.240+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:35.240+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:35.240+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:35.241+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:35.241+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T14:17:35.390+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:35.391+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:35.391+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:35.392+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:35.392+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:35.393+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:35.394+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:35.394+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:35.395+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:35.396+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:35.396+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T14:17:35.397+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:35.397+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:35.405+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:35.406+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:35.406+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T14:17:35.407+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:35.407+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:35.410+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:35.410+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:35.411+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T14:17:35.412+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:35.413+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:35.414+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:35.541+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:35.571+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:35.572+00:00 | INFO     | Timer 'tree_rendering': 158 ms
#> 2026-08-21T14:17:35.573+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:35.674+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:35.674+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:35.674+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:35.675+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:35.675+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:35.676+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:35.676+00:00 | INFO     | plot_timetree completed successfully
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
