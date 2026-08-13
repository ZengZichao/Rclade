# Tests for adversarial input protection

# --- Empty file validation ---

test_that("validate_file_not_empty rejects empty files", {
  tmp <- managed_tempfile(pattern = "empty_", fileext = ".txt")
  writeBin(raw(0), tmp$path)
  expect_error(Rclade:::validate_file_not_empty(tmp$path, "Test"), "CRITICAL")
  tmp$cleanup()
})

test_that("validate_file_not_empty accepts non-empty files", {
  tmp <- managed_tempfile(pattern = "nonempty_", fileext = ".txt")
  writeLines("content", tmp$path)
  expect_silent(Rclade:::validate_file_not_empty(tmp$path, "Test"))
  tmp$cleanup()
})

# --- Malicious character detection ---

test_that("check_malicious_chars detects BiDi markers", {
  bad_name <- paste0("tip", "\u202E", "1")
  expect_error(Rclade:::check_malicious_chars(bad_name, "test"), "bidirectional")
})

test_that("check_malicious_chars accepts clean names", {
  clean_names <- c("tip1", "tip2", "GB_GCA_0001", "D1")
  expect_silent(Rclade:::check_malicious_chars(clean_names, "test"))
})

test_that("check_malicious_chars warns about zero-width characters", {
  bad_name <- paste0("tip", "\u200B", "1")
  # E-T3: warnings are now routed through log_warning() (emitted via message()).
  # Scope the option so it cannot leak into later tests (after fix A the logger
  # actually honours rclade.log_level, so a global set would suppress INFO
  # messages elsewhere in the suite).
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(Rclade:::check_malicious_chars(bad_name, "test"))
    expect_true(grepl("Zero-width", msgs, fixed = TRUE))
  })
})

# --- Circular dependency detection ---

test_that("find_rank_cycles detects simple cycle", {
  df <- data.frame(
    domain = c("A", "B"),
    phylum = c("B", "A"),
    stringsAsFactors = FALSE
  )
  cycles <- Rclade:::find_rank_cycles(df, "domain", "phylum")
  expect_true(length(cycles) > 0)
})

test_that("find_rank_cycles returns empty for no cycles", {
  df <- data.frame(
    domain = c("A", "A", "B"),
    phylum = c("X", "Y", "Z"),
    stringsAsFactors = FALSE
  )
  cycles <- Rclade:::find_rank_cycles(df, "domain", "phylum")
  expect_equal(length(cycles), 0)
})

test_that("validate_taxonomy_no_cycles detects cycles", {
  df <- data.frame(
    label = c("tip1", "tip2"),
    domain = c("D1", "P1"),
    phylum = c("P1", "D1"),
    class = c("C1", "C2"),
    stringsAsFactors = FALSE
  )
  expect_error(validate_taxonomy_no_cycles(df, "test"), "Circular dependency")
})

test_that("validate_taxonomy_no_cycles accepts valid taxonomy", {
  df <- data.frame(
    label = c("tip1", "tip2"),
    domain = c("D1", "D1"),
    phylum = c("P1", "P2"),
    class = c("C1", "C3"),
    stringsAsFactors = FALSE
  )
  expect_silent(validate_taxonomy_no_cycles(df, "test"))
})

# --- Empty tree file ---

test_that("read_tree_auto rejects empty tree files", {
  tmp <- managed_tempfile(pattern = "empty_tree_", fileext = ".nwk")
  writeBin(raw(0), tmp$path)
  expect_error(Rclade:::read_tree_auto(tmp$path), "CRITICAL")
  tmp$cleanup()
})

# --- BiDi in tree labels ---

test_that("validate_tree_deep rejects BiDi markers in labels", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$tip.label[1] <- paste0("tip", "\u202E", "1")
  expect_error(Rclade:::validate_tree_deep(tree, "test"), "bidirectional")
})

# --- Newick BiDi characters ---

test_that("validate_newick_syntax rejects BiDi markers", {
  bad_newick <- paste0("(tip", "\u202E", "1:1,tip2:1):1;")
  expect_error(Rclade:::validate_newick_syntax(bad_newick, "test"), "bidirectional")
})

# --- Clean Newick passes ---

test_that("validate_newick_syntax accepts clean input", {
  good_newick <- "(A:1,B:1):1;"
  expect_silent(Rclade:::validate_newick_syntax(good_newick, "test"))
})

# --- Control character detection via raw bytes ---

test_that("check_malicious_chars detects control characters via raw", {
  # Create a name with embedded control char using raw
  name_bytes <- charToRaw("tip1")
  # Insert a control character (0x01)
  bad_bytes <- c(name_bytes[1:2], as.raw(0x01), name_bytes[3:4])
  bad_name <- rawToChar(bad_bytes)
  expect_error(Rclade:::check_malicious_chars(bad_name, "test"), "control characters")
})
