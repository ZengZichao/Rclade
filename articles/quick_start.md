# Quick Start: From Tree File to Publication Figure

## Installation

``` r

# Install from local source package
install.packages("path/to/Rclade_1.0.0.tar.gz", repos = NULL, type = "source")
```

## Basic Usage

The simplest way to create a timetree visualization using the built-in
example data:

``` r

library(Rclade)

# Load built-in example tree (50 tips, GTDB-style labels)
data(example_tree)

# Plot with phylum-level collapsing (no timescale for speed)
p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE)
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-11-02T12:59:49.410+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-02T12:59:49.410+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-02T12:59:49.411+00:00 | INFO     | Rank                     : phylum
#> 2026-11-02T12:59:49.411+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-02T12:59:49.412+00:00 | INFO     | Unit                     : auto
#> 2026-11-02T12:59:49.412+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-02T12:59:49.414+00:00 | INFO     | Tips                     : 50
#> 2026-11-02T12:59:49.415+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-02T12:59:49.415+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-02T12:59:49.416+00:00 | INFO     | Input validation passed
#> 2026-11-02T12:59:49.416+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-11-02T12:59:49.417+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-02T12:59:49.417+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-02T12:59:49.426+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-02T12:59:49.427+00:00 | INFO     | Groups found             : 5
#> 2026-11-02T12:59:49.427+00:00 | INFO     | Timer 'taxonomy_parsing': 10 ms
#> 2026-11-02T12:59:49.428+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-02T12:59:49.428+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-02T12:59:49.432+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-02T12:59:49.432+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-02T12:59:49.433+00:00 | INFO     | Timer 'mrca_computation': 5 ms
#> 2026-11-02T12:59:50.302+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-02T12:59:50.308+00:00 | INFO     | Color palette            : viridis
#> 2026-11-02T12:59:50.308+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-02T12:59:50.503+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-02T12:59:50.535+00:00 | INFO     | Clade collapse complete
#> 2026-11-02T12:59:50.535+00:00 | INFO     | Timer 'tree_rendering': 226 ms
#> 2026-11-02T12:59:50.536+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-02T12:59:50.638+00:00 | INFO     |   Tips                        : 50
#> 2026-11-02T12:59:50.639+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-02T12:59:50.639+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-02T12:59:50.639+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-02T12:59:50.640+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-02T12:59:50.640+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-02T12:59:50.641+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-02T12:59:50.641+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-02T12:59:50.641+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-02T12:59:50.642+00:00 | INFO     | plot_timetree completed successfully
print(p)
```

![](quick_start_files/figure-html/basic-1.png)

## Adding Titles

Use `main_title` and `sub_title` to add centered titles:

``` r

p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE,
                   main_title = "GTDB Bacterial Tree",
                   sub_title = "50 taxa | Phylum-level collapsing")
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-11-02T12:59:51.224+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-02T12:59:51.225+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-02T12:59:51.225+00:00 | INFO     | Rank                     : phylum
#> 2026-11-02T12:59:51.226+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-02T12:59:51.226+00:00 | INFO     | Unit                     : auto
#> 2026-11-02T12:59:51.226+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-02T12:59:51.227+00:00 | INFO     | Tips                     : 50
#> 2026-11-02T12:59:51.228+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-02T12:59:51.228+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-02T12:59:51.229+00:00 | INFO     | Input validation passed
#> 2026-11-02T12:59:51.230+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-11-02T12:59:51.230+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-02T12:59:51.230+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-02T12:59:51.239+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-02T12:59:51.239+00:00 | INFO     | Groups found             : 5
#> 2026-11-02T12:59:51.240+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-11-02T12:59:51.240+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-02T12:59:51.240+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-02T12:59:51.243+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-02T12:59:51.243+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-02T12:59:51.244+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-11-02T12:59:51.245+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-02T12:59:51.246+00:00 | INFO     | Color palette            : viridis
#> 2026-11-02T12:59:51.246+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-02T12:59:51.367+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-02T12:59:51.399+00:00 | INFO     | Clade collapse complete
#> 2026-11-02T12:59:51.399+00:00 | INFO     | Timer 'tree_rendering': 152 ms
#> 2026-11-02T12:59:51.400+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-02T12:59:51.501+00:00 | INFO     |   Tips                        : 50
#> 2026-11-02T12:59:51.501+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-02T12:59:51.502+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-02T12:59:51.502+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-02T12:59:51.502+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-02T12:59:51.503+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-02T12:59:51.503+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-02T12:59:51.503+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-02T12:59:51.504+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-02T12:59:51.504+00:00 | INFO     | plot_timetree completed successfully
print(p)
```

![](quick_start_files/figure-html/titles-1.png)

## Summarizing Results

