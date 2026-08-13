# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Taxonomic label parsing engine
# Supports dual format: embedded (Format A) and semicolon-delimited (Format B)

#' @importFrom utils head
NULL

#' Escape a string for safe use inside a regular expression
#'
#' Wraps every regex-metacharacter in a backslash so the resulting string can
#' be embedded literally in a pattern.  Used by the semicolon-delimited parser
#' (and any other code that turns a user separator into a regex) so that a
#' separator such as \code{"."} or \code{"+"} is matched as a literal character
#' rather than as a metacharacter.
#'
#' @param x Character scalar to escape.
#' @return Escaped character scalar.
#' @keywords internal
escape_regex <- function(x) {
  gsub("([.|()\\^{}+$*?\\[\\]\\\\])", "\\\\\\1", x)
}

# Default taxonomy level configuration
#' @keywords internal
DEFAULT_TAXONOMY_LEVELS <- list(
  codes = c("k", "d", "p", "c", "o", "f", "g", "s", "ss"),
  names = c("kingdom", "domain", "phylum", "class", "order", "family", "genus", "species", "subspecies")
)

#' Get taxonomy level configuration
#'
#' Returns the current taxonomy level mapping. Can be customized via
#' \code{--taxonomy-levels} option.
#'
#' @param custom_levels Named list or NULL. If NULL, uses defaults.
#' @return List with codes and names vectors.
#' @keywords internal
get_taxonomy_levels <- function(custom_levels = NULL) {
  if (is.null(custom_levels)) {
    return(DEFAULT_TAXONOMY_LEVELS)
  }
  # Validate custom levels
  if (!is.list(custom_levels) || is.null(names(custom_levels))) {
    log_warning("Invalid custom_levels format. Using defaults.",
                .module = "parse-taxonomy")
    return(DEFAULT_TAXONOMY_LEVELS)
  }
  return(custom_levels)
}

