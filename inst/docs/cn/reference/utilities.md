# 工具函数

跨平台路径拼接、编码检测、临时文件管理及其他辅助函数。

本模块包含以下函数：

- [`build_path`](#build_path) — 安全地拼接文件路径（跨平台）
- [`detect_encoding`](#detect_encoding) — 检测文件编码
- [`normalize_file_newlines`](#normalize_file_newlines) — 规范化文件换行符
- [`managed_tempdir`](#managed_tempdir) — 创建并管理可自动清理的临时目录
- [`managed_tempfile`](#managed_tempfile) — 创建并管理可自动清理的临时文件
- [`get_supported_extensions`](#get_supported_extensions) — 获取支持的文件扩展名
- [`save_session_info`](#save_session_info) — 保存 `sessionInfo` 以保证可复现
- [`rclade_logo`](#rclade_logo) — 显示 Rclade ASCII 艺术徽标

> 以下函数为内部函数（未导出）：`build_path`、`detect_encoding`、`normalize_file_newlines`、`managed_tempdir`、`managed_tempfile`，须以 `Rclade:::build_path()` 形式调用。

## `build_path`

**安全地拼接文件路径（跨平台）**

`file.path()` 的薄封装，跨平台地拼接路径组件，避免手动拼接分隔符出错。构造路径时不要用 `paste()` 或 `sprintf()`。

**用法：**

```r
build_path(...)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `...` | 路径组件。 |

**返回值：**

返回拼接后的完整路径字符串。

**示例：**

```r
Rclade:::build_path("data", "output", "tree.pdf")
```


---

## `detect_encoding`

**检测文件编码**

抽样读取文件前若干行，推断其文本编码，便于在读取分类/标签文件前确认编码。

**用法：**

```r
detect_encoding(filepath, n_lines = 10)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 文件路径（字符串）。 |
| `n_lines` | 抽样行数（整数）。 |

**返回值：**

返回推断的编码名称（字符串）。

**示例：**

```r
Rclade:::detect_encoding("labels.txt")
```


---

## `normalize_file_newlines`

**规范化文件换行符**

读取文件、统一换行符（如 `CRLF` 转 `LF`）后原地写回，避免跨平台读取时的格式问题。

**用法：**

```r
normalize_file_newlines(filepath)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 文件路径（字符串）。 |

**返回值：**

原地规范化文件，并不可见地返回文件路径。

**示例：**

```r
Rclade:::normalize_file_newlines("labels.txt")
```


---

## `managed_tempdir`

**创建并管理可自动清理的临时目录**

创建一个带前缀的临时目录（权限 `0700`），并返回一个 `cleanup` 闭包，由调用方负责调用以完成清理。

**用法：**

```r
managed_tempdir(pattern = "rclade_")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `pattern` | 目录名模式（字符串）。 |

**返回值：**

返回含 `path`（路径）与 `cleanup`（清理函数）的列表。

**示例：**

```r
d <- Rclade:::managed_tempdir()
```


---

## `managed_tempfile`

**创建并管理可自动清理的临时文件**

创建一个带前缀与扩展名的临时文件，并返回一个 `cleanup` 闭包，由调用方负责清理。

**用法：**

```r
managed_tempfile(pattern = "rclade_", fileext = ".tmp", tmpdir = tempdir())
```

**参数：**

| 参数 | 说明 |
|------|------|
| `pattern` | 文件名模式（字符串）。 |
| `fileext` | 文件扩展名（字符串）。 |
| `tmpdir` | 临时目录（字符串），默认 `tempdir()`。 |

**返回值：**

返回含 `path`（路径）与 `cleanup`（清理函数）的列表。

**示例：**

```r
tmp <- Rclade:::managed_tempfile(pattern = "tree_", fileext = ".nwk")
writeLines("(A:1,B:1);", tmp$path)
# 用毕请调用 tmp$cleanup() 删除该文件
```


---

## `get_supported_extensions`

**获取支持的文件扩展名**

返回 Rclade 当前支持读取的树、序列与分类学文件扩展名清单。

**用法：**

```r
get_supported_extensions()
```

**返回值：**

返回按类别分组的支持扩展名具名列表。

**示例：**

```r
get_supported_extensions()
```


---

## `save_session_info`

**保存 `sessionInfo` 以保证可复现**

将 `sessionInfo()` 写入文件，记录 R 版本与已加载包，便于结果复现与故障排查。

**用法：**

```r
save_session_info(file = "session_info.txt")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `file` | 输出文件路径（字符串），默认 `session_info.txt`。 |

**返回值：**

将 `sessionInfo()` 写入文件，并不可见地返回该 `sessionInfo()` 结果。

**示例：**

```r
save_session_info("session_info.txt")
```


---

## `rclade_logo`

**显示 Rclade ASCII 艺术徽标**

在控制台打印 Rclade 的 ASCII 艺术徽标，可选显示版本号与标语。

**用法：**

```r
rclade_logo(show_version = TRUE, show_tagline = TRUE)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `show_version` | 是否显示版本号（逻辑值），默认 `TRUE`。 |
| `show_tagline` | 是否显示标语（逻辑值），默认 `TRUE`。 |

**返回值：**

在控制台打印徽标，并不可见地返回 `NULL`。

**示例：**

```r
rclade_logo()
```


---


---

[英文](../../en/reference/utilities.md) | [文档首页](../index.md)