Use
[`summarize_timetree()`](https://zengzichao.github.io/Rclade/reference/summarize_timetree.md)
to inspect the collapse metadata:

``` r

p <- plot_timetree(example_tree, rank = "phylum",
                   taxonomy_format = "GTDB",
                   add_timescale = FALSE)
#> 
#> ============================================================
#>            Rclade: Phylogenetic Tree Visualization
#> ============================================================
#> 2026-11-02T12:59:52.203+00:00 | INFO     | Starting plot_timetree pipeline
#> 2026-11-02T12:59:52.203+00:00 | INFO     | Tree input               : phylo object
#> 2026-11-02T12:59:52.204+00:00 | INFO     | Rank                     : phylum
#> 2026-11-02T12:59:52.204+00:00 | INFO     | Layout                   : rectangular
#> 2026-11-02T12:59:52.205+00:00 | INFO     | Unit                     : auto
#> 2026-11-02T12:59:52.205+00:00 | INFO     | Step 1/7: Input validation and reading
#> 
#>   --------------------------------------------------
#>   >> Input Validation
#>   --------------------------------------------------
#> 2026-11-02T12:59:52.206+00:00 | INFO     | Tips                     : 50
#> 2026-11-02T12:59:52.207+00:00 | INFO     | Internal nodes           : 49
#> 2026-11-02T12:59:52.207+00:00 | INFO     | Edge lengths range       : 40.1579 to 2758.4006
#> 2026-11-02T12:59:52.208+00:00 | INFO     | Input validation passed
#> 2026-11-02T12:59:52.208+00:00 | INFO     | Timer 'input_reading': 3 ms
#> 2026-11-02T12:59:52.209+00:00 | INFO     | Step 2/7: Taxonomy parsing
#> 2026-11-02T12:59:52.209+00:00 | INFO     | Using rank-based taxonomy: phylum
#> 2026-11-02T12:59:52.217+00:00 | INFO     | Detected format          : GTDB
#> 2026-11-02T12:59:52.218+00:00 | INFO     | Groups found             : 5
#> 2026-11-02T12:59:52.218+00:00 | INFO     | Timer 'taxonomy_parsing': 9 ms
#> 2026-11-02T12:59:52.219+00:00 | INFO     | Step 3/7: MRCA computation and monophyly check
#> 2026-11-02T12:59:52.219+00:00 | INFO     | Checking monophyly and computing MRCA for each group...
#> 2026-11-02T12:59:52.222+00:00 | INFO     | Valid groups for collapse: 5 out of 5 total groups
#> 2026-11-02T12:59:52.222+00:00 | INFO     | Valid MRCA nodes         : 5
#> 2026-11-02T12:59:52.223+00:00 | INFO     | Timer 'mrca_computation': 4 ms
#> 2026-11-02T12:59:52.223+00:00 | INFO     | Step 4/7: Color generation
#> 2026-11-02T12:59:52.225+00:00 | INFO     | Color palette            : viridis
#> 2026-11-02T12:59:52.225+00:00 | INFO     | Step 5/7: Tree rendering
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> ! # Invaild edge matrix for <phylo>. A <tbl_df> is returned.
#> 2026-11-02T12:59:52.351+00:00 | INFO     | Collapsing 5 clades...
#> 2026-11-02T12:59:52.382+00:00 | INFO     | Clade collapse complete
#> 2026-11-02T12:59:52.383+00:00 | INFO     | Timer 'tree_rendering': 157 ms
#> 2026-11-02T12:59:52.383+00:00 | INFO     | Step 6/7: Timescale integration
#> 
#> ============================================================
#>                       Pipeline Complete
#> ============================================================
#> 2026-11-02T12:59:52.473+00:00 | INFO     |   Tips                        : 50
#> 2026-11-02T12:59:52.474+00:00 | INFO     |   Groups parsed               : 5
#> 2026-11-02T12:59:52.474+00:00 | INFO     |   Groups collapsed            : 5
#> 2026-11-02T12:59:52.474+00:00 | INFO     |   Singleton groups            : 0
#> 2026-11-02T12:59:52.475+00:00 | INFO     |   Skipped (non-monophyletic)  : 0
#> 2026-11-02T12:59:52.475+00:00 | INFO     |   Skipped (root/zero-tip)     : 0
#> 2026-11-02T12:59:52.475+00:00 | INFO     |   Taxonomy format             : GTDB
#> 2026-11-02T12:59:52.476+00:00 | INFO     |   Layout                      : rectangular
#> 2026-11-02T12:59:52.477+00:00 | INFO     |   Timescale                   : disabled
#> 2026-11-02T12:59:52.477+00:00 | INFO     | plot_timetree completed successfully
summarize_timetree(p)
#> === Rclade Timetree Summary ===
#> Input tips: 50
#> Groups parsed (total): 5
#> Groups collapsed: 5
#> Singleton groups (1 tip, not collapsed): 0
#> Skipped non-monophyletic groups: 0
#> Skipped groups (root/zero-tip): 0
#> Displayed leaves after collapse: 5
#> Taxonomy format: GTDB
#> Collapse rank: phylum
#> Palette: viridis
#> Layout: rectangular
#> Timescale: no
#> 
#> Group details:
#>   P1                              n=10  node=54
#>   P2                              n=10  node=63
#>   P3                              n=10  node=72
#>   P4                              n=10  node=82
#>   P5                              n=10  node=91
```

## Saving Output

``` r

# Save to PDF
save_timetree(p, "output.pdf", width = 14, height = 10)

# One-line pipeline
# Note: the geological timescale requires an explicit branch-length unit
# (Rclade does not infer units); pass unit = "Ma" or unit = "Ga".
plot_timetree(example_tree, rank = "phylum", unit = "Ga", output = "output.pdf")
```

## Taxonomy Quality Check

Before visualization, check how well your labels can be parsed:

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
- Paradis E, Schliep K (2019). “ape 5.0: an environment for modern
  phylogenetics and evolutionary analyses in R.” *Bioinformatics*,
  35(3), 526-528. <doi:10.1093/bioinformatics/bty633>
