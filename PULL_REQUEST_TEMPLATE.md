# NA

## Summary / 摘要

## Changes / 改动内容

- 

## Checklist / 检查项

`R-CMD-check` 全平台通过（含 macOS）。`R-CMD-check` passes on all
platforms (including macOS).

`Functional Tests` 通过（若改动涉及 `R/**` 或
`tests/functional/**`）。`Functional Tests` pass (required when `R/**`
or `tests/functional/**` changed).

导出函数变更已用 roxygen2 更新文档，并运行
`devtools::document()`。Exported-function changes documented with
roxygen2 and `devtools::document()` run.

用户可见行为变更已更新 `NEWS.CN.md` / `NEWS.EN.md`。User-visible
behavior changes recorded in both `NEWS.CN.md` and `NEWS.EN.md`.

涉及 CRAN 提交的改动已核对 `cran-comments.md` 与
`CRAN-SUBMISSION`。CRAN-submission changes checked against
`cran-comments.md` and `CRAN-SUBMISSION`.

复现性相关改动已核对 `REPRODUCIBILITY.md` / `MANIFEST.tsv` /
`.zenodo.json`。Reproducibility changes checked against
`REPRODUCIBILITY.md`, `MANIFEST.tsv` and `.zenodo.json`.
