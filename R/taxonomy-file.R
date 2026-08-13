# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Taxonomy file reading and parsing

#' Read taxonomy information from a table file
#'
#' Reads taxonomy information from a two-column table file where:
#' \itemize{
#'   \item Column 1: Tip labels (must match tree tip labels)
#'   \item Column 2: Taxonomy strings in GTDB format
#'         (e.g., \code{d__Archaea;p__Thermoproteota;c__Korarchaeia})
#' }
#'
#' Supports tab-delimited or comma-delimited files. Missing ranks are indicated
#' by empty values after the rank prefix (e.g., \code{s__} for missing species).
#'
#' @param file Character. Path to the taxonomy table file.
#' @param sep Character. Column separator. \code{"auto"} auto-detects tab or comma.
#'   Default: \code{"auto"}.
#' @param header Logical. Whether the file has a header row. Default: \code{FALSE}.
#' @param table_sep Character. Separator between taxonomy ranks in the
#'   second column (the taxonomy string). Default: \code{";"}.
#' @return A data.frame with columns:
#'   \describe{
#'     \item{label}{Character. Tip labels from column 1.}
#'     \item{domain}{Character. Domain (d__).}
#'     \item{phylum}{Character. Phylum (p__).}
#'     \item{class}{Character. Class (c__).}
#'     \item{order}{Character. Order (o__).}
#'     \item{family}{Character. Family (f__).}
#'     \item{genus}{Character. Genus (g__).}
#'     \item{species}{Character. Species (s__).}
#'   }
#'   Missing ranks are \code{NA}.
#' @export
#' @examples
#' \dontrun{
#' # Read a tab-delimited taxonomy file
#' taxa <- read_taxonomy_file("taxonomy.tsv")
#'
#' # Read a comma-delimited file with header
#' taxa <- read_taxonomy_file("taxonomy.csv", sep = ",", header = TRUE)
#' }
read_taxonomy_file <- function(file, sep = "auto", header = FALSE, table_sep = ";") {
  if (!file.exists(file)) {
    stop("Taxonomy file not found: '", file, "'", call. = FALSE)
  }

  # Validate file is not empty
  validate_file_not_empty(file, "Taxonomy")

  # Auto-detect separator using UTF-8 reading
  if (sep == "auto") {
    first_lines <- read_file_utf8(file, warn = TRUE)
    first_lines <- head(first_lines, 5)
    if (any(grepl("\t", first_lines))) {
      sep <- "\t"
    } else if (any(grepl(",", first_lines))) {
      sep <- ","
    } else {
      stop("Cannot auto-detect separator. Please specify sep='\\t' or sep=','.",
           call. = FALSE)
    }
  }

  # Read the file with UTF-8 encoding
  df <- tryCatch(
    utils::read.table(file, sep = sep, header = header, stringsAsFactors = FALSE,
                      quote = "", comment.char = "", fill = TRUE,
                      fileEncoding = "UTF-8"),
    error = function(e) {
      # Fallback: try without fileEncoding
      log_warning("UTF-8 read failed for %s, trying default encoding", file,
                  .module = "taxonomy-file/read_taxonomy_file")
      utils::read.table(file, sep = sep, header = header, stringsAsFactors = FALSE,
                        quote = "", comment.char = "", fill = TRUE)
    }
  )

  # Validate columns
  if (ncol(df) < 2) {
    stop("Taxonomy file must have at least 2 columns (tip label, taxonomy string).",
         call. = FALSE)
  }

  # Use first two columns only
  labels <- trimws(df[[1]])
  taxa_strings <- trimws(df[[2]])

  # Parse GTDB-format taxonomy strings
  result <- parse_gtdb(taxa_strings, sep = table_sep)

  result$label <- labels

  rank_cols <- intersect(c("kingdom", "domain", "phylum", "class", "order",
                            "family", "genus", "species", "subspecies"),
                          names(result))
  result <- result[, c("label", rank_cols)]

  # Check for circular dependencies in taxonomy
  validate_taxonomy_no_cycles(result, file)

  return(result)
}


#' Build taxonomy lookup from file
#'
#' Creates a lookup table from a taxonomy file that can be used to supplement
#' or override label-based taxonomy parsing.
#'
#' @param file Character. Path to the taxonomy table file.
#' @param sep Character. Column separator. Default: \code{"auto"}.
#' @param header Logical. Whether the file has a header row. Default: \code{FALSE}.
#' @param table_sep Character. Separator between taxonomy ranks in the second
#'   column. Default: \code{";"}.
#' @return A named list where names are tip labels and values are data.frame rows
#'   with taxonomy information.
#' @keywords internal
build_taxonomy_lookup <- function(file, sep = "auto", header = FALSE, table_sep = ";") {
  taxa_df <- read_taxonomy_file(file, sep, header, table_sep)

  # Create lookup: label -> taxonomy row.
  # Vectorized construction via match/setNames (L-B3): no per-row loop.
  labels <- as.character(taxa_df$label)
  keep <- !is.na(labels) & nchar(labels) > 0
  lookup <- setNames(
    lapply(which(keep), function(i) taxa_df[i, -1, drop = FALSE]),
    labels[keep]
  )

  return(lookup)
}


