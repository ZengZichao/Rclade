# 工具函数

跨平台路径拼接、编码检测、临时文件管理及其他辅助函数。

本模块包含以下函数：

- [`build_path`](#build_path) — 安全地拼接文件路径（跨平台）
- [`detect_encoding`](#detect_encoding) — 检测文件编码
- [`normalize_file_newlines`](#normalize_file_newlines) — 规范化文件换行符
- [`managed_tempdir`](#managed_tempdir) — 创建并管理可自动清理的临时目录
- [`managed_tempfile`](#managed_tempfile) — 创建并管理可自动清理的临时文件
- [`get_supported_extensions`](#get_supported_extensions) — 获取支持的文件扩展名
- [`save_session_info`](#save_session_info) — 保存 sessionInfo 以保证可复现
- [`rclade_logo`](#rclade_logo) — 显示 Rclade ASCII 艺术徽标

## `build_path`

**安全地拼接文件路径（跨平台）**

跨平台地拼接路径组件，等价于安全版的 file.path，避免手动拼接分隔符出错。

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
build_path("dir", "sub", "file.txt")
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
| `filepath` | 文件路径。 |
| `n_lines` | 抽样行数。 |

**返回值：**

返回推断的编码名称。

**示例：**

```r
detect_encoding("labels.txt")
```


---

## `normalize_file_newlines`

**规范化文件换行符**

将文件的换行符统一（如 CRLF 转 LF），避免跨平台读取时的格式问题。

**用法：**

```r
normalize_file_newlines(filepath)
```

**参数：**

| 参数 | 说明 |
|------|------|
| `filepath` | 文件路径。 |

**返回值：**

原地规范化文件，返回文件路径（不可见）。

**示例：**

```r
normalize_file_newlines("labels.txt")
```


---

## `managed_tempdir`

**创建并管理可自动清理的临时目录**

创建一个带前缀的临时目录，并在合适时机自动清理，避免遗留垃圾文件。

**用法：**

```r
managed_tempdir(pattern = "rclade_")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `pattern` | 目录名模式。 |

**返回值：**

返回含 path（路径）与 cleanup（清理函数）的列表。

**示例：**

```r
d <- managed_tempdir()
```


---

## `managed_tempfile`

**创建并管理可自动清理的临时文件**

创建一个带前缀与扩展名的临时文件，并在合适时机自动清理。

**用法：**

```r
managed_tempfile(pattern = "rclade_", fileext = ".tmp", tmpdir = tempdir())
```

**参数：**

| 参数 | 说明 |
|------|------|
| `pattern` | 文件名模式。 |
| `fileext` | 文件扩展名。 |
| `tmpdir` | 临时目录，默认 tempdir()。 |

**返回值：**

返回含 path（路径）与 cleanup（清理函数）的列表。

**示例：**

```r
f <- managed_tempfile(fileext = ".txt")
# 通过 f$path 访问路径，函数退出时自动清理
```


---

## `get_supported_extensions`

**获取支持的文件扩展名**

返回 Rclade 当前支持读取的树/序列文件扩展名清单。

**用法：**

```r
get_supported_extensions()
```

**返回值：**

返回按类别分组的具名列表（named list of supported extensions by category）。

**示例：**

```r
get_supported_extensions()
```


---

## `save_session_info`

**保存 sessionInfo 以保证可复现**

将 sessionInfo() 写入文件，记录 R 版本与已加载包，便于结果复现与故障排查。

**用法：**

```r
save_session_info(file = "session_info.txt")
```

**参数：**

| 参数 | 说明 |
|------|------|
| `file` | 输出文件路径，默认 session_info.txt。 |

**返回值：**

将 sessionInfo() 写入文件，并不可见地返回该 sessionInfo 结果。

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
| `show_version` | 是否显示版本号，默认 TRUE。 |
| `show_tagline` | 是否显示标语，默认 TRUE。 |

**返回值：**

在控制台打印徽标，返回不可见的 NULL。

**示例：**

```r
rclade_logo()
```


---


---

[英文](../../en/reference/utilities.md) | [文档首页](../../index.md)
