# 安装

## 系统要求

- **R** ≥ 4.1.0
- 操作系统：Linux、macOS、Windows
- 建议：用于编译依赖的 C/C++ 工具链（通常已自带）

## 从 CRAN 安装

```r
install.packages("Rclade")
```

## 安装开发版

```r
# install.packages("remotes")
remotes::install_github("zengzichao/Rclade")
```

## 依赖

Rclade 依赖：`ape`、`ggtree`、`deeptime`、`ggplot2`、`rlang`、`stringr`、`tidytree`、`viridisLite`。

建议安装（部分功能需要）：`treeio`、`phangorn`、`RColorBrewer`、`cowplot`、`patchwork`、`shiny`、`optparse`、`yaml`、`testthat`、`knitr`、`rmarkdown`。

若计划使用 Shiny 应用、命令行或运行测试，请安装：

```r
install.packages(c("shiny", "optparse", "patchwork", "RColorBrewer",
                   "cowplot", "testthat", "rmarkdown", "knitr"))
```

## Docker

仓库中提供了 `Dockerfile` 以构建可复现环境：

```bash
docker build -t rclade .
docker run --rm -it rclade R -e 'library(Rclade); run_rclade_selftest()'
```

## 验证安装

```r
library(Rclade)
run_rclade_selftest()
```

若全部检查通过，即可开始使用。参见[入门指南](getting-started.md)。
