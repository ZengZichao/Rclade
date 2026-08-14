# Helper: make internalized functions available in test environment
# (R CMD check runs tests with only exported namespace; devtools::test() uses
# the full namespace. This helper bridges the gap.)

# Ensure the package namespace AND search path are available. test_dir() /
# test_check() do not always attach the package (scripts/ci_pure_unit.R uses
# test_dir() without a package argument), so exported functions like
# plot_timetree() and bundled datasets like example_tree would otherwise be
# invisible ("could not find function ..." / "data set 'example_tree' not
# found" on devel/min-deps CI). library() is idempotent, so this is safe in
# every context.
if (!"package:Rclade" %in% search()) {
  suppressPackageStartupMessages(library(Rclade))
}

# Internal functions used directly in tests:
with_graceful_interrupt <- Rclade:::with_graceful_interrupt
batch_with_interrupt <- Rclade:::batch_with_interrupt
generate_colors <- Rclade:::generate_colors
log_debug <- Rclade:::log_debug
log_info <- Rclade:::log_info
log_warning <- Rclade:::log_warning
log_error <- Rclade:::log_error
log_critical <- Rclade:::log_critical
log_section <- Rclade:::log_section
log_subsection <- Rclade:::log_subsection
log_progress <- Rclade:::log_progress
log_stats <- Rclade:::log_stats
log_table <- Rclade:::log_table
log_keyvalue <- Rclade:::log_keyvalue
timer_start <- Rclade:::timer_start
timer_stop <- Rclade:::timer_stop
managed_tempfile <- Rclade:::managed_tempfile
managed_tempdir <- Rclade:::managed_tempdir
build_path <- Rclade:::build_path
detect_encoding <- Rclade:::detect_encoding
normalize_file_newlines <- Rclade:::normalize_file_newlines
resolve_special_identifier <- Rclade:::resolve_special_identifier
resolve_group <- Rclade:::resolve_group
validate_custom_groups <- Rclade:::validate_custom_groups
validate_taxonomy_no_cycles <- Rclade:::validate_taxonomy_no_cycles
build_group_vec <- Rclade:::build_group_vec
split_legend <- Rclade:::split_legend

# Additional internals exercised directly by the suite. These must be mapped
# here (not just available in the namespace) because scripts/ci_pure_unit.R
# and the CI test_file() step run test_dir()/test_file() whose test
# environment is the global environment — unlike R CMD check, it does NOT
# inherit the package namespace, so unexported functions would otherwise be
# invisible ("could not find function ...").
add_hpd_range <- Rclade:::add_hpd_range
add_smart_legend <- Rclade:::add_smart_legend
add_support_labels <- Rclade:::add_support_labels
annotate_clade <- Rclade:::annotate_clade
build_base_tree <- Rclade:::build_base_tree
build_plot_timetree_params <- Rclade:::build_plot_timetree_params
check_malicious_chars <- Rclade:::check_malicious_chars
cleanup_on_interrupt <- Rclade:::cleanup_on_interrupt
compute_legend_layout <- Rclade:::compute_legend_layout
compute_mrca_map <- Rclade:::compute_mrca_map
compute_time_breaks <- Rclade:::compute_time_breaks
compute_x_min <- Rclade:::compute_x_min
convert_unit <- Rclade:::convert_unit
detect_alphabet <- Rclade:::detect_alphabet
detect_sequence_format <- Rclade:::detect_sequence_format
detect_tree_format <- Rclade:::detect_tree_format
ensure_dir <- Rclade:::ensure_dir
find_rank_cycles <- Rclade:::find_rank_cycles
get_progress_summary <- Rclade:::get_progress_summary
get_rank_name <- Rclade:::get_rank_name
init_progress_tracking <- Rclade:::init_progress_tracking
normalize_newlines <- Rclade:::normalize_newlines
normalize_rank <- Rclade:::normalize_rank
parse_gtdb <- Rclade:::parse_gtdb
parse_ncbi <- Rclade:::parse_ncbi
parse_silva <- Rclade:::parse_silva
parse_taxonomy_with_file <- Rclade:::parse_taxonomy_with_file
prepare_geo_timescales <- Rclade:::prepare_geo_timescales
pt_single_tree <- Rclade:::pt_single_tree
read_file_utf8 <- Rclade:::read_file_utf8
update_progress <- Rclade:::update_progress
validate_file_not_empty <- Rclade:::validate_file_not_empty
validate_inputs <- Rclade:::validate_inputs
validate_newick_syntax <- Rclade:::validate_newick_syntax
validate_tree_deep <- Rclade:::validate_tree_deep
write_file_utf8 <- Rclade:::write_file_utf8

# Shared guard for vdiffr visual-regression tests (test-straight-vdiffr.R).
# Defined here (instead of inside the test file) so that:
#   1. the path resolves via testthat::test_path() regardless of the working
#      directory (R CMD check runs with wd = tests/, test_dir() with the repo
#      root), and
#   2. the helper is loaded before any test file runs.
skip_if_missing_vdiffr_snapshots <- function() {
  if (!requireNamespace("vdiffr", quietly = TRUE)) {
    skip("vdiffr not installed")
  }
  # Escape hatch: RCLADE_SNAPSHOT_CREATE=1 forces the snapshot tests to run so
  # vdiffr can (re)generate the baseline PNGs; the skip below would otherwise
  # prevent creation forever.
  if (identical(Sys.getenv("RCLADE_SNAPSHOT_CREATE"), "1")) {
    return(invisible(TRUE))
  }
  snap_dir <- testthat::test_path("_snaps")
  if (!dir.exists(snap_dir) ||
      length(list.files(snap_dir, pattern = "\\.(png|svg)$", recursive = TRUE)) == 0) {
    skip("vdiffr snapshots missing; regenerate via testthat::snapshot_accept('straight-vdiffr')")
  }
}
