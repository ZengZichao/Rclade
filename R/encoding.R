# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Cross-platform and encoding robustness utilities

# --- UTF-8 Encoding Helpers ---

#' Read file with explicit UTF-8 encoding
#'
#' Attempts UTF-8 first, falls back to a byte-level read (utf-8-sig equivalent)
#' on failure. Any occurrence of the Unicode replacement character \code{U+FFFD}
#' (a sign of mojibake / invalid bytes silently substituted by the reader) is
#' reported via \code{log_warning}, or aborts when \code{strict = TRUE} (M-C3).
#'
#' @param filepath Character. Path to file.
#' @param warn Logical. Whether to warn on encoding fallback.
#' @param strict Logical. If \code{TRUE}, abort (class \code{Rclade_parse_error})
#'   instead of only warning when \code{U+FFFD} is detected. Default: \code{FALSE}.
#' @return Character vector of file lines.
#' @keywords internal
read_file_utf8 <- function(filepath, warn = TRUE, strict = FALSE) {
  if (!file.exists(filepath)) {
    stop("File not found: ", filepath, call. = FALSE)
  }
  if (file.size(filepath) == 0) {
    if (warn) log_warning("File is empty: %s", filepath, .module = "encoding/read_file_safe")
    return(character(0))
  }
  # Try UTF-8 first
  lines <- tryCatch(
    readLines(filepath, encoding = "UTF-8", warn = FALSE),
    error = function(e) NULL
  )

  if (!is.null(lines)) {
    # Check for BOM (Byte Order Mark: EF BB BF)
    if (length(lines) > 0 && grepl("^\uFEFF", lines[1])) {
      log_debug("Removing UTF-8 BOM from: %s", filepath)
      lines[1] <- sub("^\uFEFF", "", lines[1])
    }
    # Detect the Unicode replacement character U+FFFD, which means the UTF-8
    # reader silently substituted invalid/mojibake bytes (M-C3).
    fffd <- grepl("\uFFFD", lines, useBytes = TRUE)
    if (any(fffd)) {
      msg <- sprintf(
        "Possible encoding corruption in %s: %d line(s) contain the Unicode replacement character U+FFFD. The file may not be valid UTF-8.",
        filepath, sum(fffd))
      if (strict) {
        rlang::abort(msg, class = "Rclade_parse_error")
      }
      log_warning(msg, .module = "encoding/read_file_safe")
    }
    return(lines)
  }

  # Fallback: try UTF-8 without strict validation (equivalent to utf-8-sig)
  if (warn) {
    log_warning("UTF-8 decoding failed for %s, attempting fallback encoding", filepath,
                .module = "encoding/read_file_safe")
  }

  lines <- tryCatch(
    {
      raw_bytes <- readBin(filepath, "raw", file.size(filepath))
      # rawToChar substitutes invalid bytes with U+FFFD silently; we alert on it.
      text <- rawToChar(raw_bytes)
      Encoding(text) <- "UTF-8"
      strsplit(text, "\n")[[1]]
    },
    error = function(e) {
      stop("Cannot read file with any supported encoding: ", filepath,
           "\nError: ", e$message, call. = FALSE)
    }
  )

  # Same U+FFFD guard on the fallback result (M-C3).
  fffd <- grepl("\uFFFD", lines, useBytes = TRUE)
  if (any(fffd)) {
    msg <- sprintf(
      "Possible encoding corruption in %s (fallback path): %d line(s) contain U+FFFD.",
      filepath, sum(fffd))
    if (strict) {
      rlang::abort(msg, class = "Rclade_parse_error")
    }
    log_warning(msg, .module = "encoding/read_file_safe")
  }

  return(lines)
}

#' Write file with explicit UTF-8 encoding and Unix line endings
#'
#' @param filepath Character. Path to file.
#' @param content Character vector. Lines to write.
#' @param append Logical. Whether to append to existing file.
#' @keywords internal
write_file_utf8 <- function(filepath, content, append = FALSE) {
  # Normalize line endings to \n (Unix style)
  content <- gsub("\r\n", "\n", content)
  content <- gsub("\r", "\n", content)

  # Write with UTF-8 encoding
  con <- file(filepath, open = if (append) "a" else "w", encoding = "UTF-8")
  on.exit(close(con), add = TRUE)

  writeLines(content, con, sep = "\n")
  invisible(TRUE)
}

# --- Path Handling Utilities ---

#' Build file path safely (cross-platform)
#'
#' Wrapper around file.path() to ensure consistent path construction.
#' Never use paste() or sprintf() for path construction.
#'
#' @param ... Path components.
#' @return Character. Constructed path.
#' @keywords internal
#' @examples
#' \dontrun{
#' build_path("data", "output", "tree.pdf")
#' }
build_path <- function(...) {
  file.path(...)
}

#' Ensure directory exists, create if needed
#'
#' @param dirpath Character. Directory path.
#' @return Invisibly returns the path.
#' @keywords internal
ensure_dir <- function(dirpath) {
  if (!dir.exists(dirpath)) {
    dir.create(dirpath, recursive = TRUE, showWarnings = FALSE)
    log_debug("Created directory: %s", dirpath)
  }
  invisible(dirpath)
}