#' Detect taxonomy format from tip labels
#'
#' Detects Format A (embedded: \code{_d_Bacteria_p_...}) or
#' Format B (semicolon-delimited: \code{d__Bacteria;p__...}).
#'
#' @param labels Character vector of tip labels
#' @return Format name: "embedded", "GTDB", "Silva", "NCBI", or "unknown"
#' @section Regex heuristic boundaries (L-C3):
#' Detection and parsing here are \strong{heuristic regex} passes, not a strict
#' grammar.  Known boundaries the caller must respect:
#' \itemize{
#'   \item \strong{Underscores in names}: under \code{delimiter_mode = "reverse"}
#'     the pattern uses \code{[^_]+?}, so an underscore inside a taxon name
#'     (e.g. \code{_g_Clostridium_sensu_stricto_s_X}) can be mis-read as a rank
#'     separator.  Names that contain underscores should use
#'     \code{delimiter_mode = "segment"} (delimiter-to-delimiter extraction),
#'     which preserves embedded underscores.  For Format B (\code{;}-delimited)
#'     underscores are safe.
#'   \item \strong{Custom regex backtracking}: caller-supplied
#'     \code{custom_patterns} are inserted verbatim into the parser.  Unbounded
#'     repeating groups (e.g. \code{(.+)+}) can cause \strong{catastrophic
#'     backtracking} on adversarial labels.  Patterns are rejected above the
#'     200-character limit, but keep sub-patterns bounded and anchored.
#'   \item \strong{Detection is content-based}: \code{detect_taxonomy_format}
#'     samples labels; a mixed or malformed corpus may return \code{"unknown"},
#'     in which case the caller must fall back to an explicit \code{format=}.
#'   \item \strong{GTDB requires a semicolon majority (M-B3)}: the GTDB rule
#'     additionally requires that more than half of sampled labels contain a
#'     semicolon.  Accession-prefixed embedded labels with double-underscore
#'     rank separators (e.g. \code{GCA_xxx_d__Archaea_p__Nanoarchaeota})
#'     satisfy the \code{[dpcofgsk]__} pattern but contain no semicolons; they
#'     are detected as \code{"embedded"} rather than misclassified as GTDB.
#'     The embedded parsers also tolerate double-underscore separators.
#' }
#' @export
detect_taxonomy_format <- function(labels) {
  sample_labels <- labels[!is.na(labels)]
  if (length(sample_labels) == 0) {
    log_warning("No valid labels provided for taxonomy format detection. Returning 'unknown' format.",
                .module = "parse-taxonomy")
    return("unknown")
  }
  if (length(sample_labels) > 100) sample_labels <- head(sample_labels, 100)

  # Rule 1: Format B - GTDB format (contains "{level}__")
  # M-B2: a format is only accepted when its match score is a CLEAR majority,
  # i.e. strictly above 0.5 AND at least 0.1 away from the 0.5 tie line
  # (equivalently score >= 0.6).  Scores near 0.5 are ambiguous and must fall
  # through to "unknown".  The epsilon guards against binary floating-point
  # error (0.6 - 0.5 evaluates to 0.09999999999999998 < 0.1 without it).
  # M-B3: genuine Format B (GTDB) lineages are semicolon-delimited.  Embedded
  # labels that use double-underscore rank separators (e.g.
  # "GCA_xxx_d__Archaea_p__Nanoarchaeota") also satisfy "[dpcofgsk]__" but
  # contain no semicolons; requiring a semicolon majority prevents
  # misclassifying them as GTDB (real-world case: 700-tip LACA timetree).
  gtdb_score <- mean(grepl("[dpcofgsk]__", sample_labels))
  semicolon_frac <- mean(grepl(";", sample_labels))
  if (gtdb_score > 0.5 && (gtdb_score - 0.5) >= 0.1 - 1e-9 &&
      semicolon_frac > 0.5) return("GTDB")

  # Rule 2: Format A - Embedded format (contains "_{level}_" with single letter)
  embedded_score <- mean(grepl("_[dpcofgsk]_", sample_labels))
  if (embedded_score > 0.5 && (embedded_score - 0.5) >= 0.1 - 1e-9) return("embedded")

  # Rule 3: Semicolon-delimited formats
  if (mean(grepl(";", sample_labels)) > 0.5) {
    ncbi_prefixes <- c("cellular organisms", "root", "viruses",
                       "other sequences", "unclassified", "environmental samples")
    silva_prefixes <- c("bacteria", "archaea", "eukaryota")

    ncbi_score <- mean(grepl(
      paste0("^(", paste(ncbi_prefixes, collapse = "|"), ")"),
      sample_labels, ignore.case = TRUE))
    silva_score <- mean(grepl(
      paste0("^(", paste(silva_prefixes, collapse = "|"), ")"),
      sample_labels, ignore.case = TRUE))

    if (ncbi_score > silva_score && ncbi_score > 0.3) return("NCBI")
    if (silva_score > ncbi_score && silva_score > 0.3) return("Silva")
    if (abs(ncbi_score - silva_score) < 1e-10 && ncbi_score > 0.3) {
      log_warning("NCBI and Silva prefix scores are equal (%s). Ambiguous format. Returning 'unknown'. Please specify taxonomy_format explicitly.",
                  round(ncbi_score, 2), .module = "parse-taxonomy")
      return("unknown")
    }
    if (ncbi_score < 0.3 && silva_score < 0.3) {
      log_warning("Semicolon-delimited labels detected but neither NCBI nor Silva patterns match strongly (NCBI score: %s, Silva score: %s). Returning 'unknown' format. Please specify taxonomy_format explicitly.",
                  round(ncbi_score, 2), round(silva_score, 2),
                  .module = "parse-taxonomy")
      return("unknown")
    }
  }

  return("unknown")
}

