# Utilities

Cross-platform path building, encoding detection, temporary file management, and miscellaneous helpers.

This module contains the following functions:

- [`build_path`](#build_path) — Build file path safely (cross-platform)
- [`detect_encoding`](#detect_encoding) — Detect file encoding
- [`normalize_file_newlines`](#normalize_file_newlines) — Normalize line endings in a file
- [`managed_tempdir`](#managed_tempdir) — Create and manage temporary directory with automatic cleanup
- [`managed_tempfile`](#managed_tempfile) — Create and manage temporary file with automatic cleanup
- [`get_supported_extensions`](#get_supported_extensions) — Get supported file extensions
- [`save_session_info`](#save_session_info) — Save sessionInfo() for reproducibility
- [`rclade_logo`](#rclade_logo) — Display Rclade ASCII art logo

## `build_path`

Wrapper around file.path() to ensure consistent path construction.
Never use paste() or sprintf() for path construction.

**Usage:**

```r
build_path(...)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `...` | Path components. |

**Value:**

Character. Constructed path.

**Examples:**

```r
build_path("data", "output", "tree.pdf")
```


---

## `detect_encoding`

Detect file encoding

Samples the first lines of a file and infers its text encoding, so the encoding
can be confirmed before reading taxonomy or label files.

**Usage:**

```r
detect_encoding(filepath, n_lines = 10)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `filepath` | Character. Path to file. |
| `n_lines` | Integer. Number of lines to sample. |

**Value:**

Character. Detected encoding name.

**Examples:**

```r
detect_encoding("labels.txt")
```


---

## `normalize_file_newlines`

Reads a file, normalizes line endings, and writes it back.
Line endings are unified (e.g. CRLF to LF) to avoid formatting problems when
files are read on another platform.

**Usage:**

```r
normalize_file_newlines(filepath)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `filepath` | Character. Path to file. |

**Value:**

Invisibly returns the filepath.

**Examples:**

```r
normalize_file_newlines("labels.txt")
```


---

## `managed_tempdir`

Create and manage temporary directory with automatic cleanup

Creates a prefixed temporary directory (mode `0700`) and returns a `cleanup`
closure that the caller is responsible for invoking.

**Usage:**

```r
managed_tempdir(pattern = "rclade_")
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `pattern` | Character. Directory name pattern. |

**Value:**

List with `path` and `cleanup` function.

**Examples:**

```r
d <- managed_tempdir()
```


---

## `managed_tempfile`

Creates a temporary file with the given prefix and extension, and returns a
`cleanup` closure that the caller is responsible for invoking.

**Usage:**

```r
managed_tempfile(pattern = "rclade_", fileext = ".tmp", tmpdir = tempdir())
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `pattern` | Character. File name pattern. |
| `fileext` | Character. File extension. |
| `tmpdir` | Character. Temporary directory. Default: tempdir(). |

**Value:**

List with `path` and `cleanup` function.

**Examples:**

```r
tmp <- managed_tempfile(pattern = "tree_", fileext = ".nwk")
writeLines("(A:1,B:1);", tmp$path)
# Call tmp$cleanup() to remove the file when done
```


---

## `get_supported_extensions`

Get supported file extensions

Lists the file extensions Rclade can currently read, grouped by category.

**Usage:**

```r
get_supported_extensions()
```

**Value:**

Named list of supported extensions by category.

**Examples:**

```r
get_supported_extensions()
```


---

## `save_session_info`

Save sessionInfo() for reproducibility

Writes sessionInfo() to a file, recording the R version and the loaded packages
so that results can be reproduced and troubleshot.

**Usage:**

```r
save_session_info(file = "session_info.txt")
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `file` | Output file path (default "session_info.txt") |

**Value:**

Invisibly returns sessionInfo

**Examples:**

```r
save_session_info("session_info.txt")
```


---

## `rclade_logo`

Prints a stylized ASCII art logo for Rclade to the console.
Optionally prints the version number and the tagline.

**Usage:**

```r
rclade_logo(show_version = TRUE, show_tagline = TRUE)
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `show_version` | Logical. Whether to show version number. Default: TRUE |
| `show_tagline` | Logical. Whether to show tagline. Default: TRUE |

**Value:**

Invisible NULL

**Examples:**

```r
rclade_logo()
```


---


---

[中文](../../cn/reference/utilities.md) | [文档首页](../index.md)
