# 为 Rclade 做贡献

> **说明：** GitHub 仓库位于 https://github.com/zengzichao/Rclade，欢迎提交 Issue 和 Pull Request。

感谢您对 Rclade 的兴趣！

## 报告问题

请在 https://github.com/zengzichao/Rclade/issues 提交 Issue。

报告 bug 时，请包含：
- 最小可复现示例
- 您的 R 会话信息（`sessionInfo()`）
- 预期行为与实际行为

## 开发环境设置

```r
# 克隆仓库
git clone https://github.com/zengzichao/Rclade.git

# 安装开发依赖
install.packages(c("devtools", "testthat", "roxygen2", "knitr", "rmarkdown"))

# Bioconductor 依赖
tryCatch({
  library(BiocManager)
}, error = function(e) {
  install.packages("BiocManager")
})
BiocManager::install(c("ggtree", "treeio", "tidytree"))

# 以开发模式加载包
devtools::load_all(".")

# 运行测试
devtools::test()

# 检查包
devtools::check()

# 构建文档
devtools::document()
```

## 代码风格

- 遵循 [Google R Style Guide](https://google.github.io/styleguide/Rguide.html)
- 函数名和变量名使用 `snake_case`
- 所有导出函数使用 roxygen2 文档
- 非导出函数添加 `@keywords internal`
- 修改 roxygen 注释后，运行 `devtools::document()` 以保持 `man/` 同步

## Pull Request 流程

1. Fork 仓库
2. 创建功能分支（`git checkout -b feature/my-feature`）
3. 进行修改
4. 为新功能添加测试
5. 运行 `devtools::check()` 确保没有回归
6. 提交 Pull Request

## 测试

```r
# 运行所有测试
devtools::test()

# 运行单个测试文件
testthat::test_file("tests/testthat/test-taxonomy.R")

# 检查测试覆盖率
covr::package_coverage()
```

## 文档

- 如果用户可见行为发生变化，请同时更新 `README.EN.md` 和 `README.CN.md`。
- 重要变更请更新 `NEWS.EN.md` 和 `NEWS.CN.md`。
- 修改 roxygen 注释后，使用 `devtools::document()` 重新生成 `man/` 页面。

## 许可证

通过贡献，您同意您的贡献将在 MIT 许可证下授权。
