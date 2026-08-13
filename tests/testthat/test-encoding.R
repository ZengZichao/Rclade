# Tests for encoding and cross-platform utilities

test_that("build_path constructs paths correctly", {
  expect_equal(build_path("data", "output", "file.pdf"),
               file.path("data", "output", "file.pdf"))
  expect_equal(build_path("~", "projects"),
               file.path("~", "projects"))
})

test_that("normalize_newlines converts line endings", {
  expect_equal(Rclade:::normalize_newlines("line1\r\nline2"), "line1\nline2")
  expect_equal(Rclade:::normalize_newlines("line1\rline2"), "line1\nline2")
  expect_equal(Rclade:::normalize_newlines("line1\nline2"), "line1\nline2")
})

test_that("write_file_utf8 and read_file_utf8 round-trip", {
  tmp <- managed_tempfile(pattern = "test_encoding_", fileext = ".txt")

  content <- c("Line 1 with special chars: \u00e9\u00e8\u00ea",
               "Line 2: \u00fc\u00f6\u00e4",
               "Line 3: normal text")

  Rclade:::write_file_utf8(tmp$path, content)
  result <- Rclade:::read_file_utf8(tmp$path)

  expect_equal(length(result), 3)
  expect_true(any(grepl("\u00e9", result)))

  tmp$cleanup()
})

test_that("write_file_utf8 normalizes line endings", {
  tmp <- managed_tempfile(pattern = "test_newline_", fileext = ".txt")

  content <- "line1\r\nline2\rline3\nline4"
  Rclade:::write_file_utf8(tmp$path, content)

  raw <- readBin(tmp$path, "raw", 100)
  # Should not contain \r
  expect_false(as.raw(0x0d) %in% raw)

  tmp$cleanup()
})

test_that("managed_tempfile creates and cleans up", {
  tmp_path <- NULL
  {
    tmp <- managed_tempfile(pattern = "test_", fileext = ".tmp")
    tmp_path <- tmp$path
    expect_true(nchar(tmp_path) > 0)
    expect_true(grepl("test_", tmp_path))
    expect_true(grepl("\\.tmp$", tmp_path))
    tmp$cleanup()
  }
  expect_false(file.exists(tmp_path))
})

test_that("managed_tempdir creates and cleans up", {
  tmp_path <- NULL
  {
    tmp <- managed_tempdir(pattern = "testdir_")
    tmp_path <- tmp$path
    expect_true(dir.exists(tmp_path))
    tmp$cleanup()
  }
  expect_false(dir.exists(tmp_path))
})

test_that("detect_encoding identifies UTF-8", {
  tmp <- managed_tempfile(pattern = "test_enc_", fileext = ".txt")
  writeLines("Hello \u00e9\u00e8", tmp$path, useBytes = FALSE)
  enc <- detect_encoding(tmp$path)
  expect_true(enc %in% c("UTF-8", "UTF-8-BOM"))
  tmp$cleanup()
})

test_that("read_file_utf8 handles BOM", {
  tmp <- managed_tempfile(pattern = "test_bom_", fileext = ".txt")
  # Write UTF-8 with BOM
  raw <- charToRaw("\uFEFFHello\nWorld")
  writeBin(raw, tmp$path)

  lines <- Rclade:::read_file_utf8(tmp$path)
  expect_equal(lines[1], "Hello")
  expect_equal(lines[2], "World")

  tmp$cleanup()
})

test_that("Rclade:::ensure_dir creates directory", {
  tmp <- managed_tempdir()
  new_dir <- file.path(tmp$path, "sub1", "sub2")
  Rclade:::ensure_dir(new_dir)
  expect_true(dir.exists(new_dir))
  tmp$cleanup()
})

test_that("normalize_file_newlines works", {
  tmp <- managed_tempfile(pattern = "test_norm_", fileext = ".txt")
  writeBin(charToRaw("line1\r\nline2\rline3\n"), tmp$path)

  normalize_file_newlines(tmp$path)

  raw <- readBin(tmp$path, "raw", 100)
  expect_false(as.raw(0x0d) %in% raw)

  tmp$cleanup()
})
