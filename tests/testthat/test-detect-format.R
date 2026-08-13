# Pure-unit coverage for tree-format detection (E-T6):
# extension-based detection, content-based fallback probing, and the
# empty-file read error. No external data required.

write_tree_file <- function(content, ext) {
  p <- tempfile(fileext = ext)
  writeLines(content, p)
  p
}

test_that("detect_tree_format detects by extension", {
  expect_equal(Rclade:::detect_tree_format(write_tree_file("t", ".nwk")), "newick")
  expect_equal(Rclade:::detect_tree_format(write_tree_file("t", ".tre")), "newick")
  expect_equal(Rclade:::detect_tree_format(write_tree_file("t", ".nex")), "nexus")
  expect_equal(Rclade:::detect_tree_format(write_tree_file("t", ".xml")), "beast")
  expect_equal(Rclade:::detect_tree_format(write_tree_file("t", ".nhx")), "newick")
})

test_that("detect_tree_format falls back to content probing", {
  # Extension-unknown files are probed by content.
  expect_equal(Rclade:::detect_tree_format(write_tree_file("#NEXUS", ".txt")), "nexus")
  expect_equal(Rclade:::detect_tree_format(write_tree_file("<beast>", ".txt")), "beast")
  expect_equal(Rclade:::detect_tree_format(write_tree_file("((a,b),(c,d));", ".txt")),
              "newick")
})

test_that("detect_tree_format errors on empty file", {
  # NOTE: write_tree_file("", ".nwk") writes a 1-byte newline, which is NOT a
  # truly empty file (detect_tree_format guards on file_size == 0). Create a
  # genuinely 0-byte file so the empty-file guard triggers Rclade_read_error.
  p <- tempfile(fileext = ".nwk")
  file.create(p)
  expect_error(Rclade:::detect_tree_format(p), class = "Rclade_read_error")
})
