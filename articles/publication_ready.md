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
#> 2026-08-21T09:47:46.310+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:47:46.311+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:47:46.311+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:47:46.311+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:47:46.312+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:47:46.313+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:47:46.314+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:47:46.315+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:47:46.315+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:47:46.316+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:47:46.317+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:47:46.317+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:47:46.318+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:47:46.327+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:47:46.327+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:47:46.328+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-21T09:47:46.328+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:47:46.329+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:47:46.333+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:47:46.333+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:47:46.334+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-21T09:47:47.184+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:47:47.192+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:47:47.192+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:47:47.408+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:47:47.439+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:47:47.439+00:00 | INFO     | Timer 'tree_rendering': 246 ms
#> 2026-08-21T09:47:47.440+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:47:47.540+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:47:47.540+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:47:47.541+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:47:47.541+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:47:47.541+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:47:47.542+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:47:47.542+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T09:47:48.174+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:47:48.175+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:47:48.175+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:47:48.175+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:47:48.176+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:47:48.176+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:47:48.177+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:47:48.178+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:47:48.178+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:47:48.179+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:47:48.180+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:47:48.180+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:47:48.180+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:47:48.188+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:47:48.189+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:47:48.190+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T09:47:48.190+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:47:48.197+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:47:48.200+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:47:48.200+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:47:48.201+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T09:47:48.201+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:47:48.203+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:47:48.203+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:47:48.325+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:47:48.355+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:47:48.355+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-08-21T09:47:48.356+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:47:48.488+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:47:48.489+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:47:48.489+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:47:48.489+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:47:48.490+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:47:48.490+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:47:48.491+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T09:47:49.130+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:47:49.130+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:47:49.131+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:47:49.131+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:47:49.132+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:47:49.132+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:47:49.133+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:47:49.134+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:47:49.134+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:47:49.135+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:47:49.136+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:47:49.136+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:47:49.136+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:47:49.145+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:47:49.146+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:47:49.146+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-21T09:47:49.147+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:47:49.147+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:47:49.150+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:47:49.150+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:47:49.151+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T09:47:49.151+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:47:49.153+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:47:49.153+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:47:49.280+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:47:49.313+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:47:49.314+00:00 | INFO     | Timer 'tree_rendering': 160 ms
#> 2026-08-21T09:47:49.315+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:47:49.401+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:47:49.402+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:47:49.402+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:47:49.403+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:47:49.403+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:47:49.403+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:47:49.404+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T09:47:49.405+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:47:49.406+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:47:49.406+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:47:49.406+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:47:49.407+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:47:49.407+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:47:49.408+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:47:49.409+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:47:49.409+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:47:49.410+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:47:49.411+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:47:49.411+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:47:49.411+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:47:49.425+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:47:49.426+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:47:49.426+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-21T09:47:49.426+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:47:49.427+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:47:49.429+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:47:49.430+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:47:49.430+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T09:47:49.431+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:47:49.433+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:47:49.433+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:47:49.556+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:47:49.589+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:47:49.589+00:00 | INFO     | Timer 'tree_rendering': 156 ms
#> 2026-08-21T09:47:49.590+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:47:49.682+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:47:49.682+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:47:49.683+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:47:49.683+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:47:49.684+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:47:49.684+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:47:49.684+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T09:47:49.834+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:47:49.834+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:47:49.835+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:47:49.835+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:47:49.835+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:47:49.836+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:47:49.837+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:47:49.837+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:47:49.838+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:47:49.839+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:47:49.839+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:47:49.840+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:47:49.840+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:47:49.848+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:47:49.849+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:47:49.849+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T09:47:49.850+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:47:49.850+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:47:49.853+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:47:49.853+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:47:49.854+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T09:47:49.854+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:47:49.856+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:47:49.856+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:47:49.982+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:47:50.018+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:47:50.018+00:00 | INFO     | Timer 'tree_rendering': 162 ms
#> 2026-08-21T09:47:50.019+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:47:50.119+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:47:50.119+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:47:50.119+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:47:50.120+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:47:50.120+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:47:50.121+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:47:50.121+00:00 | INFO     | plot_timetree completed successfully
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