#' Parse Format A: Embedded taxonomy labels
#'
#' Parses labels like \code{GB_GCA_000252485.1_d_Bacteria_p_Cyanobacteriota_c_...}
#' using delimiters \code{_d_}, \code{_p_}, \code{_c_}, \code{_o_}, \code{_f_}, \code{_g_}, \code{_s_}.
#'
#' Supports three delimiter matching strategies:
#' \itemize{
#'   \item \code{"reverse"} (default): match ranks from right-to-left to reduce
#'     ambiguity when taxonomy names contain underscores.
#'   \item \code{"greedy"}: match ranks left-to-right using a character-class
#'     boundary (faster but less robust to underscores in names).
#'   \item \code{"segment"}: extract the segment between each rank delimiter and
#'     the next rank delimiter, preserving underscores within values.
#' }
#'
#' All three strategies tolerate double-underscore rank separators
#' (e.g. \code{_p__Nanoarchaeota}, common in accession-prefixed embedded
#' labels); leading underscores left over from such schemes are trimmed from
#' parsed values.
#'
#' @param labels Character vector of tip labels
#' @param levels List with codes and names vectors for taxonomy levels.
#' @param delimiter_mode Character. One of \code{"reverse"}, \code{"greedy"},
#'   \code{"segment"}. Default: \code{"reverse"}.
#' @return data.frame with taxonomy columns
#' @keywords internal
parse_embedded <- function(labels, levels = NULL, delimiter_mode = "reverse") {
  levels <- get_taxonomy_levels(levels)
  codes <- levels$codes
  rank_names <- levels$names

  delimiter_mode <- match.arg(delimiter_mode, c("reverse", "greedy", "segment"))
  log_debug("Embedded parsing mode: %s", delimiter_mode)

  result <- data.frame(matrix(NA_character_, nrow = length(labels), ncol = length(codes)))
  names(result) <- rank_names

  if (delimiter_mode == "reverse") {
    # Reverse order: match from rightmost level (g) to leftmost (d)
    iter_codes <- rev(codes)
    iter_names <- rev(rank_names)
  } else {
    # Greedy/segment: left-to-right order
    iter_codes <- codes
    iter_names <- rank_names
  }

  for (i in seq_along(iter_codes)) {
    code <- iter_codes[i]
    rn <- iter_names[i]

    if (delimiter_mode == "segment") {
      # Segment mode: extract content from this delimiter up to the next rank
      # delimiter or end of string. This preserves underscores within values.
      # The optional second underscore tolerates double-underscore schemes
      # (e.g. "_p__Nanoarchaeota" from accession-prefixed embedded labels).
      code_idx <- which(codes == code)
      next_codes <- codes[(code_idx + 1):length(codes)]
      next_pattern <- if (length(next_codes) > 0) {
        paste0("_(?:", paste(next_codes, collapse = "|"), ")_|$")
      } else {
        "$"
      }
      pattern <- paste0("_", code, "__?(.+?)(?=", next_pattern, ")")
    } else {
      # Reverse/greedy: use character-class boundary to stop at next delimiter.
      # The optional second underscore tolerates double-underscore schemes.
      pattern <- paste0("_", code, "__?([^_]+?)(?:_[", paste(codes, collapse = ""), "]_|$)")
    }

    matches <- stringr::str_match(labels, pattern)
    value <- matches[, 2]

    # Clean up: trim whitespace and leading underscores left over from
    # double-underscore delimiter schemes, convert empty to NA
    value <- trimws(value)
    value <- sub("^_+", "", value)
    value[value == ""] <- NA_character_

    # Log missing values at DEBUG level
    na_count <- sum(is.na(value))
    if (na_count > 0 && na_count < length(labels)) {
      log_debug("Format A: %d/%d labels missing level '%s' (%s)",
                na_count, length(labels), code, rn)
    }

    result[[rn]] <- value
  }

  return(result)
}

#' Parse Format B: Semicolon-delimited taxonomy (GTDB-style)
#'
#' Parses labels like \code{d__Bacteria;p__Cyanobacteriota;c__Cyanobacteriia;...}
#' where empty values like \code{s__} are parsed as NA.
#'
#' @param labels Character vector of tip labels
#' @param levels List with codes and names vectors for taxonomy levels.
#' @param sep Character. Separator between taxonomy ranks. Default: \code{";"}.
#' @return data.frame with taxonomy columns
#' @keywords internal
parse_semicolon_delimited <- function(labels, levels = NULL, sep = ";") {
  levels <- get_taxonomy_levels(levels)
  codes <- levels$codes
  rank_names <- levels$names

  # Escape separator for regex if it is a special character (L-B1: reuse helper)
  sep_escaped <- escape_regex(sep)

  result <- data.frame(matrix(NA_character_, nrow = length(labels), ncol = length(codes)))
  names(result) <- rank_names

  for (i in seq_along(codes)) {
    code <- codes[i]
    # Pattern: {code}__ followed by content until separator or end
    # Captures content after __ even if empty
    pattern <- paste0(code, "__([^", sep_escaped, "]*?)(?:", sep_escaped, "|$)")
    matches <- regmatches(labels, regexec(pattern, labels))

    result[[rank_names[i]]] <- vapply(matches, function(m) {
      if (length(m) >= 2) {
        val <- trimws(m[2])
        if (nchar(val) == 0) {
          # Empty value like "s__" -> NA
          log_debug("Format B: empty value for level '%s' in label", code)
          return(NA_character_)
        }
        # Validate: value must not contain separator or __
        if (grepl(sep, val, fixed = TRUE) || grepl("__", val)) {
          log_warning("Format B: invalid characters in value '%s' (level %s), contains '%s' or '__'",
                      val, code, sep, .module = "parse-taxonomy/parse_format_b")
          return(NA_character_)
        }
        return(val)
      }
      return(NA_character_)
    }, character(1))
  }

  return(result)
}

