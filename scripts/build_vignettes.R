#!/usr/bin/env Rscript
## Build vignettes into inst/doc so CRAN finds pre-built vignette HTML files.
## This is required because the package uses a VignetteBuilder field.

pkg_root <- normalizePath(".", winslash = "/")
vignettes <- c("quick_start", "publication_ready", "taxonomy_formats")

## Create inst/doc directory
dir.create(file.path(pkg_root, "inst", "doc"), showWarnings = FALSE, recursive = TRUE)

## Build each vignette
for (v in vignettes) {
  cat("Building", v, "...\n")
  rmarkdown::render(
    input = file.path(pkg_root, "vignettes", paste0(v, ".Rmd")),
    output_format = "rmarkdown::html_vignette",
    output_file = paste0(v, ".html"),
    output_dir = file.path(pkg_root, "inst", "doc"),
    quiet = TRUE,
    clean = FALSE
  )
  cat("  -> inst/doc/", v, ".html\n", sep = "")
}

## Copy the .Rmd sources to inst/doc (required by R CMD check)
for (v in vignettes) {
  file.copy(
    file.path(pkg_root, "vignettes", paste0(v, ".Rmd")),
    file.path(pkg_root, "inst", "doc"),
    overwrite = TRUE
  )
}

cat("\nDone. Contents of inst/doc:\n")
print(list.files(file.path(pkg_root, "inst", "doc")))
