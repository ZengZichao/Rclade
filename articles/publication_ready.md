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
#> 2026-08-22T16:18:42.890+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:18:42.890+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:18:42.891+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:18:42.891+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:18:42.891+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:18:42.892+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:18:42.894+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:18:42.894+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:18:42.895+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:18:42.895+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:18:42.896+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:18:42.897+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:18:42.897+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:18:42.906+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:18:42.906+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:18:42.907+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-08-22T16:18:42.907+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:18:42.907+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:18:42.911+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:18:42.912+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:18:42.912+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-08-22T16:18:43.838+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:18:43.846+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:18:43.847+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:18:44.061+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:18:44.091+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:18:44.091+00:00 | INFO     | Timer 'tree_rendering': 244 ms
#> 2026-08-22T16:18:44.092+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:18:44.189+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:18:44.189+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:18:44.190+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:18:44.190+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:18:44.190+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:18:44.191+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:18:44.191+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T16:18:44.780+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:18:44.780+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:18:44.781+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:18:44.781+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:18:44.781+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:18:44.782+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:18:44.782+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:18:44.783+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:18:44.783+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:18:44.784+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:18:44.785+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:18:44.785+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:18:44.785+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:18:44.793+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:18:44.794+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:18:44.794+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T16:18:44.794+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:18:44.802+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:18:44.805+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:18:44.805+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:18:44.806+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-22T16:18:44.806+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:18:44.808+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:18:44.808+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:18:44.924+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:18:44.954+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:18:44.955+00:00 | INFO     | Timer 'tree_rendering': 146 ms
#> 2026-08-22T16:18:44.955+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:18:45.099+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:18:45.100+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:18:45.100+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:18:45.100+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:18:45.101+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:18:45.101+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:18:45.102+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T16:18:45.695+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:18:45.695+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:18:45.695+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:18:45.696+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:18:45.696+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:18:45.697+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:18:45.698+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:18:45.698+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:18:45.698+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:18:45.699+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:18:45.700+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:18:45.700+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:18:45.700+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:18:45.708+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:18:45.709+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:18:45.709+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T16:18:45.710+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:18:45.710+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:18:45.713+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:18:45.713+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:18:45.713+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-22T16:18:45.714+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:18:45.716+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:18:45.716+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:18:45.837+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:18:45.867+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:18:45.868+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-08-22T16:18:45.869+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:18:45.950+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:18:45.951+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:18:45.951+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:18:45.951+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:18:45.952+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:18:45.952+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:18:45.952+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-22T16:18:45.954+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:18:45.954+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:18:45.955+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:18:45.955+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:18:45.955+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:18:45.956+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:18:45.957+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:18:45.957+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:18:45.957+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:18:45.958+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:18:45.959+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:18:45.959+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:18:45.959+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:18:45.974+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:18:45.974+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:18:45.975+00:00 | INFO     | Timer 'taxonomy_parsing': 16 ms
#> 2026-08-22T16:18:45.975+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:18:45.976+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:18:45.978+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:18:45.979+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:18:45.979+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-22T16:18:45.980+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:18:45.981+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:18:45.982+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:18:46.099+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:18:46.129+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:18:46.129+00:00 | INFO     | Timer 'tree_rendering': 147 ms
#> 2026-08-22T16:18:46.130+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:18:46.218+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:18:46.218+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:18:46.219+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:18:46.219+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:18:46.219+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:18:46.220+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:18:46.220+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-22T16:18:46.353+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-22T16:18:46.353+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-22T16:18:46.354+00:00 | INFO     | Rank                     : phylum
#> 2026-08-22T16:18:46.354+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-22T16:18:46.354+00:00 | INFO     | Unit                     : auto
#> 2026-08-22T16:18:46.355+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-22T16:18:46.356+00:00 | INFO     | Tips                     : 50
#> 2026-08-22T16:18:46.356+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-22T16:18:46.356+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-22T16:18:46.357+00:00 | INFO     | Input validation passed
#> 2026-08-22T16:18:46.358+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-22T16:18:46.358+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-22T16:18:46.358+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-22T16:18:46.366+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-22T16:18:46.367+00:00 | INFO     | Groups found             : 5
#> 2026-08-22T16:18:46.367+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-22T16:18:46.368+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-22T16:18:46.368+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-22T16:18:46.371+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-22T16:18:46.371+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-22T16:18:46.371+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-22T16:18:46.372+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-22T16:18:46.374+00:00 | INFO     | Color palette            : viridis
#> 2026-08-22T16:18:46.374+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-22T16:18:46.496+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-22T16:18:46.526+00:00 | INFO     | Clade collapse complete
#> 2026-08-22T16:18:46.527+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-08-22T16:18:46.527+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-22T16:18:46.623+00:00 | INFO     |   Tips              : 50
#> 2026-08-22T16:18:46.623+00:00 | INFO     |   Groups            : 5
#> 2026-08-22T16:18:46.623+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-22T16:18:46.624+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-22T16:18:46.624+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-22T16:18:46.624+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-22T16:18:46.625+00:00 | INFO     | plot_timetree completed successfully
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
