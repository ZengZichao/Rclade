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
#> 2026-08-16T07:09:10.638+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T07:09:10.639+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T07:09:10.639+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T07:09:10.640+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T07:09:10.640+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T07:09:10.641+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T07:09:10.650+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T07:09:10.650+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T07:09:10.651+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T07:09:10.651+00:00 | INFO     | Input validation passed
#> 2026-08-16T07:09:10.652+00:00 | INFO     | Timer 'input_reading': 10 ms
#> 2026-08-16T07:09:10.653+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T07:09:10.653+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T07:09:10.662+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T07:09:10.663+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T07:09:10.663+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-16T07:09:10.664+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T07:09:10.664+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T07:09:10.668+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T07:09:10.668+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T07:09:10.669+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-16T07:09:11.489+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T07:09:11.496+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T07:09:11.497+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T07:09:11.721+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T07:09:11.751+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T07:09:11.752+00:00 | INFO     | Timer 'tree_rendering': 254 ms
#> 2026-08-16T07:09:11.752+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T07:09:11.849+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T07:09:11.850+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T07:09:11.850+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T07:09:11.850+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T07:09:11.851+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T07:09:11.851+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T07:09:11.851+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T07:09:12.485+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T07:09:12.486+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T07:09:12.486+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T07:09:12.486+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T07:09:12.487+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T07:09:12.487+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T07:09:12.488+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T07:09:12.489+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T07:09:12.489+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T07:09:12.490+00:00 | INFO     | Input validation passed
#> 2026-08-16T07:09:12.491+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T07:09:12.491+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T07:09:12.491+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T07:09:12.500+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T07:09:12.500+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T07:09:12.501+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T07:09:12.501+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T07:09:12.501+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T07:09:12.504+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T07:09:12.505+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T07:09:12.505+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-16T07:09:12.506+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T07:09:12.507+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T07:09:12.508+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T07:09:12.633+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T07:09:12.662+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T07:09:12.663+00:00 | INFO     | Timer 'tree_rendering': 155 ms
#> 2026-08-16T07:09:12.663+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T07:09:12.751+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T07:09:12.751+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T07:09:12.752+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T07:09:12.752+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T07:09:12.753+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T07:09:12.753+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T07:09:12.753+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T07:09:13.421+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T07:09:13.422+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T07:09:13.422+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T07:09:13.422+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T07:09:13.423+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T07:09:13.423+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T07:09:13.424+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T07:09:13.425+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T07:09:13.425+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T07:09:13.426+00:00 | INFO     | Input validation passed
#> 2026-08-16T07:09:13.426+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T07:09:13.427+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T07:09:13.427+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T07:09:13.435+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T07:09:13.436+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T07:09:13.436+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T07:09:13.436+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T07:09:13.437+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T07:09:13.445+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T07:09:13.445+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T07:09:13.445+00:00 | INFO     | Timer 'mrca_computation': 9 ms
#> 2026-08-16T07:09:13.446+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T07:09:13.448+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T07:09:13.448+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T07:09:13.564+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T07:09:13.592+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T07:09:13.593+00:00 | INFO     | Timer 'tree_rendering': 145 ms
#> 2026-08-16T07:09:13.593+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T07:09:13.683+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T07:09:13.684+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T07:09:13.684+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T07:09:13.684+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T07:09:13.685+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T07:09:13.685+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T07:09:13.685+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-16T07:09:13.687+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T07:09:13.687+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T07:09:13.688+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T07:09:13.688+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T07:09:13.689+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T07:09:13.689+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T07:09:13.690+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T07:09:13.691+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T07:09:13.691+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T07:09:13.692+00:00 | INFO     | Input validation passed
#> 2026-08-16T07:09:13.692+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T07:09:13.693+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T07:09:13.693+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T07:09:13.702+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T07:09:13.703+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T07:09:13.703+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-16T07:09:13.704+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T07:09:13.704+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T07:09:13.707+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T07:09:13.707+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T07:09:13.708+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-16T07:09:13.708+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T07:09:13.710+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T07:09:13.710+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T07:09:13.832+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T07:09:13.861+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T07:09:13.861+00:00 | INFO     | Timer 'tree_rendering': 150 ms
#> 2026-08-16T07:09:13.862+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T07:09:13.945+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T07:09:13.946+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T07:09:13.946+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T07:09:13.946+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T07:09:13.947+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T07:09:13.947+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T07:09:13.948+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T07:09:14.126+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T07:09:14.126+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T07:09:14.126+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T07:09:14.127+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T07:09:14.127+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T07:09:14.128+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T07:09:14.129+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T07:09:14.129+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T07:09:14.129+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T07:09:14.131+00:00 | INFO     | Input validation passed
#> 2026-08-16T07:09:14.131+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T07:09:14.131+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T07:09:14.132+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T07:09:14.140+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T07:09:14.140+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T07:09:14.141+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T07:09:14.141+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T07:09:14.141+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T07:09:14.144+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T07:09:14.144+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T07:09:14.150+00:00 | INFO     | Timer 'mrca_computation': 9 ms
#> 2026-08-16T07:09:14.151+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T07:09:14.152+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T07:09:14.153+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T07:09:14.268+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T07:09:14.299+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T07:09:14.300+00:00 | INFO     | Timer 'tree_rendering': 147 ms
#> 2026-08-16T07:09:14.301+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T07:09:14.398+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T07:09:14.399+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T07:09:14.399+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T07:09:14.399+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T07:09:14.400+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T07:09:14.400+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T07:09:14.401+00:00 | INFO     | plot_timetree completed successfully
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