#' Parse GTDB format labels (wrapper for parse_semicolon_delimited)
#' @param labels Character vector of tip labels
#' @param levels List with codes and names vectors.
#' @param sep Character. Separator between taxonomy ranks. Default: \code{";"}.
#' @return data.frame with taxonomy columns
#' @keywords internal
parse_gtdb <- function(labels, levels = NULL, sep = ";") {
  parse_semicolon_delimited(labels, levels, sep)
}

#' Parse Silva format labels
#' @param labels Character vector of tip labels
#' @return data.frame with columns: domain, phylum, class, order, family, genus, species
#' @keywords internal
parse_silva <- function(labels) {
  rank_names <- c("domain", "phylum", "class", "order", "family", "genus", "species")
  parts <- strsplit(labels, ";", fixed = TRUE)

  result <- data.frame(matrix(NA_character_, nrow = length(labels), ncol = length(rank_names)))
  names(result) <- rank_names

  skip_values <- c("unclassified", "unknown", "")

  for (i in seq_along(parts)) {
    p <- trimws(parts[[i]])
    for (j in seq_along(p)) {
      if (j <= length(rank_names)) {
        if (nchar(p[j]) > 0 && !tolower(p[j]) %in% skip_values) {
          result[i, rank_names[j]] <- p[j]
        }
      }
    }
  }
  return(result)
}

#' Parse NCBI format labels
#' @param labels Character vector of tip labels
#' @param quiet Logical. If TRUE, suppress the positional mapping warning.
#' @return data.frame with columns: domain, phylum, class, order, family, genus, species
#' @keywords internal
parse_ncbi <- function(labels, quiet = FALSE) {
  rank_names <- c("domain", "phylum", "class", "order", "family", "genus", "species")
  parts <- strsplit(labels, ";", fixed = TRUE)

  result <- data.frame(matrix(NA_character_, nrow = length(labels), ncol = length(rank_names)))
  names(result) <- rank_names

  skip_prefixes <- c("cellular organisms", "root", "unclassified", "unknown",
                     "viruses", "other sequences", "environmental samples")

  for (i in seq_along(parts)) {
    p <- trimws(parts[[i]])
    # M-B1: only strip LEADING consecutive skip-prefix tokens (e.g. "root",
    # "cellular organisms"). Previously EVERY occurrence of a skip word was
    # dropped regardless of position, which shifted the positional rank
    # mapping whenever a mid-lineage token like "unclassified" appeared.
    is_skip <- tolower(p) %in% skip_prefixes
    first_real <- which(!is_skip)[1]
    p <- if (is.na(first_real)) character(0) else p[first_real:length(p)]
    for (j in seq_along(p)) {
      if (j <= length(rank_names)) {
        result[i, rank_names[j]] <- p[j]
      }
    }
  }

  if (!quiet) {
    log_warning("NCBI format uses positional mapping which may be inaccurate for lineages with non-standard depth (e.g., viruses, environmental samples). Consider using GTDB or Silva format, or providing custom_patterns for critical applications.",
                .module = "parse-taxonomy")
  }

  return(result)
}

