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
#> 2026-08-21T10:03:22.769+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:03:22.770+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:03:22.770+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:03:22.771+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:03:22.771+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:03:22.772+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:03:22.773+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:03:22.773+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:03:22.773+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:03:22.774+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:03:22.775+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:03:22.775+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:03:22.775+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:03:22.782+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:03:22.782+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:03:22.783+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T10:03:22.783+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:03:22.783+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:03:22.786+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:03:22.787+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:03:22.787+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T10:03:23.478+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:03:23.484+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:03:23.484+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:03:23.649+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:03:23.674+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:03:23.674+00:00 | INFO     | Timer 'tree_rendering': 189 ms
#> 2026-08-21T10:03:23.675+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:03:23.751+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:03:23.752+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:03:23.752+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:03:23.752+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:03:23.753+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:03:23.753+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:03:23.753+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T10:03:24.310+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:03:24.310+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:03:24.310+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:03:24.311+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:03:24.311+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:03:24.311+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:03:24.312+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:03:24.312+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:03:24.312+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:03:24.313+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:03:24.314+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T10:03:24.314+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:03:24.314+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:03:24.320+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:03:24.320+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:03:24.321+00:00 | INFO     | Timer 'taxonomy_parsing': 6 ms
#> 2026-08-21T10:03:24.321+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:03:24.328+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:03:24.331+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:03:24.331+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:03:24.331+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:03:24.332+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:03:24.333+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:03:24.334+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:03:24.424+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:03:24.448+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:03:24.449+00:00 | INFO     | Timer 'tree_rendering': 115 ms
#> 2026-08-21T10:03:24.449+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:03:24.564+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:03:24.564+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:03:24.564+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:03:24.564+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:03:24.565+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:03:24.565+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:03:24.565+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T10:03:24.989+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:03:24.990+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:03:24.990+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:03:24.990+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:03:24.991+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:03:24.991+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:03:24.992+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:03:24.992+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:03:24.992+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:03:24.993+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:03:24.993+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T10:03:24.994+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:03:24.994+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:03:24.1000+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:03:25.000+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:03:25.001+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T10:03:25.001+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:03:25.001+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:03:25.003+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:03:25.004+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:03:25.004+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:03:25.005+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:03:25.006+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:03:25.006+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:03:25.105+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:03:25.131+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:03:25.132+00:00 | INFO     | Timer 'tree_rendering': 125 ms
#> 2026-08-21T10:03:25.132+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:03:25.208+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:03:25.209+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:03:25.209+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:03:25.210+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:03:25.210+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:03:25.211+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:03:25.211+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T10:03:25.214+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:03:25.214+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:03:25.215+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:03:25.215+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:03:25.216+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:03:25.217+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:03:25.219+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:03:25.219+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:03:25.220+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:03:25.221+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:03:25.221+00:00 | INFO     | Timer 'input_reading': 4 ms
#> 2026-08-21T10:03:25.222+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:03:25.222+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:03:25.238+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:03:25.239+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:03:25.239+00:00 | INFO     | Timer 'taxonomy_parsing': 17 ms
#> 2026-08-21T10:03:25.239+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:03:25.240+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:03:25.242+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:03:25.243+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:03:25.243+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T10:03:25.244+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:03:25.246+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:03:25.246+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:03:25.345+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:03:25.370+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:03:25.371+00:00 | INFO     | Timer 'tree_rendering': 124 ms
#> 2026-08-21T10:03:25.371+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:03:25.445+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:03:25.445+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:03:25.445+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:03:25.446+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:03:25.446+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:03:25.446+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:03:25.446+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T10:03:25.539+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:03:25.539+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:03:25.540+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:03:25.540+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:03:25.540+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:03:25.540+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:03:25.541+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:03:25.542+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:03:25.542+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:03:25.543+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:03:25.543+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T10:03:25.543+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:03:25.544+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:03:25.550+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:03:25.551+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:03:25.551+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T10:03:25.551+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:03:25.552+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:03:25.554+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:03:25.554+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:03:25.555+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:03:25.555+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:03:25.557+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:03:25.557+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:03:25.660+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:03:25.686+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:03:25.686+00:00 | INFO     | Timer 'tree_rendering': 129 ms
#> 2026-08-21T10:03:25.687+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:03:25.766+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:03:25.766+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:03:25.766+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:03:25.766+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:03:25.767+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:03:25.767+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:03:25.767+00:00 | INFO     | plot_timetree completed successfully
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
