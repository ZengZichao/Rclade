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
#> 2026-08-21T09:23:58.172+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:23:58.173+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:23:58.173+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:23:58.173+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:23:58.174+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:23:58.174+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:23:58.176+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:23:58.176+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:23:58.176+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:23:58.177+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:23:58.178+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:23:58.178+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:23:58.178+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:23:58.186+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:23:58.186+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:23:58.186+00:00 | INFO     | Timer 'taxonomy_parsing': 8 ms
#> 2026-08-21T09:23:58.187+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:23:58.187+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:23:58.190+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:23:58.191+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:23:58.191+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-08-21T09:23:58.926+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:23:58.932+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:23:58.933+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:23:59.115+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:23:59.142+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:23:59.142+00:00 | INFO     | Timer 'tree_rendering': 208 ms
#> 2026-08-21T09:23:59.143+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:23:59.224+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:23:59.225+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:23:59.225+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:23:59.225+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:23:59.226+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:23:59.226+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:23:59.226+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T09:23:59.789+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:23:59.790+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:23:59.790+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:23:59.790+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:23:59.791+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:23:59.791+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:23:59.792+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:23:59.792+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:23:59.792+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:23:59.793+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:23:59.794+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T09:23:59.794+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:23:59.794+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:23:59.801+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:23:59.801+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:23:59.802+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T09:23:59.802+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:23:59.809+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:23:59.811+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:23:59.811+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:23:59.812+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T09:23:59.812+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:23:59.814+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:23:59.814+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:23:59.913+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:23:59.938+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:23:59.939+00:00 | INFO     | Timer 'tree_rendering': 125 ms
#> 2026-08-21T09:23:59.939+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:24:00.060+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:24:00.061+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:24:00.061+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:24:00.061+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:24:00.061+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:24:00.062+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:24:00.062+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T09:24:00.534+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:24:00.534+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:24:00.534+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:24:00.535+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:24:00.535+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:24:00.535+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:24:00.536+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:24:00.536+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:24:00.537+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:24:00.538+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:24:00.538+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-08-21T09:24:00.538+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:24:00.539+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:24:00.545+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:24:00.546+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:24:00.546+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T09:24:00.546+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:24:00.547+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:24:00.549+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:24:00.550+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:24:00.550+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T09:24:00.551+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:24:00.552+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:24:00.552+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:24:00.656+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:24:00.681+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:24:00.682+00:00 | INFO     | Timer 'tree_rendering': 129 ms
#> 2026-08-21T09:24:00.682+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:24:00.750+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:24:00.750+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:24:00.750+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:24:00.751+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:24:00.751+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:24:00.751+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:24:00.752+00:00 | INFO     | plot_timetree completed successfully

# Standard positions
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   legend_position = "right")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-08-21T09:24:00.753+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:24:00.753+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:24:00.753+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:24:00.754+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:24:00.754+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:24:00.754+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:24:00.755+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:24:00.755+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:24:00.756+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:24:00.756+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:24:00.757+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T09:24:00.757+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:24:00.757+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:24:00.770+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:24:00.770+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:24:00.770+00:00 | INFO     | Timer 'taxonomy_parsing': 13 ms
#> 2026-08-21T09:24:00.771+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:24:00.771+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:24:00.773+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:24:00.773+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:24:00.774+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T09:24:00.774+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:24:00.776+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:24:00.776+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:24:00.870+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:24:00.895+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:24:00.895+00:00 | INFO     | Timer 'tree_rendering': 119 ms
#> 2026-08-21T09:24:00.895+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:24:00.967+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:24:00.967+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:24:00.967+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:24:00.968+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:24:00.968+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:24:00.968+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:24:00.969+00:00 | INFO     | plot_timetree completed successfully
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
#> 2026-08-21T09:24:01.063+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-08-21T09:24:01.063+00:00 | INFO     | Tree input               : phylo object
#> 2026-08-21T09:24:01.064+00:00 | INFO     | Rank                     : phylum
#> 2026-08-21T09:24:01.064+00:00 | INFO     | Layout                   : rectangular
#> 2026-08-21T09:24:01.064+00:00 | INFO     | Unit                     : auto
#> 2026-08-21T09:24:01.065+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-08-21T09:24:01.065+00:00 | INFO     | Tips                     : 50
#> 2026-08-21T09:24:01.066+00:00 | INFO     | Internal nodes           : 49
#> 2026-08-21T09:24:01.066+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-08-21T09:24:01.067+00:00 | INFO     | Input validation passed
#> 2026-08-21T09:24:01.067+00:00 | INFO     | Timer 'input_reading': 2 ms
#> 2026-08-21T09:24:01.068+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-08-21T09:24:01.068+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-08-21T09:24:01.074+00:00 | INFO     | Detected format          : GTDB
#> 2026-08-21T09:24:01.075+00:00 | INFO     | Groups found             : 5
#> 2026-08-21T09:24:01.075+00:00 | INFO     | Timer 'taxonomy_parsing': 7 ms
#> 2026-08-21T09:24:01.075+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-08-21T09:24:01.076+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-08-21T09:24:01.078+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-08-21T09:24:01.078+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-08-21T09:24:01.079+00:00 | INFO     | Timer 'mrca_computation': 3 ms
#> 2026-08-21T09:24:01.079+00:00 | INFO     | Step 4/7: Color generation
#> 2026-08-21T09:24:01.081+00:00 | INFO     | Color palette            : viridis
#> 2026-08-21T09:24:01.081+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-08-21T09:24:01.184+00:00 | INFO     | Collapsing 5 clades...
#> 2026-08-21T09:24:01.209+00:00 | INFO     | Clade collapse complete
#> 2026-08-21T09:24:01.209+00:00 | INFO     | Timer 'tree_rendering': 128 ms
#> 2026-08-21T09:24:01.210+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-08-21T09:24:01.287+00:00 | INFO     |   Tips              : 50
#> 2026-08-21T09:24:01.288+00:00 | INFO     |   Groups            : 5
#> 2026-08-21T09:24:01.288+00:00 | INFO     |   Groups collapsed  : 5
#> 2026-08-21T09:24:01.288+00:00 | INFO     |   Taxonomy format   : GTDB
#> 2026-08-21T09:24:01.289+00:00 | INFO     |   Layout            : rectangular
#> 2026-08-21T09:24:01.289+00:00 | INFO     |   Timescale         : disabled
#> 2026-08-21T09:24:01.289+00:00 | INFO     | plot_timetree completed successfully
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