#' Parse custom rank format labels (Format A wrapper)
#' @param labels Character vector of tip labels
#' @param levels List with codes and names vectors.
#' @param delimiter_mode Character. Embedded parsing strategy.
#' @return data.frame with taxonomy columns
#' @keywords internal
parse_custom_rank <- function(labels, levels = NULL, delimiter_mode = "reverse") {
  parse_embedded(labels, levels, delimiter_mode)
}

#' Parse custom regex format labels
#' @param labels Character vector of tip labels
#' @param rank_patterns Named list of regex patterns
#' @return data.frame
#' @keywords internal
parse_custom_regex <- function(labels, rank_patterns) {
  if (is.null(rank_patterns)) {
    stop("custom_patterns must be provided when taxonomy_format = 'custom_regex'.",
         call. = FALSE)
  }
  result <- data.frame(matrix(NA_character_, nrow = length(labels), ncol = length(rank_patterns)))
  names(result) <- names(rank_patterns)

  for (rn in names(rank_patterns)) {
    pattern <- rank_patterns[[rn]]
    # Must contain at least one capture group
    if (!grepl("\\(", pattern)) {
      stop("Pattern for '", rn, "' must contain a capture group (). ",
           "Pattern: ", pattern, call. = FALSE)
    }
    # L-B2: bound the pattern length to avoid catastrophic backtracking /
    # ReDoS-style hangs from adversarial user-supplied regexes.
    if (nchar(pattern) > 200) {
      stop("Pattern for '", rn, "' exceeds the 200-character limit; rejecting to ",
           "avoid catastrophic backtracking. Pattern: ", pattern,
           call. = FALSE)
    }
    # Length limit + timeout guard (R has no native eval timeout; bounding the
    # pattern length and warning on very large inputs is the pragmatic guard)
    if (length(labels) > 1e5) {
      log_warning("Very large input (%d labels) with custom regex; this may be slow.",
                  length(labels), .module = "parse-taxonomy/parse_taxonomy_custom_regex")
    }
    # L-B2: guard against malformed / unsupported regex — fail the rank to NA
    # with a warning instead of aborting the whole parse.
    matched <- tryCatch(
      stringr::str_match(labels, pattern),
      error = function(e) {
        log_warning("Invalid or unsupported regex for rank '%s': %s",
                    rn, conditionMessage(e),
                    .module = "parse-taxonomy/parse_taxonomy_custom_regex")
        NULL
      }
    )
    if (is.null(matched) || ncol(matched) < 2) {
      result[[rn]] <- rep(NA_character_, length(labels))
      next
    }
    result[[rn]] <- matched[, 2]
  }
  return(result)
}

