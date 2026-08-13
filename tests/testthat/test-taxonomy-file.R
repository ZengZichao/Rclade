# Tests for taxonomy file reading functionality

test_that("read_taxonomy_file reads tab-delimited file", {
  # Create a temporary taxonomy file
  temp_file <- tempfile(fileext = ".tsv")
  writeLines(c(
    "tip1\td__D1;p__P1;c__C1;o__O1;f__F1;g__G1;s__S1",
    "tip2\td__D1;p__P2;c__C3;o__O3;f__F3;g__G5;s__S5",
    "tip3\td__D2;p__P6;c__C12;o__O4;f__F4;g__G6;s__"
  ), temp_file)

  result <- read_taxonomy_file(temp_file)

  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 3)
  expect_true("label" %in% names(result))
  expect_true("domain" %in% names(result))
  expect_true("phylum" %in% names(result))
  expect_equal(result$label[1], "tip1")
  expect_equal(result$domain[1], "D1")
  expect_equal(result$phylum[1], "P1")
  expect_equal(result$species[3], NA_character_)  # Missing species

  unlink(temp_file)
})

test_that("read_taxonomy_file reads comma-delimited file", {
  # Create a temporary taxonomy file
  temp_file <- tempfile(fileext = ".csv")
  writeLines(c(
    "tip1,d__D1;p__P1;c__C1",
    "tip2,d__D1;p__P2;c__C3"
  ), temp_file)

  result <- read_taxonomy_file(temp_file)

  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 2)
  expect_equal(result$label[1], "tip1")
  expect_equal(result$domain[1], "D1")

  unlink(temp_file)
})

test_that("read_taxonomy_file validates file existence", {
  expect_error(read_taxonomy_file("nonexistent_file.tsv"),
               "Taxonomy file not found")
})

test_that("read_taxonomy_file handles empty ranks", {
  # Create a file with missing species
  temp_file <- tempfile(fileext = ".tsv")
  writeLines(c(
    "tip1\td__D1;p__P1;c__C1;o__;f__;g__;s__"
  ), temp_file)

  result <- read_taxonomy_file(temp_file)

  expect_equal(result$domain[1], "D1")
  expect_equal(result$order[1], NA_character_)  # Empty after prefix
  expect_equal(result$species[1], NA_character_)

  unlink(temp_file)
})

test_that("summarize_taxonomy_quality_with_file reports correctly", {
  # Create a temporary taxonomy file
  temp_file <- tempfile(fileext = ".tsv")
  writeLines(c(
    "tip1\td__D1;p__P1;c__C1",
    "tip2\td__D2;p__P6;c__C12"
  ), temp_file)

  labels <- c("tip1", "tip2")

  # Use capture.output to check for cat output
  output <- capture.output(
    summarize_taxonomy_quality_with_file(labels, format = "GTDB",
                                          taxonomy_file = temp_file)
  )

  expect_true(length(output) > 0)
  expect_true(any(grepl("Taxonomy Label Parsing Quality Report", output)))

  unlink(temp_file)
})
