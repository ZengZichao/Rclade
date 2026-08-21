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
#> 2026-08-21T10:15:14.880+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:15:14.880+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:15:14.881+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:15:14.881+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:15:14.881+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:15:14.882+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:15:14.884+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:15:14.884+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:15:14.884+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:15:14.885+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:15:14.886+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:15:14.886+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:15:14.887+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:15:14.895+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:15:14.896+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:15:14.896+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-08-21T10:15:14.896+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:15:14.897+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:15:14.900+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:15:14.901+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:15:14.901+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T10:15:15.769+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:15:15.777+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:15:15.778+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:15:15.982+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:15:16.011+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:15:16.011+00:00 | INFO     | Timer 'tree_rendering': 233 ms
#> 2026-08-21T10:15:16.012+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:15:16.107+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:15:16.107+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:15:16.108+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:15:16.108+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:15:16.108+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:15:16.109+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:15:16.109+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T10:15:16.742+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:15:16.742+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:15:16.743+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:15:16.743+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:15:16.743+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:15:16.744+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:15:16.745+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:15:16.745+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:15:16.745+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:15:16.746+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:15:16.747+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:15:16.747+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:15:16.747+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:15:16.755+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:15:16.755+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:15:16.756+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T10:15:16.756+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:15:16.763+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:15:16.765+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:15:16.766+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:15:16.766+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:15:16.767+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:15:16.768+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:15:16.768+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:15:16.879+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:15:16.906+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:15:16.906+00:00 | INFO     | Timer 'tree_rendering': 138 ms
#> 2026-08-21T10:15:16.907+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:15:17.040+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:15:17.040+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:15:17.040+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:15:17.041+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:15:17.041+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:15:17.042+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:15:17.042+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T10:15:17.616+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:15:17.617+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:15:17.617+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:15:17.617+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:15:17.618+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:15:17.618+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:15:17.619+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:15:17.619+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:15:17.620+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:15:17.621+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:15:17.621+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:15:17.621+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:15:17.622+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:15:17.629+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:15:17.630+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:15:17.630+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T10:15:17.631+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:15:17.631+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:15:17.633+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:15:17.634+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:15:17.634+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:15:17.635+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:15:17.636+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:15:17.637+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:15:17.753+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:15:17.781+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:15:17.781+00:00 | INFO     | Timer 'tree_rendering': 144 ms
#> 2026-08-21T10:15:17.782+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:15:17.862+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:15:17.862+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:15:17.862+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:15:17.863+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:15:17.863+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:15:17.863+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:15:17.864+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T10:15:17.865+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:15:17.865+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:15:17.866+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:15:17.866+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:15:17.866+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:15:17.867+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:15:17.868+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:15:17.868+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:15:17.868+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:15:17.869+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:15:17.870+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:15:17.870+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:15:17.870+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:15:17.884+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:15:17.885+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:15:17.885+00:00 | INFO     | Timer 'taxonomy_parsing': 15 ms
#> 2026-08-21T10:15:17.885+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:15:17.886+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:15:17.888+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:15:17.889+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:15:17.889+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:15:17.890+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:15:17.891+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:15:17.891+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:15:18.003+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:15:18.030+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:15:18.031+00:00 | INFO     | Timer 'tree_rendering': 139 ms
#> 2026-08-21T10:15:18.032+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:15:18.114+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:15:18.114+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:15:18.115+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:15:18.115+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:15:18.115+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:15:18.116+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:15:18.116+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T10:15:18.248+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T10:15:18.248+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T10:15:18.248+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T10:15:18.249+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T10:15:18.249+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T10:15:18.249+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T10:15:18.250+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T10:15:18.251+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T10:15:18.251+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T10:15:18.252+00:00 | INFO     | Input validation passed
#> 2026-08-21T10:15:18.252+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T10:15:18.253+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T10:15:18.253+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T10:15:18.261+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T10:15:18.261+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T10:15:18.262+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T10:15:18.262+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T10:15:18.262+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T10:15:18.265+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T10:15:18.265+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T10:15:18.265+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T10:15:18.266+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T10:15:18.268+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T10:15:18.268+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T10:15:18.383+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T10:15:18.410+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T10:15:18.411+00:00 | INFO     | Timer 'tree_rendering': 142 ms
#> 2026-08-21T10:15:18.411+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T10:15:18.503+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T10:15:18.503+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T10:15:18.503+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T10:15:18.504+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T10:15:18.504+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T10:15:18.504+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T10:15:18.505+00:00 | INFO     | plot_timetree completed successfully
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