#' Build a full-rank taxonomy data.frame in a single pass (M-D4 helper)
#'
#' Used by clade-specific collapsing to avoid re-parsing every rank (and
#' re-reading any taxonomy file) once per search rank. Produces one
#' label-based full parse (format-specific parsers already compute all ranks
#' at once) supplemented/overridden by a single taxonomy-file read when
#' \code{taxonomy_file} is supplied.
#'
#' @param labels Character vector of tip labels.
#' @param format Format: "auto", "GTDB", "Silva", "NCBI", "custom_rank",
#'   "custom_regex", "embedded".
#' @param custom_patterns Custom regex patterns (for "custom_regex" format).
#' @param taxonomy_file Character. Path to external taxonomy file. Default: NULL.
#' @param file_sep Character. Column separator for taxonomy file. Default: "auto".
#' @param file_header Logical. Whether taxonomy file has header row. Default: FALSE.
#' @param file_priority Logical. If TRUE, file taxonomy takes priority over
#'   label-based parsing. Default: TRUE.
#' @param table_sep Character. Separator between taxonomy ranks. Default: ";".
#' @param delimiter_mode Character. Embedded parsing strategy.
#' @param taxonomy_levels Custom taxonomy level configuration. Default: NULL.
#' @return data.frame with a \code{label} column plus one column per rank.
#' @keywords internal
build_full_taxa_df <- function(labels, format = "auto", custom_patterns = NULL,
                                taxonomy_file = NULL, file_sep = "auto",
                                file_header = FALSE, file_priority = TRUE,
                                table_sep = ";", delimiter_mode = "reverse",
                                taxonomy_levels = NULL) {
  levels <- get_taxonomy_levels(taxonomy_levels)
  rank_names <- levels$names

  detected_format <- if (format == "auto") detect_taxonomy_format(labels) else format

  # Single label-based full parse: each format-specific parser returns ALL rank
  # columns at once (no per-rank repetition).
  label_df <- switch(detected_format,
    "GTDB"        = parse_gtdb(labels, levels = taxonomy_levels, sep = table_sep),
    "Silva"       = parse_silva(labels),
    "NCBI"        = parse_ncbi(labels),
    "custom_rank" = parse_custom_rank(labels, levels = taxonomy_levels,
                                       delimiter_mode = delimiter_mode),
    "custom_regex" = parse_custom_regex(labels, custom_patterns),
    # Fallback (embedded / unknown): embedded parser returns all rank columns.
    parse_embedded(labels, levels = taxonomy_levels, delimiter_mode = delimiter_mode)
  )
  if (!"label" %in% names(label_df)) label_df$label <- labels

  keep <- intersect(c("label", rank_names), names(label_df))
  result <- label_df[, keep, drop = FALSE]

  # Single taxonomy-file read (if provided) and per-rank merge.
  if (!is.null(taxonomy_file)) {
    file_df <- read_taxonomy_file(taxonomy_file, sep = file_sep, header = file_header,
                                  table_sep = table_sep)
    file_lookup <- setNames(
      lapply(seq_len(nrow(file_df)), function(i) {
        file_df[i, setdiff(names(file_df), "label"), drop = FALSE]
      }),
      file_df$label
    )
    pos <- match(result$label, names(file_lookup))
    hit <- !is.na(pos)
    if (any(hit)) {
      rows <- file_lookup[pos[hit]]
      for (rn in intersect(rank_names, names(file_df))) {
        file_vals <- vapply(rows, function(r) {
          v <- r[[rn]]
          if (is.na(v) || !is.character(v) || nchar(v) == 0) NA_character_ else v
        }, character(1))
        if (file_priority) {
          ne <- !is.na(file_vals)
          result[[rn]][which(hit)[ne]] <- file_vals[ne]
        } else {
          fill <- is.na(result[[rn]][hit]) & !is.na(file_vals)
          result[[rn]][which(hit)[fill]] <- file_vals[fill]
        }
      }
    }
  }

  result
}

#' Unified taxonomy parsing entry point
#'
#' Parses taxonomic information from tip labels using the specified format and
#' returns a data.frame of group assignments. Intended for use as a stable
#' library API by external workflows (e.g., Snakemake/Nextflow).
#'
#' @param labels Character vector of tip labels
#' @param rank Taxonomic rank (abbreviation or full name)
#' @param format Format: "auto", "embedded", "GTDB", "Silva", "NCBI", "custom_rank", "custom_regex"
#' @param custom_patterns Custom regex patterns (required when format = "custom_regex")
#' @param taxonomy_levels Custom taxonomy level configuration (list with codes and names)
#' @param delimiter_mode Character. Embedded parsing strategy: "reverse", "greedy", "segment".
#' @return data.frame with columns: label, Group
#' @export
parse_taxonomy <- function(labels, rank, format = "auto", custom_patterns = NULL,
                           taxonomy_levels = NULL, delimiter_mode = "reverse") {
  if (format == "auto") format <- detect_taxonomy_format(labels)

  log_debug("Parsing taxonomy: format=%s, rank=%s", format, rank)

  taxa_df <- switch(format,
    "GTDB"         = parse_gtdb(labels, taxonomy_levels),
    "embedded"     = parse_embedded(labels, taxonomy_levels, delimiter_mode),
    "Silva"        = parse_silva(labels),
    "NCBI"         = parse_ncbi(labels),
    "custom_rank"  = parse_custom_rank(labels, taxonomy_levels, delimiter_mode),
    "custom_regex" = parse_custom_regex(labels, custom_patterns),
    "unknown"      = {
      log_warning("Unable to detect taxonomy format. Returning empty groups. Please specify taxonomy_format explicitly.",
                  .module = "parse-taxonomy")
      levels <- get_taxonomy_levels(taxonomy_levels)
      data.frame(matrix(NA_character_, nrow = length(labels), ncol = length(levels$names)))
    },
    stop("Unrecognized taxonomy format: '", format,
         "'. Please specify taxonomy_format or provide custom_patterns.", call. = FALSE)
  )

  # Use standard rank names if not custom_regex
  if (format != "custom_regex") {
    levels <- get_taxonomy_levels(taxonomy_levels)
    if (ncol(taxa_df) == length(levels$names)) {
      names(taxa_df) <- levels$names
    } else {
      # Fallback to default 7 ranks
      names(taxa_df) <- c("domain", "phylum", "class", "order", "family", "genus", "species")
    }
  }

  rank_std <- normalize_rank(rank)
  if (!rank_std %in% names(taxa_df)) {
    log_warning("Rank '%s' not found in format '%s'.", rank, format,
                .module = "parse-taxonomy")
    return(data.frame(label = labels, Group = rep(NA_character_, length(labels)),
                      stringsAsFactors = FALSE))
  }

  group_values <- taxa_df[[rank_std]]

  # Log missing value statistics
  na_count <- sum(is.na(group_values))
  if (na_count > 0) {
    log_debug("Rank '%s': %d/%d labels have missing values", rank_std, na_count, length(labels))
  }

  # Preserve original case (e.g., GTDB standard uses capitalized names)
  return(data.frame(label = labels, Group = group_values,
                    stringsAsFactors = FALSE))
}

