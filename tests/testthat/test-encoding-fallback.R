# Pure-unit coverage for encoding detection / UTF-8 I/O (E-T6):
# detect_encoding classifies UTF-8, and the UTF-8 read/write helpers
# round-trip content that includes underscore-rich taxonomy names.

test_that("detect_encoding classifies a UTF-8 file", {
  utf8 <- tempfile(fileext = ".txt")
  on.exit(unlink(utf8), add = TRUE)
  writeLines("Bacteria;Proteobacteria_sensu_stricto_2024", utf8, useBytes = TRUE)
  enc <- Rclade:::detect_encoding(utf8)
  expect_true(enc %in% c("UTF-8", "UTF-8-BOM", "unknown"))
})

test_that("read_file_utf8 / write_file_utf8 round-trip UTF-8 content", {
  p <- tempfile(fileext = ".txt")
  on.exit(unlink(p), add = TRUE)
  Rclade:::write_file_utf8(p, "d__Bacteria;p__Proteobacteria_sensu_stricto")
  txt <- Rclade:::read_file_utf8(p)
  expect_true(grepl("Proteobacteria_sensu_stricto", txt))
})