#' Parse taxonomy with external file support
#'
#' Extended taxonomy parsing that can use an external taxonomy file to supplement
#' or override label-based parsing. Useful when:
#' \itemize{
#'   \item Tip labels lack taxonomy information
#'   \item Only some tips have taxonomy in their labels
#'   \item External taxonomy data is more complete or accurate
#' }
#'
#' @param labels Character vector of tip labels.
#' @param rank Taxonomic rank (abbreviation or full name).
#' @param format Format: "auto", "GTDB", "Silva", "NCBI", "custom_rank", "custom_regex".
#' @param custom_patterns Custom regex patterns (for "custom_regex" format).
#' @param taxonomy_file Character. Path to external taxonomy file. Default: \code{NULL}.
#' @param file_sep Character. Column separator for taxonomy file. Default: \code{"auto"}.
#' @param file_header Logical. Whether taxonomy file has header row. Default: \code{FALSE}.
#' @param file_priority Logical. If \code{TRUE}, file taxonomy takes priority over
#'   label-based parsing. If \code{FALSE}, file is used only for labels that cannot
#'   be parsed from the tree. Default: \code{TRUE}.
#' @param table_sep Character. Separator between taxonomy ranks in the second
#'   column of the taxonomy file. Default: \code{";"}.
#' @param delimiter_mode Character. Embedded parsing strategy: "reverse", "greedy", "segment".
#' @param taxonomy_levels Custom taxonomy level configuration (list with codes and names).
#'   Used to extend or override default rank handling. Default: \code{NULL}.
#' @return data.frame with columns: label, Group.
#' @keywords internal
parse_taxonomy_with_file <- function(labels, rank, format = "auto",
                                      custom_patterns = NULL,
                                      taxonomy_file = NULL,
                                      file_sep = "auto",
                                      file_header = FALSE,
                                      file_priority = TRUE,
                                      table_sep = ";",
                                      delimiter_mode = "reverse",
                                      taxonomy_levels = NULL) {
  # First, parse from labels
  label_result <- parse_taxonomy(labels, rank, format, custom_patterns,
                                  taxonomy_levels = taxonomy_levels,
                                  delimiter_mode = delimiter_mode)

  # If no file provided, return label-based result
  if (is.null(taxonomy_file)) {
    return(label_result)
  }

  # Read taxonomy file
  file_lookup <- build_taxonomy_lookup(taxonomy_file, file_sep, file_header, table_sep)

  # Get rank column name
  rank_std <- normalize_rank(rank)
  levels <- get_taxonomy_levels(taxonomy_levels)
  rank_names <- levels$names

  if (!rank_std %in% rank_names) {
    log_warning("Rank '%s' not recognized. Returning label-based result.", rank,
                .module = "taxonomy-file")
    return(label_result)
  }

  # Merge file taxonomy with label-based result.
  # Vectorized via match (L-B3): no per-label loop; semantics preserved.
  idx <- match(labels, names(file_lookup))
  hit <- !is.na(idx)
  if (any(hit)) {
    lookup_rows <- file_lookup[idx[hit]]
    have_rank <- vapply(lookup_rows, function(r) rank_std %in% names(r), logical(1))
    if (any(have_rank)) {
      pos <- which(hit)[have_rank]
      file_values <- vapply(lookup_rows[have_rank], function(r) {
        v <- r[[rank_std]]
        if (is.na(v) || !is.character(v) || nchar(v) == 0) {
          NA_character_
        } else {
          v
        }
      }, character(1))

      if (file_priority) {
        # File takes priority (default): override wherever file gives a value.
        non_empty <- !is.na(file_values)
        label_result$Group[pos[non_empty]] <- file_values[non_empty]
      } else {
        # File used only when label parsing failed (NA Group).
        fill <- is.na(label_result$Group[pos]) & !is.na(file_values)
        label_result$Group[pos[fill]] <- file_values[fill]
      }
    }
  }

  return(label_result)
}