# --- Temp File Management ---

#' Create and manage temporary file with automatic cleanup
#'
#' Creates a temporary file and registers cleanup via on.exit().
#'
#' @param pattern Character. File name pattern.
#' @param fileext Character. File extension.
#' @param tmpdir Character. Temporary directory. Default: tempdir().
#' @return List with path and cleanup function.
#' @keywords internal
#' @examples
#' \dontrun{
#' tmp <- managed_tempfile(pattern = "tree_", fileext = ".nwk")
#' writeLines("(A:1,B:1);", tmp$path)
#' # File is automatically cleaned up when function exits
#' }
managed_tempfile <- function(pattern = "rclade_", fileext = ".tmp", tmpdir = tempdir()) {
  ensure_dir(tmpdir)
  filepath <- tempfile(pattern = pattern, fileext = fileext, tmpdir = tmpdir)

  # Restrict temp file permissions to owner-only (0600) for HPC security (§10.1)
  tryCatch(Sys.chmod(filepath, mode = "0600"), error = function(e) NULL)

  cleanup <- function() {
    if (file.exists(filepath)) {
      tryCatch(file.remove(filepath), error = function(e) NULL)
      log_debug("Cleaned up temp file: %s", filepath)
    }
  }

  list(
    path = filepath,
    cleanup = cleanup
  )
}

#' Create and manage temporary directory with automatic cleanup
#'
#' @param pattern Character. Directory name pattern.
#' @return List with path and cleanup function.
#' @keywords internal
managed_tempdir <- function(pattern = "rclade_") {
  dirpath <- tempfile(pattern = pattern)
  dir.create(dirpath, recursive = TRUE)

  # Restrict temp dir permissions to owner-only (0700) for HPC security (§10.1)
  tryCatch(Sys.chmod(dirpath, mode = "0700"), error = function(e) NULL)

  cleanup <- function() {
    if (dir.exists(dirpath)) {
      tryCatch(unlink(dirpath, recursive = TRUE), error = function(e) NULL)
      log_debug("Cleaned up temp dir: %s", dirpath)
    }
  }

  list(
    path = dirpath,
    cleanup = cleanup
  )
}

# --- Encoding Detection ---

#' Detect file encoding
#'
#' @param filepath Character. Path to file.
#' @param n_lines Integer. Number of initial lines sampled for UTF-8 validity
#'   (in addition to a fixed 10 KB raw-byte prefix used for BOM / endianness
#'   detection). Sampling the head is sufficient because BOM and byte-order
#'   markers appear at file start, and U+FFFD substitution surfaces early.
#' @return Character. Detected encoding name.
#' @keywords internal
detect_encoding <- function(filepath, n_lines = 10) {
  # Read raw bytes (fixed 10 KB sampling window for BOM / endianness; L-C4).
  raw_bytes <- readBin(filepath, "raw", min(file.size(filepath), 10000))

  # Check for BOM
  if (length(raw_bytes) >= 3 &&
      raw_bytes[1] == as.raw(0xEF) &&
      raw_bytes[2] == as.raw(0xBB) &&
      raw_bytes[3] == as.raw(0xBF)) {
    return("UTF-8-BOM")
  }

  if (length(raw_bytes) >= 2 &&
      raw_bytes[1] == as.raw(0xFF) &&
      raw_bytes[2] == as.raw(0xFE)) {
    return("UTF-16LE")
  }

  if (length(raw_bytes) >= 2 &&
      raw_bytes[1] == as.raw(0xFE) &&
      raw_bytes[2] == as.raw(0xFF)) {
    return("UTF-16BE")
  }

  # Try UTF-8 validation
  # Strict UTF-8 check: a valid file read with readLines(encoding="UTF-8")
  # must not contain U+FFFD
  valid_utf8 <- tryCatch({
    txt <- readLines(filepath, encoding = "UTF-8", warn = FALSE,
                     n = n_lines)
    !any(grepl("\uFFFD", txt, useBytes = TRUE))
  }, error = function(e) FALSE)
  if (valid_utf8) return("UTF-8")
  return("unknown")
}

# --- Newline Normalization ---

#' Normalize line endings in text
#'
#' Converts all line endings to Unix style (LF).
#'
#' @param text Character vector or single string.
#' @return Character with normalized line endings.
#' @keywords internal
normalize_newlines <- function(text) {
  text <- gsub("\r\n", "\n", text)
  text <- gsub("\r", "\n", text)
  return(text)
}

#' Normalize line endings in a file
#'
#' Reads a file, normalizes line endings, and writes it back.
#'
#' @param filepath Character. Path to file.
#' @return Invisibly returns the filepath.
#' @keywords internal
normalize_file_newlines <- function(filepath) {
  lines <- read_file_utf8(filepath)
  lines <- normalize_newlines(lines)
  write_file_utf8(filepath, lines)
  invisible(filepath)
}