#' Report taxonomy label parsing quality
#'
#' Provides a detailed report on how well taxonomic labels can be parsed,
#' including per-rank parse rates and failed labels.
#'
#' @param labels Character vector of tip labels
#' @param format Format: "auto", "embedded", "GTDB", "Silva", "NCBI", "custom_rank", "custom_regex"
#' @param custom_patterns Custom regex patterns (for "custom_regex" format)
#' @param taxonomy_levels Custom taxonomy level configuration
#' @param delimiter_mode Character. Embedded parsing strategy: "reverse", "greedy", "segment".
#' @return Invisibly returns a list with parsing statistics
#' @export
summarize_taxonomy_quality <- function(labels, format = "auto", custom_patterns = NULL,
                                        taxonomy_levels = NULL,
                                        delimiter_mode = "reverse") {
  detected_format <- if (format == "auto") detect_taxonomy_format(labels) else format

  levels <- get_taxonomy_levels(taxonomy_levels)
  rank_names <- levels$names

  taxa_df <- switch(detected_format,
    "GTDB"         = parse_gtdb(labels, taxonomy_levels),
    "embedded"     = parse_embedded(labels, taxonomy_levels, delimiter_mode),
    "Silva"        = parse_silva(labels),
    "NCBI"         = parse_ncbi(labels, quiet = TRUE),
    "custom_rank"  = parse_custom_rank(labels, taxonomy_levels, delimiter_mode),
    "custom_regex" = parse_custom_regex(labels, custom_patterns),
    data.frame(matrix(NA_character_, nrow = length(labels), ncol = 7))
  )
  if (detected_format != "custom_regex") {
    if (ncol(taxa_df) == length(rank_names)) {
      names(taxa_df) <- rank_names
    } else {
      names(taxa_df) <- c("domain", "phylum", "class", "order", "family", "genus", "species")
    }
  }

  total <- length(labels)
  na_counts <- vapply(taxa_df, function(x) sum(is.na(x)), integer(1))
  parse_rates <- round((total - na_counts) / total * 100, 1)

  all_na <- apply(taxa_df, 1, function(row) all(is.na(row)))
  failed_labels <- labels[all_na]

  msg <- "=== Taxonomy Label Parsing Quality Report ===\n"
  msg <- paste0(msg, "Total labels: ", total, "\n")
  msg <- paste0(msg, "Detected format: ", detected_format, "\n\n")

  msg <- paste0(msg, "Per-rank parse rates:\n")
  for (rn in names(taxa_df)) {
    if (rn %in% names(parse_rates)) {
      bar <- paste(rep("=", ceiling(parse_rates[rn] / 5)), collapse = "")
      msg <- paste0(msg, sprintf("  %-12s %5.1f%% (%d/%d) %s\n",
                  rn, parse_rates[rn], total - na_counts[rn], total, bar))
    }
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
    failed_labels = failed_labels
  ))
}
