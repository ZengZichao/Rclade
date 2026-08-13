# Pure-unit coverage for sequence validation (E-T6):
# FASTQ / protein alphabet branches, duplicate-ID rejection, and
# Stockholm / PHYLIP format rejection. No external data required.

make_fasta <- function(lines, ext = ".fasta") {
  p <- tempfile(fileext = ext)
  writeLines(lines, p)
  p
}

test_that("detect_sequence_format recognizes FASTA and FASTQ by content", {
  fa <- make_fasta(c(">s1", "ACGTACGT", ">s2", "TTGGCCAA"))
  expect_equal(Rclade:::detect_sequence_format(fa), "fasta")
  fq <- make_fasta(
    c("@r1", "ACGTACGT", "+", "!!!!!!!!", "@r2", "TTGGCCAA", "+", "!!!!!!!!"),
    ext = ".fastq")
  expect_equal(Rclade:::detect_sequence_format(fq), "fastq")
  unlink(c(fa, fq))
})

test_that("validate_sequence_deep detects protein alphabet", {
  p <- make_fasta(c(">prot1", "MALFWYQRGKE", ">prot2", "PEPTIDEKQRG"))
  res <- Rclade:::validate_sequence_deep(p)
  expect_equal(res$format, "fasta")
  expect_equal(res$n_sequences, 2)
  expect_equal(res$alphabet, "protein")
  unlink(p)
})

test_that("validate_sequence_deep detects DNA alphabet", {
  p <- make_fasta(c(">dna1", "ACGTACGTACGT", ">dna2", "TTGGCCAATTCG"))
  res <- Rclade:::validate_sequence_deep(p)
  expect_equal(res$alphabet, "DNA")
  unlink(p)
})

test_that("validate_sequence_deep rejects duplicate sequence IDs", {
  p <- make_fasta(c(">dup", "ACGT", ">dup", "TGCA"))
  expect_error(Rclade:::validate_sequence_deep(p), class = "Rclade_validate_error")
  unlink(p)
})

test_that("validate_sequence_deep rejects Stockholm alignment", {
  p <- make_fasta(c("# STOCKHOLM 1.0", "//"), ext = ".sto")
  expect_error(Rclade:::validate_sequence_deep(p), class = "Rclade_validate_error")
  unlink(p)
})

test_that("validate_sequence_deep rejects PHYLIP-style header", {
  p <- make_fasta(c("2 10", "seq1 ACGTACGTAC", "seq2 TGGCAACGTT"))
  expect_error(Rclade:::validate_sequence_deep(p), class = "Rclade_validate_error")
  unlink(p)
})

test_that("validate_sequence_deep parses FASTQ records", {
  p <- make_fasta(
    c("@r1", "ACGTACGT", "+", "!!!!!!!!", "@r2", "TTGGCCAA", "+", "!!!!!!!!"),
    ext = ".fastq")
  res <- Rclade:::validate_sequence_deep(p)
  expect_equal(res$format, "fastq")
  expect_equal(res$n_sequences, 2)
  expect_equal(res$alphabet, "DNA")
  unlink(p)
})
