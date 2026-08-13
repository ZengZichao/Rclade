# Helper: make internalized functions available in test environment
# (R CMD check runs tests with only exported namespace; devtools::test() uses
# the full namespace. This helper bridges the gap.)

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
