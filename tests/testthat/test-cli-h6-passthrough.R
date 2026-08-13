# Regression test for H6 (T08): CLI four-parameter pass-through.
#
# These four visualization parameters must be exposed on the CLI (option_list),
# parsed in build_plot_timetree_params(), and passed straight through to
# plot_timetree() / pt_single_tree() (which already declare them in their
# signatures — pipeline is unchanged per architecture decision ②).
#
# This test guards against a regression where the CLI option_list or the
# build function silently drops one of these identifiers (the original
# "H6 missed" defect). It is pure-unit: it only exercises the opt -> params
# mapping, not the full plotting pipeline.

# Build a complete default `opt` list mirroring run_rclade_cli()'s
# option_list defaults, so build_plot_timetree_params() has every field it
# reads. Used by the H6 pass-through assertion below.
.default_cli_opt <- function(overrides = list()) {
  opt <- list(
    file = NULL, out = "timetree_plot.pdf", width = 14, height = 10,
    tree_index = NULL, multi_tree_mode = "error",
    rank = "none", clade = NULL, strict = FALSE,
    taxonomy_format = "auto", taxonomy_file = NULL, taxonomy_file_sep = "auto",
    taxonomy_file_header = FALSE, no_taxonomy_file_priority = FALSE,
    triangle_mode = "mixed", space_mode = "proportional",
    layout = "rectangular", unit = "Ga", angle = 360, line_width = 1,
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
  for (nm in names(overrides)) {
    opt[[nm]] <- overrides[[nm]]
  }
  opt
}

test_that("H6: build_plot_timetree_params passes through the four CLI params", {
  opt <- .default_cli_opt(list(
    color_rank = "species",
    timescale_mode = "linear",
    timescale_position = "bottom",
    tree_start_position = "top"
  ))

  params <- Rclade:::build_plot_timetree_params(
    opt,
    color_palette = "viridis",
    color_mapping = NULL,
    taxonomy_levels = NULL
  )

  # The four H6 identifiers must be present and carry the parsed values.
  expect_true("color_rank" %in% names(params))
  expect_true("timescale_mode" %in% names(params))
  expect_true("timescale_position" %in% names(params))
  expect_true("tree_start_position" %in% names(params))

  expect_identical(params$color_rank, "species")
  expect_identical(params$timescale_mode, "linear")
  expect_identical(params$timescale_position, "bottom")
  expect_identical(params$tree_start_position, "top")
})

test_that("H6: default (NULL/absent) pass-through keeps upstream defaults", {
  # With no overrides, color_rank should be NULL and the timescale enums
  # should carry their built-in defaults so plot_timetree() is unaffected.
  opt <- .default_cli_opt()

  params <- Rclade:::build_plot_timetree_params(
    opt,
    color_palette = "viridis",
    color_mapping = NULL,
    taxonomy_levels = NULL
  )

  expect_null(params$color_rank)
  expect_identical(params$timescale_mode, "radial")
  expect_identical(params$timescale_position, "right")
  expect_identical(params$tree_start_position, "right")
})
