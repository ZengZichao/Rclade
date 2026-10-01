# Security Policy / 安全策略

## Reporting a Vulnerability / 报告漏洞

请通过 GitHub 的私密渠道报告安全问题：进入本仓库 **Security 标签页 → Security advisories → Report a vulnerability**，不要在公开 Issue 中披露漏洞细节。

Please report security vulnerabilities privately via GitHub's **Security tab → Security advisories → Report a vulnerability**. Do not open public issues with exploit details.

报告时请尽量附上：Rclade 版本（`packageVersion("Rclade")`）、操作系统与 R 版本、复现步骤或最小复现文件。

When reporting, please include: the Rclade version (`packageVersion("Rclade")`), OS and R version, and reproduction steps or a minimal reproducible input.

## Supported Versions / 支持版本

| Version | Supported |
|---------|-----------|
| latest release | :white_check_mark: |
| older releases | :x: |

只对最新发布版本提供安全修复；旧版本请升级后复测。CRAN 上的发布版本以 CRAN 页面为准。

Security fixes target the latest release only. Please upgrade and re-test before reporting on older versions.

## Scope / 关注范围

Rclade 在本地处理用户提供的系统发育树与分类数据，重点关注：

- 文件解析与外部文件读取路径（Newick/NEXUS 树文件、外部分类表）
- CLI 包装脚本（`inst/bin/rclade`）与 Shiny 界面的输入处理
- 依赖供应链（CRAN / Bioconductor 传递依赖）

Rclade processes user-provided phylogenetic trees and taxonomy data locally. Focus areas: file parsing and external-file reading paths (Newick/NEXUS trees, external taxonomy tables), input handling in the CLI wrapper (`inst/bin/rclade`) and the Shiny app, and the dependency supply chain (CRAN / Bioconductor transitive dependencies).
