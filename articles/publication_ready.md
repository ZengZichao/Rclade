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
#> 2026-08-22T08:05:19.264+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:05:19.265+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:05:19.266+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:05:19.266+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:05:19.266+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:05:19.267+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:05:19.269+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:05:19.269+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:05:19.269+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:05:19.270+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:05:19.271+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:05:19.271+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:05:19.272+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:05:19.281+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:05:19.281+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:05:19.281+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-22T08:05:19.282+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:05:19.282+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:05:19.286+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:05:19.286+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:05:19.287+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-22T08:05:20.211+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:05:20.219+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:05:20.220+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:05:20.435+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:05:20.466+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:05:20.467+00:00 | INFO     | Timer 'tree_rendering': 246 ms
#> 2026-08-22T08:05:20.467+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:05:20.566+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:05:20.566+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:05:20.567+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:05:20.567+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:05:20.567+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:05:20.568+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:05:20.568+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T08:05:21.188+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:05:21.189+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:05:21.189+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:05:21.189+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:05:21.190+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:05:21.190+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:05:21.191+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:05:21.191+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:05:21.191+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:05:21.192+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:05:21.193+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:05:21.193+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:05:21.194+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:05:21.201+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:05:21.202+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:05:21.202+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T08:05:21.203+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:05:21.210+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:05:21.213+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:05:21.214+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:05:21.214+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-22T08:05:21.215+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:05:21.216+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:05:21.216+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:05:21.332+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:05:21.363+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:05:21.364+00:00 | INFO     | Timer 'tree_rendering': 147 ms
#> 2026-08-22T08:05:21.365+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:05:21.507+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:05:21.507+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:05:21.508+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:05:21.508+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:05:21.508+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:05:21.509+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:05:21.509+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T08:05:22.103+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:05:22.103+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:05:22.104+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:05:22.104+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:05:22.104+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:05:22.105+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:05:22.106+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:05:22.106+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:05:22.106+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:05:22.107+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:05:22.108+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:05:22.108+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:05:22.109+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:05:22.116+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:05:22.117+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:05:22.117+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T08:05:22.118+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:05:22.118+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:05:22.120+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:05:22.121+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:05:22.121+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-22T08:05:22.122+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:05:22.124+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:05:22.124+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:05:22.245+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:05:22.275+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:05:22.276+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-08-22T08:05:22.277+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:05:22.359+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:05:22.360+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:05:22.360+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:05:22.361+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:05:22.361+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:05:22.361+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:05:22.361+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-22T08:05:22.363+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:05:22.363+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:05:22.364+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:05:22.364+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:05:22.364+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:05:22.365+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:05:22.366+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:05:22.366+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:05:22.366+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:05:22.367+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:05:22.368+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:05:22.368+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:05:22.368+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:05:22.383+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:05:22.383+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:05:22.384+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-22T08:05:22.384+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:05:22.385+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:05:22.387+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:05:22.388+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:05:22.388+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T08:05:22.389+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:05:22.390+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:05:22.391+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:05:22.508+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:05:22.537+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:05:22.538+00:00 | INFO     | Timer 'tree_rendering': 147 ms
#> 2026-08-22T08:05:22.538+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:05:22.627+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:05:22.627+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:05:22.627+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:05:22.628+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:05:22.628+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:05:22.628+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:05:22.629+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T08:05:22.762+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:05:22.762+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:05:22.762+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:05:22.763+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:05:22.763+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:05:22.763+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:05:22.764+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:05:22.765+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:05:22.765+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:05:22.766+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:05:22.767+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:05:22.767+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:05:22.767+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:05:22.775+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:05:22.776+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:05:22.776+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T08:05:22.776+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:05:22.777+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:05:22.779+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:05:22.780+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:05:22.780+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-22T08:05:22.781+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:05:22.782+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:05:22.783+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:05:22.905+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:05:22.933+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:05:22.933+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-08-22T08:05:22.934+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:05:23.027+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:05:23.027+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:05:23.027+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:05:23.028+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:05:23.028+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:05:23.028+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:05:23.029+00:00 | INFO     | plot_timetree completed successfully
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
