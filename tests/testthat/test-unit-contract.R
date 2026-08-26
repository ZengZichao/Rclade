# Unit-contract tests (v1.1.0, reviewer issue 1):
# Rclade never infers branch-length units. A geological timescale requires
# an explicit unit; unit = NULL + add_timescale = TRUE must abort.

test_that("unit NULL with add_timescale TRUE aborts (fail-safe contract)", {
  data(example_tree, package = "Rclade")
  expect_error(
    plot_timetree(example_tree, rank = "phylum", unit = NULL,
                  add_timescale = TRUE),
    class = "Rclade_validate_error"
  )
  expect_error(
    plot_timetree(example_tree, rank = "phylum", unit = NULL,
                  add_timescale = TRUE),
    "unit"
  )
})

test_that("unit NULL with add_timescale FALSE keeps native units", {
  data(example_tree, package = "Rclade")
  p <- plot_timetree(example_tree, rank = "phylum", unit = NULL,
                     add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

test_that("explicit unit with add_timescale TRUE works", {
  data(example_tree, package = "Rclade")
  p <- plot_timetree(example_tree, rank = "phylum", unit = "Ga",
                     add_timescale = TRUE)
  expect_s3_class(p, "ggplot")
})

test_that("non-finite edge lengths abort", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$edge.length[1] <- NA_real_
  expect_error(
    plot_timetree(tree, add_timescale = FALSE),
    class = "Rclade_validate_error"
  )
})

test_that("validate_inputs returns explicit unit unchanged", {
  data(example_tree, package = "Rclade")
  res <- Rclade:::validate_inputs(
    example_tree, rank = "none", unit = "Ma", layout = "rectangular",
    triangle_mode = "mixed", space_mode = "proportional",
    add_timescale = TRUE
  )
  expect_equal(res$unit, "Ma")
})

test_that("CLI rejects unit=auto with timescale enabled (exit code 2 path)", {
  tmp <- tempfile(fileext = ".nwk")
  writeLines("(A:1,B:1):1;", tmp)
  on.exit(unlink(tmp), add = TRUE)

  # Complete opt list mirroring run_rclade_cli()'s option_list defaults.
  base_opt <- list(
    file = tmp, out = "timetree_plot.pdf", width = 14, height = 10,
    tree_index = NULL, multi_tree_mode = "error",
    rank = "none", clade = NULL, strict = FALSE,
    taxonomy_format = "auto", taxonomy_file = NULL, taxonomy_file_sep = "auto",
    taxonomy_file_header = FALSE, no_taxonomy_file_priority = FALSE,
    triangle_mode = "mixed", space_mode = "proportional",
    layout = "rectangular", unit = "auto", angle = 360, line_width = 1,
    ignore_branch_length = FALSE,
    color_rank = NULL, timescale_mode = "radial",
    timescale_position = "right", tree_start_position = "right",
    color_palette = "viridis", color_mapping = NULL,
    show_tip_labels = FALSE, tip_label_size = 2, show_clade_label = FALSE,
    no_clade_count = FALSE, clade_label_offset = 50, clade_label_fontsize = 3,
    show_support = FALSE, support_threshold = 0.95, show_hpd = FALSE,
    hpd_color = "firebrick", legend_position = "bottom",
    legend_nrow = NULL, legend_ncol = NULL, no_timescale = FALSE,
    timescale_levels = "eras,eons", geo_events = FALSE,
    highlight = NULL, highlight_alpha = 0.2, main_title = NULL, sub_title = NULL,
    log_level = "INFO", log_file = NULL, taxonomy_delimiter_mode = "reverse",
    taxonomy_source_priority = "table", taxonomy_table_sep = ";",
    taxonomy_levels = NULL, mol_type = "auto", skip_length_check = FALSE,
    no_cross_check = FALSE, sequence_file = NULL, force = FALSE,
    no_clobber = FALSE, ignore_malformed = FALSE, low_memory = FALSE,
    check = FALSE, strip_annotations = FALSE, config = NULL,
    version = FALSE, help = FALSE
  )

  errs_with_ts <- Rclade:::validate_cli_params(base_opt)
  expect_true(any(grepl("--unit", errs_with_ts)))

  base_opt$no_timescale <- TRUE
  errs_no_ts <- Rclade:::validate_cli_params(base_opt)
  expect_false(any(grepl("--unit", errs_no_ts)))
})