#' Summarize taxonomy quality with external file support
#'
#' Extended version of \code{summarize_taxonomy_quality()} that can use an
#' external taxonomy file.
#'
#' @param labels Character vector of tip labels.
#' @param format Format: "auto", "GTDB", "Silva", "NCBI", "custom_rank", "custom_regex".
#' @param custom_patterns Custom regex patterns (for "custom_regex" format).
#' @param taxonomy_file Character. Path to external taxonomy file. Default: \code{NULL}.
#' @param file_sep Character. Column separator for taxonomy file. Default: \code{"auto"}.
#' @param file_header Logical. Whether taxonomy file has header row. Default: \code{FALSE}.
#' @param file_priority Logical. If \code{TRUE}, file taxonomy takes priority.
#'   Default: \code{TRUE}.
#' @param table_sep Character. Separator between taxonomy ranks in the second
#'   column of the taxonomy file. Default: \code{";"}.
#' @param delimiter_mode Character. Embedded parsing strategy: "reverse", "greedy", "segment".
#' @param taxonomy_levels Custom taxonomy level configuration (list with codes and names).
#'   Default: \code{NULL}.
#' @return Invisibly returns a list with parsing statistics.
#' @export
#' @examples
#' \dontrun{
#' # Report quality with external file
#' summarize_taxonomy_quality_with_file(labels, format = "auto",
#'                                       taxonomy_file = "taxonomy.tsv")
#' }
summarize_taxonomy_quality_with_file <- function(labels, format = "auto",
                                                  custom_patterns = NULL,
                                                  taxonomy_file = NULL,
                                                  file_sep = "auto",
                                                  file_header = FALSE,
                                                  file_priority = TRUE,
                                                  table_sep = ";",
                                                  delimiter_mode = "reverse",
                                                  taxonomy_levels = NULL) {
  detected_format <- if (format == "auto") detect_taxonomy_format(labels) else format

  levels <- get_taxonomy_levels(taxonomy_levels)
  rank_names <- levels$names

  # Single full-rank parse via build_full_taxa_df (label parse + at most ONE
  # taxonomy-file read), instead of re-parsing and re-reading the file once
  # per rank (M-D4 pattern).
  taxa_df <- build_full_taxa_df(
    labels, format = detected_format, custom_patterns = custom_patterns,
    taxonomy_file = taxonomy_file, file_sep = file_sep,
    file_header = file_header, file_priority = file_priority,
    table_sep = table_sep, delimiter_mode = delimiter_mode,
    taxonomy_levels = taxonomy_levels
  )
  # Ensure one column per rank in canonical order (missing ranks -> NA column)
  for (rn in rank_names) {
    if (!rn %in% names(taxa_df)) taxa_df[[rn]] <- NA_character_
  }
  taxa_df <- taxa_df[, rank_names, drop = FALSE]

  total <- length(labels)
  na_counts <- vapply(taxa_df, function(x) sum(is.na(x)), integer(1))
  parse_rates <- round((total - na_counts) / total * 100, 1)

  all_na <- apply(taxa_df, 1, function(row) all(is.na(row)))
  failed_labels <- labels[all_na]

  msg <- "=== Taxonomy Label Parsing Quality Report ===\n"
  msg <- paste0(msg, "Total labels: ", total, "\n")
  msg <- paste0(msg, "Detected format: ", detected_format, "\n")
  if (!is.null(taxonomy_file)) {
    msg <- paste0(msg, "External file: ", taxonomy_file, "\n")
    msg <- paste0(msg, "File priority: ", if (file_priority) "YES" else "NO", "\n")
  }
  msg <- paste0(msg, "\n")

  msg <- paste0(msg, "Per-rank parse rates:\n")
  for (rn in rank_names) {
    bar <- paste(rep("=", ceiling(parse_rates[rn] / 5)), collapse = "")
    msg <- paste0(msg, sprintf("  %-10s %5.1f%% (%d/%d) %s\n",
                rn, parse_rates[rn], total - na_counts[rn], total, bar))
  }

  if (length(failed_labels) > 0) {
    msg <- paste0(msg, "\nCompletely unparseable labels (", length(failed_labels), "):\n")
    for (lbl in head(failed_labels, 10)) {
      msg <- paste0(msg, "  - ", lbl, "\n")
    }
    if (length(failed_labels) > 10) {
      msg <- paste0(msg, "  ... and ", length(failed_labels) - 10, " more\n")
    }
  } else {
    msg <- paste0(msg, "\nAll labels parsed successfully.\n")
  }

  cat(msg)

  invisible(list(
    format = detected_format,
    total = total,
    na_counts = na_counts,
    parse_rates = parse_rates,
    failed_labels = failed_labels,
    taxonomy_file = taxonomy_file
  ))
}
