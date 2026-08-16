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
#> 2026-08-16T08:11:44.256+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T08:11:44.257+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T08:11:44.258+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T08:11:44.258+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T08:11:44.259+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T08:11:44.260+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T08:11:44.268+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T08:11:44.269+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T08:11:44.269+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T08:11:44.270+00:00 | INFO     | Input validation passed
#> 2026-08-16T08:11:44.271+00:00 | INFO     | Timer 'input_reading': 10 ms
#> 2026-08-16T08:11:44.271+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T08:11:44.272+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T08:11:44.281+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T08:11:44.281+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T08:11:44.281+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-16T08:11:44.282+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T08:11:44.282+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T08:11:44.286+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T08:11:44.287+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T08:11:44.287+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-16T08:11:45.106+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T08:11:45.114+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T08:11:45.115+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T08:11:45.340+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T08:11:45.371+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T08:11:45.372+00:00 | INFO     | Timer 'tree_rendering': 256 ms
#> 2026-08-16T08:11:45.372+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T08:11:45.474+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T08:11:45.475+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T08:11:45.475+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T08:11:45.476+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T08:11:45.476+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T08:11:45.476+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T08:11:45.477+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T08:11:46.061+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T08:11:46.061+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T08:11:46.062+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T08:11:46.062+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T08:11:46.063+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T08:11:46.063+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T08:11:46.064+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T08:11:46.065+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T08:11:46.065+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T08:11:46.066+00:00 | INFO     | Input validation passed
#> 2026-08-16T08:11:46.066+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T08:11:46.067+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T08:11:46.067+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T08:11:46.076+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T08:11:46.076+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T08:11:46.076+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T08:11:46.077+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T08:11:46.077+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T08:11:46.080+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T08:11:46.080+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T08:11:46.081+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-16T08:11:46.082+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T08:11:46.083+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T08:11:46.083+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T08:11:46.209+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T08:11:46.239+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T08:11:46.239+00:00 | INFO     | Timer 'tree_rendering': 156 ms
#> 2026-08-16T08:11:46.240+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T08:11:46.324+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T08:11:46.325+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T08:11:46.325+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T08:11:46.325+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T08:11:46.326+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T08:11:46.326+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T08:11:46.327+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T08:11:47.011+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T08:11:47.011+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T08:11:47.012+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T08:11:47.012+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T08:11:47.012+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T08:11:47.013+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T08:11:47.014+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T08:11:47.014+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T08:11:47.015+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T08:11:47.016+00:00 | INFO     | Input validation passed
#> 2026-08-16T08:11:47.016+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T08:11:47.017+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T08:11:47.017+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T08:11:47.025+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T08:11:47.026+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T08:11:47.026+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T08:11:47.026+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T08:11:47.027+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T08:11:47.034+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T08:11:47.035+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T08:11:47.036+00:00 | INFO     | Timer 'mrca_computation': 9 ms
#> 2026-08-16T08:11:47.036+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T08:11:47.038+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T08:11:47.038+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T08:11:47.160+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T08:11:47.190+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T08:11:47.191+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-08-16T08:11:47.191+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T08:11:47.283+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T08:11:47.284+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T08:11:47.284+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T08:11:47.284+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T08:11:47.285+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T08:11:47.285+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T08:11:47.286+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-16T08:11:47.287+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T08:11:47.288+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T08:11:47.288+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T08:11:47.289+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T08:11:47.289+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T08:11:47.290+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T08:11:47.291+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T08:11:47.291+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T08:11:47.291+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T08:11:47.292+00:00 | INFO     | Input validation passed
#> 2026-08-16T08:11:47.293+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T08:11:47.293+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T08:11:47.294+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T08:11:47.302+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T08:11:47.303+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T08:11:47.303+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T08:11:47.303+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T08:11:47.304+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T08:11:47.307+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T08:11:47.307+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T08:11:47.308+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-16T08:11:47.308+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T08:11:47.310+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T08:11:47.310+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T08:11:47.437+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T08:11:47.471+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T08:11:47.472+00:00 | INFO     | Timer 'tree_rendering': 161 ms
#> 2026-08-16T08:11:47.472+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T08:11:47.559+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T08:11:47.559+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T08:11:47.560+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T08:11:47.560+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T08:11:47.561+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T08:11:47.561+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T08:11:47.561+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-16T08:11:47.710+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-16T08:11:47.711+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-16T08:11:47.711+00:00 | INFO     | Rank                     : phylum
#> 2026-08-16T08:11:47.711+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-16T08:11:47.712+00:00 | INFO     | Unit                     : auto
#> 2026-08-16T08:11:47.712+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-16T08:11:47.713+00:00 | INFO     | Tips                     : 50
#> 2026-08-16T08:11:47.714+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-16T08:11:47.714+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-16T08:11:47.715+00:00 | INFO     | Input validation passed
#> 2026-08-16T08:11:47.716+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-16T08:11:47.716+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-16T08:11:47.717+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-16T08:11:47.725+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-16T08:11:47.725+00:00 | INFO     | Groups found             : 5
#> 2026-08-16T08:11:47.726+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-16T08:11:47.726+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-16T08:11:47.727+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-16T08:11:47.729+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-16T08:11:47.730+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-16T08:11:47.730+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-16T08:11:47.731+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-16T08:11:47.732+00:00 | INFO     | Color palette            : viridis
#> 2026-08-16T08:11:47.733+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-16T08:11:47.857+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-16T08:11:47.887+00:00 | INFO     | Clade collapse complete
#> 2026-08-16T08:11:47.888+00:00 | INFO     | Timer 'tree_rendering': 154 ms
#> 2026-08-16T08:11:47.888+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-16T08:11:47.984+00:00 | INFO     |   Tips              : 50
#> 2026-08-16T08:11:47.984+00:00 | INFO     |   Groups            : 5
#> 2026-08-16T08:11:47.985+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-16T08:11:47.985+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-16T08:11:47.986+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-16T08:11:47.986+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-16T08:11:47.986+00:00 | INFO     | plot_timetree completed successfully
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
