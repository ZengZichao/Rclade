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
#> 2026-08-22T08:09:01.838+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:09:01.839+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:09:01.839+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:09:01.840+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:09:01.840+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:09:01.841+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:09:01.842+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:09:01.843+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:09:01.843+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:09:01.844+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:09:01.845+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:09:01.845+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:09:01.846+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:09:01.855+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:09:01.855+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:09:01.856+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-22T08:09:01.856+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:09:01.856+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:09:01.860+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:09:01.861+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:09:01.861+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-22T08:09:02.701+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:09:02.709+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:09:02.710+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:09:02.924+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:09:02.955+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:09:02.955+00:00 | INFO     | Timer 'tree_rendering': 245 ms
#> 2026-08-22T08:09:02.956+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:09:03.056+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:09:03.056+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:09:03.057+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:09:03.057+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:09:03.057+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:09:03.058+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:09:03.058+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T08:09:03.698+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:09:03.698+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:09:03.699+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:09:03.699+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:09:03.700+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:09:03.700+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:09:03.701+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:09:03.702+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:09:03.702+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:09:03.703+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:09:03.703+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:09:03.704+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:09:03.704+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:09:03.712+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:09:03.712+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:09:03.713+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T08:09:03.713+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:09:03.720+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:09:03.722+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:09:03.723+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:09:03.723+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T08:09:03.724+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:09:03.725+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:09:03.726+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:09:03.843+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:09:03.872+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:09:03.873+00:00 | INFO     | Timer 'tree_rendering': 147 ms
#> 2026-08-22T08:09:03.873+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:09:04.003+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:09:04.003+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:09:04.004+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:09:04.004+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:09:04.004+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:09:04.005+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:09:04.005+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T08:09:04.639+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:09:04.640+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:09:04.640+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:09:04.641+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:09:04.641+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:09:04.641+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:09:04.643+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:09:04.643+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:09:04.643+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:09:04.644+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:09:04.645+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:09:04.645+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:09:04.646+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:09:04.654+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:09:04.654+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:09:04.655+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T08:09:04.655+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:09:04.656+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:09:04.658+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:09:04.659+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:09:04.659+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T08:09:04.660+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:09:04.662+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:09:04.662+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:09:04.786+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:09:04.815+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:09:04.816+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-08-22T08:09:04.817+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:09:04.902+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:09:04.902+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:09:04.903+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:09:04.903+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:09:04.903+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:09:04.904+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:09:04.904+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-22T08:09:04.906+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:09:04.906+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:09:04.907+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:09:04.907+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:09:04.907+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:09:04.908+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:09:04.909+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:09:04.909+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:09:04.910+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:09:04.911+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:09:04.911+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:09:04.911+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:09:04.912+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:09:04.925+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:09:04.925+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:09:04.926+00:00 | INFO     | Timer 'taxonomy_parsing': 14 ms
#> 2026-08-22T08:09:04.926+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:09:04.927+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:09:04.929+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:09:04.930+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:09:04.930+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T08:09:04.931+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:09:04.932+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:09:04.933+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:09:05.050+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:09:05.081+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:09:05.082+00:00 | INFO     | Timer 'tree_rendering': 149 ms
#> 2026-08-22T08:09:05.082+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:09:05.171+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:09:05.171+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:09:05.172+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:09:05.172+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:09:05.173+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:09:05.173+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:09:05.173+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T08:09:05.323+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T08:09:05.323+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T08:09:05.323+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T08:09:05.324+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T08:09:05.324+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T08:09:05.325+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T08:09:05.326+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T08:09:05.326+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T08:09:05.326+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T08:09:05.328+00:00 | INFO     | Input validation passed
#> 2026-08-22T08:09:05.328+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T08:09:05.328+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T08:09:05.329+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T08:09:05.337+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T08:09:05.337+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T08:09:05.338+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T08:09:05.338+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T08:09:05.339+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T08:09:05.341+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T08:09:05.342+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T08:09:05.342+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-22T08:09:05.343+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T08:09:05.344+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T08:09:05.345+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T08:09:05.468+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T08:09:05.497+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T08:09:05.498+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-08-22T08:09:05.498+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T08:09:05.594+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T08:09:05.595+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T08:09:05.595+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T08:09:05.595+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T08:09:05.596+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T08:09:05.596+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T08:09:05.597+00:00 | INFO     | plot_timetree completed successfully
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
