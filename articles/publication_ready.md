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
#> 2026-08-21T14:17:50.543+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:50.544+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:50.545+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:50.545+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:50.545+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:50.546+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:50.548+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:50.548+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:50.549+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:50.550+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:50.550+00:00 | INFO     | Timer 'input_reading': 4 ms
#> 2026-08-21T14:17:50.551+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:50.551+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:50.560+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:50.561+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:50.561+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-21T14:17:50.562+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:50.562+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:50.566+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:50.566+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:50.567+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-21T14:17:51.464+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:51.472+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:51.473+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:51.689+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:51.720+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:51.721+00:00 | INFO     | Timer 'tree_rendering': 248 ms
#> 2026-08-21T14:17:51.722+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:51.823+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:51.824+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:51.824+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:51.825+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:51.825+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:51.825+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:51.826+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T14:17:52.473+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:52.473+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:52.473+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:52.474+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:52.474+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:52.475+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:52.476+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:52.476+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:52.477+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:52.478+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:52.478+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T14:17:52.479+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:52.479+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:52.487+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:52.487+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:52.488+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T14:17:52.488+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:52.495+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:52.498+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:52.498+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:52.499+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T14:17:52.499+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:52.501+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:52.501+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:52.624+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:52.654+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:52.655+00:00 | INFO     | Timer 'tree_rendering': 153 ms
#> 2026-08-21T14:17:52.655+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:52.795+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:52.795+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:52.795+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:52.796+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:52.796+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:52.797+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:52.797+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T14:17:53.445+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:53.446+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:53.446+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:53.446+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:53.447+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:53.447+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:53.448+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:53.449+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:53.449+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:53.450+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:53.451+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T14:17:53.451+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:53.451+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:53.460+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:53.460+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:53.460+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T14:17:53.461+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:53.461+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:53.464+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:53.464+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:53.465+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T14:17:53.466+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:53.467+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:53.467+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:53.593+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:53.626+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:53.628+00:00 | INFO     | Timer 'tree_rendering': 160 ms
#> 2026-08-21T14:17:53.628+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:53.716+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:53.716+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:53.717+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:53.717+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:53.717+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:53.718+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:53.718+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T14:17:53.720+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:53.720+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:53.720+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:53.721+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:53.721+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:53.722+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:53.723+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:53.723+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:53.724+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:53.725+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:53.725+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T14:17:53.725+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:53.726+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:53.740+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:53.740+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:53.741+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-21T14:17:53.741+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:53.742+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:53.744+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:53.745+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:53.745+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T14:17:53.746+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:53.747+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:53.748+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:53.871+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:53.901+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:53.902+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-08-21T14:17:53.902+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:53.994+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:53.995+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:53.995+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:53.996+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:53.996+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:53.996+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:53.997+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T14:17:54.146+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T14:17:54.146+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T14:17:54.146+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T14:17:54.147+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T14:17:54.147+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T14:17:54.148+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T14:17:54.149+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T14:17:54.149+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T14:17:54.150+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T14:17:54.151+00:00 | INFO     | Input validation passed
#> 2026-08-21T14:17:54.151+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T14:17:54.151+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T14:17:54.152+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T14:17:54.160+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T14:17:54.161+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T14:17:54.161+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T14:17:54.161+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T14:17:54.162+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T14:17:54.165+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T14:17:54.165+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T14:17:54.166+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T14:17:54.166+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T14:17:54.168+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T14:17:54.168+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T14:17:54.295+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T14:17:54.324+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T14:17:54.325+00:00 | INFO     | Timer 'tree_rendering': 156 ms
#> 2026-08-21T14:17:54.325+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T14:17:54.424+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T14:17:54.424+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T14:17:54.425+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T14:17:54.425+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T14:17:54.426+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T14:17:54.426+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T14:17:54.426+00:00 | INFO     | plot_timetree completed successfully
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
