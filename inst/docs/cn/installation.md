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

## 使用 Conda 安装

仓库根目录提供了 `environment.yml`，可一次性创建包含 R 及其依赖的环境：

```bash
conda env create -f environment.yml
conda activate rclade
```

`environment.yml` 不含 Rclade 本身，环境激活后仍需按上文“从 CRAN 安装”或“安装开发版”小节的步骤安装。

> **可重复性说明**：`environment.yml` 指定最低版本下界。若需完全可重复的环境，创建后导出显式规格：
>
> ```bash
> conda list --explicit > conda-lockfile.txt
> # 恢复：conda create --name rclade --file conda-lockfile.txt
> ```
>
> 也可在 R 内使用 `renv` 进行包级锁定。

## 依赖

Rclade 依赖：`ape`、`ggtree`、`deeptime`、`ggplot2`、`rlang`、`stringr`、`tidytree`、`viridisLite`。

建议安装（部分功能需要）：`treeio`、`phangorn`、`RColorBrewer`、`cowplot`、`patchwork`、`shiny`、`optparse`、`yaml`、`testthat`、`knitr`、`rmarkdown`。此外，测试套件还会用到 `vdiffr`、`covr`、`filelock`、`withr`。

若计划使用 Shiny 应用、命令行或运行测试，请安装：

```r
install.packages(c("shiny", "optparse", "patchwork", "RColorBrewer",
                   "cowplot", "testthat", "rmarkdown", "knitr"))
```

## Docker

仓库中提供了 `Dockerfile` 以构建可复现环境。镜像的默认入口点就是 Rclade 命令行（`run_rclade_cli()`）：

```bash
docker build -t rclade .
docker run --rm -it --init rclade --help
```

`docker run` 加 `--init` 后由 Docker 注入 tini 作为 PID 1，才能把 Ctrl+C（SIGINT）转发给入口点，从而按约定返回退出码 130。

若要在容器内直接运行 R 代码，必须用 `--entrypoint` 覆盖默认入口点；否则 `R` 会被当成命令行参数而报错：

```bash
docker run --rm -it --entrypoint R rclade -e 'library(Rclade); run_rclade_selftest()'
```

自检也可以直接走命令行选项：

```bash
docker run --rm -it --init rclade --check
```

## 验证安装

```r
library(Rclade)
run_rclade_selftest()
```

若全部检查通过，即可开始使用。参见[入门指南](getting-started.md)。
