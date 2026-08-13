# Tests for deep input validation

# --- Newick syntax validation ---

test_that("validate_newick_syntax accepts valid Newick", {
  expect_silent(Rclade:::validate_newick_syntax("(A:1,B:1):1;", "test"))
  expect_silent(Rclade:::validate_newick_syntax("((A:1,B:2):3,(C:4,D:5):6):0;", "test"))
})

test_that("validate_newick_syntax rejects empty string", {
  expect_error(Rclade:::validate_newick_syntax("", "test"), "empty")
  expect_error(Rclade:::validate_newick_syntax("   ", "test"), "empty")
})

test_that("validate_newick_syntax detects unmatched brackets", {
  expect_error(Rclade:::validate_newick_syntax("(A:1,B:1;", "test"), "unmatched")
  expect_error(Rclade:::validate_newick_syntax("A:1,B:1):1;", "test"), "unmatched")
  expect_error(Rclade:::validate_newick_syntax("((A:1):1;", "test"), "unmatched")
})

test_that("validate_newick_syntax detects negative branch lengths", {
  expect_error(Rclade:::validate_newick_syntax("(A:-1,B:1):1;", "test"), "Negative")
  expect_error(Rclade:::validate_newick_syntax("(A:1,B:-0.5):1;", "test"), "Negative")
})

test_that("validate_newick_syntax warns about duplicate names", {
  # E-T3 regression: warnings are routed through log_warning() -> message(),
  # so capture the message stream instead of using expect_warning(). The
  # rclade.log_level option (honoured after fix A) makes this robust against
  # .logger_env$level state leaked from other tests. Scoped so it cannot leak.
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(Rclade:::validate_newick_syntax("(A:1,A:1):1;", "test"))
    expect_true(grepl("duplicate", msgs, fixed = TRUE))
  })
})

test_that("validate_newick_syntax warns about missing semicolon", {
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(Rclade:::validate_newick_syntax("(A:1,B:1):1", "test"))
    expect_true(grepl("does not end with", msgs, fixed = TRUE))
  })
})

# --- Deep tree validation ---

test_that("validate_tree_deep accepts valid tree", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  expect_silent(Rclade:::validate_tree_deep(tree, "test"))
})

test_that("validate_tree_deep detects self-loops", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  # Manually create a self-loop
  tree$edge <- rbind(tree$edge, c(3, 3))
  expect_error(Rclade:::validate_tree_deep(tree, "test"), "self-loop")
})

test_that("validate_tree_deep detects negative branch lengths", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$edge.length[1] <- -0.5
  expect_error(Rclade:::validate_tree_deep(tree, "test"), "Negative")
})

test_that("validate_tree_deep detects empty tip labels", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$tip.label[1] <- ""
  expect_error(Rclade:::validate_tree_deep(tree, "test"), "empty tip label")
})

test_that("validate_tree_deep warns on duplicate tip labels", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  tree$tip.label[1] <- "B"
  # B: duplicate tip labels were demoted from rlang::abort (ERROR) to a
  # log_warning() -> message(); use capture_messages + grepl to assert.
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(Rclade:::validate_tree_deep(tree, "test"))
    expect_true(grepl("duplicate", msgs, fixed = TRUE))
  })
})

# --- Alphabet detection ---

test_that("detect_alphabet identifies DNA", {
  expect_equal(Rclade:::detect_alphabet(c("A", "C", "G", "T")), "DNA")
  expect_equal(Rclade:::detect_alphabet(c("A", "C", "G", "T", "N")), "DNA")
})

test_that("detect_alphabet identifies RNA", {
  expect_equal(Rclade:::detect_alphabet(c("A", "C", "G", "U")), "RNA")
})

test_that("detect_alphabet identifies protein", {
  expect_equal(Rclade:::detect_alphabet(c("A", "C", "G", "T", "L", "F")), "protein")
})

test_that("detect_alphabet returns unknown for empty input", {
  expect_equal(Rclade:::detect_alphabet(character(0)), "unknown")
})

# --- Sequence format detection ---

test_that("detect_sequence_format identifies FASTA", {
  temp_file <- tempfile(fileext = ".fasta")
  writeLines(c(">seq1", "ACGT"), temp_file)
  expect_equal(Rclade:::detect_sequence_format(temp_file), "fasta")
  unlink(temp_file)
})

test_that("detect_sequence_format identifies FASTQ", {
  temp_file <- tempfile(fileext = ".fastq")
  writeLines(c("@seq1", "ACGT", "+", "IIII"), temp_file)
  expect_equal(Rclade:::detect_sequence_format(temp_file), "fastq")
  unlink(temp_file)
})

# --- Deep sequence validation ---

test_that("validate_sequence_deep validates FASTA", {
  temp_file <- tempfile(fileext = ".fasta")
  writeLines(c(">seq1", "ACGTACGT", ">seq2", "TTTTAAAA"), temp_file)
  result <- validate_sequence_deep(temp_file, expected_alphabet = "DNA")
  expect_equal(result$format, "fasta")
  expect_equal(result$n_sequences, 2)
  expect_equal(result$alphabet, "DNA")
  unlink(temp_file)
})

test_that("validate_sequence_deep detects duplicate IDs", {
  temp_file <- tempfile(fileext = ".fasta")
  writeLines(c(">seq1", "ACGT", ">seq1", "TTTT"), temp_file)
  expect_error(validate_sequence_deep(temp_file), "Duplicate")
  unlink(temp_file)
})

test_that("validate_sequence_deep detects invalid characters", {
  temp_file <- tempfile(fileext = ".fasta")
  writeLines(c(">seq1", "ACGT123"), temp_file)
  # E-T3 regression: routed through log_warning() -> message(). Scoped so the
  # option cannot leak into later tests (fix A makes the logger honour it).
  withr::with_options(list(rclade.log_level = "WARNING"), {
    msgs <- capture_messages(validate_sequence_deep(temp_file))
    expect_true(grepl("Invalid", msgs, fixed = TRUE))
  })
  unlink(temp_file)
})

test_that("validate_sequence_deep checks alignment", {
  temp_file <- tempfile(fileext = ".fasta")
  writeLines(c(">seq1", "ACGT", ">seq2", "ACGTACGT"), temp_file)
  result <- suppressWarnings(validate_sequence_deep(temp_file, check_alignment = TRUE))
  expect_false(result$alignment_ok)
  unlink(temp_file)
})
