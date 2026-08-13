# Tests for taxonomy parsing

test_that("GTDB format parsing works", {
  labels <- c("d__D1;p__P1;c__C1",
              "d__D1;p__P2;c__C3")
  result <- Rclade:::parse_gtdb(labels)
  expect_equal(result$domain, c("D1", "D1"))
  expect_equal(result$phylum, c("P1", "P2"))
  expect_equal(result$class, c("C1", "C3"))
})

test_that("Silva format parsing works", {
  labels <- c("D1;P1;C1",
              "D1;P2;C3")
  result <- Rclade:::parse_silva(labels)
  expect_equal(result$domain, c("D1", "D1"))
  expect_equal(result$phylum, c("P1", "P2"))
  expect_equal(result$class, c("C1", "C3"))
})

test_that("Silva parser preserves empty segments as NA", {
  labels <- c("D1;;C1")
  result <- Rclade:::parse_silva(labels)
  expect_equal(result$domain, "D1")
  expect_true(is.na(result$phylum))
  expect_equal(result$class, "C1")
})

test_that("Silva parser handles various cases of 'unclassified'", {
  labels <- c("UNCLASSIFIED;P1", "unclassified;P2",
              "Unclassified;P3")
  result <- Rclade:::parse_silva(labels)
  expect_true(all(is.na(result$domain)))
  expect_equal(result$phylum, c("P1", "P2", "P3"))
})

test_that("NCBI format skips 'cellular organisms'", {
  labels <- c("cellular organisms;D1;P1",
              "cellular organisms;D3;P8")
  result <- suppressWarnings(Rclade:::parse_ncbi(labels))
  expect_equal(result$domain, c("D1", "D3"))
  expect_equal(result$phylum, c("P1", "P8"))
})

test_that("NCBI format handles case-insensitive 'Viruses'", {
  labels <- c("Viruses;D4;P9",
              "viruses;D5;P10")
  result <- suppressWarnings(Rclade:::parse_ncbi(labels))
  expect_equal(result$domain[1], "D4")
  expect_equal(result$domain[2], "D5")
})

test_that("auto-detect works for GTDB labels", {
  labels <- c(rep("d__D1;p__P1", 9), "garbage_label")
  expect_equal(Rclade:::detect_taxonomy_format(labels), "GTDB")
})

test_that("auto-detect correctly distinguishes Silva from NCBI", {
  silva_labels <- c("Bacteria;P1", "Archaea;P2")
  expect_equal(Rclade:::detect_taxonomy_format(silva_labels), "Silva")

  ncbi_labels <- c("cellular organisms;D1;P1",
                   "cellular organisms;D2;P2")
  expect_equal(Rclade:::detect_taxonomy_format(ncbi_labels), "NCBI")
})

test_that("incomplete labels return NA", {
  labels <- c("d__D1;p__P1;c__C1",
              "d__D1;p__P2")
  result <- Rclade:::parse_gtdb(labels)
  expect_true(is.na(result$class[2]))
})

test_that("small tree uses all labels for detection", {
  labels <- c("d__D1;p__P1", "d__D1;p__P2",
              "d__D1;p__P3", "d__D2;p__P6",
              "d__D2;p__P7")
  expect_equal(Rclade:::detect_taxonomy_format(labels), "GTDB")
})

test_that("parse_taxonomy returns correct structure", {
  labels <- c("d__D1;p__P1", "d__D1;p__P2")
  result <- Rclade:::parse_taxonomy(labels, "phylum", format = "GTDB")
  expect_s3_class(result, "data.frame")
  expect_equal(names(result), c("label", "Group"))
  expect_equal(result$Group, c("P1", "P2"))
})
