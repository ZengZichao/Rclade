# Rclade 1.1.1（2026-09-03，CRAN 重新提交）

CRAN 重新提交，修复了 1.0.0 版本审阅中的全部问题。

* 在 DESCRIPTION 文件中添加了方法学参考文献（含 DOI）。
* 为 5 个 Rd 文件添加了 `\value` 标签（`print.rclade_options`、
  `run_rclade_shiny`、`set_log_enabled`、`set_log_file`、`set_log_level`）。
* 删除了未导出函数（`@keywords internal`）Rd 文件中的示例。
* 删除了导出函数示例中的所有 `\dontrun{}` 包装。引用外部文件的
  示例代码被完全移除；使用内置 `data(example_tree)` 的示例现在
  可直接运行。
* 将 `save_session_info()` 和 `summarize_multi_trees()` 中的
  `cat()` 替换为 `message()`，使输出可通过 `suppressMessages()` 抑制。
* 通过转换示例格式解决了 `try-error in functionTree()` 问题。

# Rclade 1.1.0（2026-08-26，修订版本）

落实 2026-08-24 独立投稿前审阅报告的全部代码级修复，含一项用户可见的行为变更。完整条目见 NEWS.md，摘要：

* **破坏性变更**：`add_timescale = TRUE` 时 `unit` 必须显式指定（移除了静默默认 Ga 并将枝长 ×1000 的行为）；非有限枝长报错；根到末端距离离散度过大时发出可审计警告。
* **分组状态计数**：`rclade_info` / `summarize_timetree()` 报告解析/折叠/单例/跳过的组数与组名，修复"Collapsed groups"误标为解析总组数的问题。
* **准确率评估修复**：改为按位置对齐并加基数断言（修复 50 末端膨胀为 250 行的 merge 缺陷）。
* **脚本可移植**：`run_process_level.sh` 从 PATH 解析 `Rscript`（可用 `RSCRIPT=` 覆盖）。
* **CI 如实描述**：`deps-smoke` 不验证 DESCRIPTION 版本下限；覆盖率为监控指标而非强制质量门。

# Rclade 1.0.0（2026-07-09，首个正式版本）

## 健壮性与渲染修复（2026-08-16，未发布）

* **折叠三角对齐修复**：当树中*所有*末端都被折叠时（如一次性折叠全部门），折叠三角形与所属分支在水平方向错位。原因是 `revts()`（时间轴反转）在折叠后被重复应用了一次——所有末端折叠掉之后 `max(x)` 不再是 0 而是最浅的 MRCA，第二次应用使整棵树平移，而坐标固定的三角形多边形未随之移动；垂直方向不受影响。现在 `revts()` 只应用一次，三角形顶点重新与 MRCA 对齐。
* **超长标签防护**：超过 500 字符的 Newick 标签在解析前被截断为 400 字符 + `_RCLADE_TRUNC` 后缀（并给出警告）。原因：ape 5.8.1 的 Newick 解析器在 Linux 上遇到超过约 512 字符的标签会使整个 R 进程崩溃（glibc "stack smashing detected"，退出码 134）。已在 `read_tree_auto()` 与 `plot_timetree()` 文档及中英 README 中说明。
* **对抗性输入报错信息**：节点名中检测到的控制字符与 Unicode BiDi 标记改以 `<U+XXXX>` 转义形式报告，不再原样输出，避免破坏终端显示。
* **测试**：两个计时比值类性能测试改为校准式重复计时块（每个规模 >= 约 100 ms），替代原先亚毫秒级的单次 `system.time()` 读数（其比值纯属时钟量化噪声，在 macOS 与 CI 上均稳定报 8 倍）。
* **CI/文档**：pkgdown 文档站恢复构建与部署（数据集条目入索引、DESCRIPTION 补站点 URL、授予写权限）；codecov 上传失败不再使 R-CMD-check 失败；中英 FAQ 中"52 个导出函数"的过时数字更正为 26。

## 清洁再分发 (2026-08-13)

* **清洁再分发（2026-08-13）**：移除所有内置第三方参考数据（`data-external/` 目录与 `inst/extdata/` 下 GTDB 参考文件）及依赖 GTDB 的脚本与测试（`scripts/extract_gtdb_node_taxonomy.R`、`scripts/benchmark_bac120_subsample.R`、`scripts/evaluate_parsing_real_data.R`、`scripts/benchmark_real_session.R`、`tests/testthat/external/`）；更新 README、CITATION、THIRDPARTY、cran-comments、CI 工作流与 vignettes 以移除对内置 GTDB 数据的引用；将格式特定的基准测试辅助函数重命名为格式中立名称。


## 综述

首个正式版本发布。将开发版 0.2.0 系列功能整理为稳定发布，并同步更新论文手稿与项目代码：

* 统一版本号为 1.0.0，体现这是第一个正式 release。
* 所有示例与结果图统一改用 `FigTree_withLACA_GBM_95CI.tree.recover`（700 末端古菌时间树，源自 Moody et al. 2025, Phil. Trans. R. Soc. B 380:20240097, doi:10.1098/rstb.2024.0097；已注明出处再分发）。
* 论文手稿补充材料完整包含《环形树折叠直线化技术文档》。
* 清理项目代码中的垃圾文件（`.DS_Store`、`tests/testthat/_problems/`、`tests/functional/output/`、空目录等）。
* 修正手稿中的路径引用、版本表述及参考文献引用。

## 项目整理

* 删除不一致的 `benchmark_results/benchmark_synthetic.csv`，保留实际引用的合并基准数据。
* 新增 `v4_config.yaml`（基于 `config.example.yaml`），使手稿中的配置示例引用真实存在。
* 从 `.Rbuildignore` / `.gitignore` 层面确保测试输出与调试产物不会被误打包。

## 兼容性与文档修复

* 修复 ggplot2 4.x 下地质时间轴不渲染的问题：`coord_geo` / `coord_geo_radial` 现以 `clip = "off"` 应用，且在启用时间轴时不再被 `coord_cartesian` 覆盖。
* 重新生成 roxygen 文档（`man/*.Rd`），消除函数签名与帮助页不一致（codoc）。
* 在 `Suggests` 声明可选依赖 `filelock`（日志文件加锁）。
* 校正 `selftest` 与 `environment.yml` 中的 ggtree 版本下限（>= 4.0.0），补齐 `Dockerfile` 的 `viridisLite`，并同步 README / 文档中的参数表与 pkgdown 引用。

---

# Rclade 0.2.0.9000（开发中）

## 修复

* **环形布局渲染方向修正（2026-07-25）**：`add_clip_off()` 中 circular 分支的 `coord_polar` 参数与 ggtree 内置不一致（`start=0, direction=1` vs ggtree 的 `start=-π/2, direction=-1`），导致环形树相对于 ggtree 原生 `layout="circular"` 产生镜像翻转。现已修正为 `coord_polar(theta="y", start=-pi/2, direction=-1, clip="off")`。
* **地质时间轴 ylim buffer 增大（2026-07-25）**：`add_geo_timescale()` 的 `y_max` buffer 从 2% 增大到 8%，`theme_timetree()` 顶部 margin 从 5pt 增大到 20pt，以避免折叠三角形顶点被裁剪。
* **GOE/NOE 地质事件条带未覆盖全树（2026-07-25）**：`add_geo_events()` 的条带 `ymax` 从基于 `p$data$y` 计算改为 `Inf`，确保条带覆盖到坐标系的完整纵向范围。

* **折叠三角形顶部被裁剪（2026-07-23）**：
  * 根因：`ggtree::collapse()` 生成的折叠三角形顶点（位于 MRCA 节点处）的 y 坐标超出基于末端节点计算的原始 y 轴面板范围，ggplot2 默认裁剪面板外内容导致顶部三角形尖端被截断。
  * 修复：`theme_timetree()` 现返回 `list(theme, coord)`，其中 `coord = coord_cartesian(clip = "off")`，并在 `pt_step7_finalize_plot()` 中同时应用主题与坐标系统，使折叠几何图形可完整渲染超出面板边界。
  * 兼容性变更：`theme_timetree()` 返回值由单一 ggplot2 主题对象改为 `list(theme, coord)`，直接调用者需改为 `p + th$theme + th$coord`。`plot_timetree()` 内部已适配，普通用户无需改动。
  * 同步更新 `man/theme_timetree.Rd` 与 `tests/testthat/test-theme.R`。

* **代码审查修复（2026-06-19）**：
  * **高严重度（P0）**：
    * 修复 `compute_mrca_map` 通过名称匹配取 tip 索引的风险，改为位置匹配确保与树严格对齐
    * 修复 `collapse_by_groups` 中 NA 颜色回退死代码，先判 NA 再调 `adjustcolor`
    * 修复 `validate_inputs` 的 `valid_ranks` 缺少 `kingdom`/`subspecies`/`k`/`ss`，现在从 `normalize_rank` 的 `rank_map` 派生
  * **中严重度（P1+P2）**：
    * 统一 clade 模式大小写比较为不敏感匹配，避免 step2 精确匹配与 step3 模糊匹配的语义矛盾
    * 为 `build_group_vec` 添加防御性检查，当 tip 不在树中时明确报错
    * 为 `read_file_utf8` 添加空文件/不存在文件的边界检查
    * 将 `validate_collapse_plan` 中 phangorn 缺失的 `warning` 改为 `log_warning` 提升可观测性
  * **低严重度（P2/P3）**：
    * 修复 `save_timetree` 的 `overwrite="ask"` 实现真正的交互询问（交互模式下使用 `readline`）
    * 修复 `detect_encoding` 的 UTF-8 判定，改用 `readLines(encoding="UTF-8")` 严格校验
    * 为 LUCA 在多域树（>2 domains）上添加警告，提示可能与 ROOT 重叠
    * 为 `add_geo_timescale` 添加 sanity 检查，当树深超出地质时间范围时警告
    * 为 `parse_custom_regex` 添加捕获组保护，无捕获组时明确报错
    * 在 logger 文档中标注线程安全问题
    * 将 `convert_unit` 和 `prepare_geo_timescales` 中的 `message()` 改为 `log_info` 统一日志出口

* **逻辑闭环审查修复（第二轮：26项缺陷）**：
  * **致命缺陷（F1-F3）**：修复 CLI 单树模式 `tryCatch` 语法错误；移除 `plot_timetree()` 双重文件读取；修复 `_pt_step7` 中 `color_palette` 作用域错误。
  * **严重缺陷（S1-S7）**：修复 clade 模式重复解析和错误 rank 分组；修复 `parse_semicolon_delimited` 多字符分隔符转义；修复 unknown 格式回退 data.frame 列数不匹配；添加颜色查找安全检查（NA 时灰色降级）；统一 MRCA=root 判断逻辑；统一 duplicate tip labels 验证等级（升级为 `stop`）；修复 LUCA 单系检查恒为 TRUE 的问题。
  * **中等缺陷（M1-M6）**：修复 `_problems` 测试用例大小写；修复 `add_geo_timescale` 双重 `revts`；清理 `detect_encoding` 死代码；修复 `read_taxonomy_file` 硬编码列名（改用 `intersect` 动态匹配）；删除 `SUPPORTED_TREE_EXTENSIONS` 重复项；改进 `convert_unit` 属性复制。
  * **第二轮新发现（R1-R5）**：移除 `timescale.R` 中与 `coord_geo` 冲突的 `scale_x_continuous`；为用户自定义 `geo_events` 添加 `name`/`color` 默认值；移除 `add_geo_timescale` 未使用的 `actual_ntips` 参数；为 `batch_plot` 新增 `overwrite` 参数；修复批量模式返回值类型标注。
  * **遗留问题（D1-D5）**：修复嵌套中断处理器的 `temp_files` 冲突（`batch_with_interrupt` 检测到嵌套时保留外层临时文件列表）；`batch_plot` 改用 `batch_with_interrupt` 获得优雅中断处理；`revts.done` 属性从 `p$data` 移至 `p` 对象；新增 22 个 CLI 参数（`--angle`、`--line_width`、`--tip_label_size`、`--legend_position`、`--highlight`、`--geo_events`、`--timescale_levels` 等）；`phangorn` 缺失时发出 `warning` 而非静默 `message`。

* **逻辑闭环审查修复（批量/中断/taxonomy_levels）**：
  * `batch_with_interrupt()` 现在使用 `results[i] <- list(...)` 保留 `NULL` 占位，CLI 批量模式对每棵树的 `plot_timetree`+`save_timetree` 调用均纳入 `tryCatch`，`--ignore_malformed` 在批量路径下真正生效。
  * 优雅中断处理移除 `invokeRestart("abort")`，改用 `tryCatch(..., interrupt = ...)` 返回部分结果；新增 `on.exit(.interrupt_env$active <- FALSE)` 保证任何退出路径都重置状态机。
  * `taxonomy_levels` 参数现在完整透传至高亮、单系性检查、特殊祖先节点解析及 `resolve_group()`；`parse_taxonomy_with_file()` 与 `summarize_taxonomy_quality_with_file()` 使用 `get_taxonomy_levels()` 动态决定 rank 列表。
  * `resolve_group()` 新增 `delimiter_mode`、`custom_patterns`、`taxonomy_levels` 参数，保证与 `check_monophyly()` / `highlight_clades()` 行为一致。
  * `clade_label_offset` 默认值统一为 `50`（Ma），文档与 `annotate_clade()` 内部默认值保持一致。
  * CLI 参数解析失败时返回退出码 `2L` 而非 `0L`。
  * `--ignore_malformed` 现在也覆盖输出文件已存在等保存阶段错误。
  * `validate_custom_groups()` 现在对空自定义分组给出明确报错。
  * `validate_tree_sequence_match()` 新增 `multi_tree_mode` 参数，CLI 透传该参数，多树文件不再直接报错。
  * 修复树-序列交叉验证失败后 `return(invisible(3L))` 位于 `tryCatch` error handler 内导致流程未终止的问题，现在交叉校验失败正确返回退出码 3。
  * 修复 `plot_timetree()` 中 `taxonomy_levels` 未透传给 `parse_taxonomy_with_file()` 导致外部分类文件组合自定义等级失效的问题。
  * 修复 `validate_taxonomy_no_cycles()` 对真实分类数据中相邻等级占位符同名（如 `phylum=SpSt-1190, class=SpSt-1190`）的误报，现在仅当跨等级存在真实的交叉循环时才终止。
* **KN-004 ~ KN-010**：修复 `--skip_length_check`、`--mol_type`、`--taxonomy_source_priority`、`--taxonomy_table_sep`、`--multi_tree_mode ask`、`--taxonomy_delimiter_mode greedy/segment`、`--low_memory`、`--ignore_malformed` 等参数的透传或实现问题
* **KN-001（部分）**：新增 `inst/bin/rclade` shell 包装脚本，可在终端使用时将 SIGINT 正确传播为退出码 130；`run_rclade_cli()` 内部已改用 `tryCatch` 捕获中断，理论上也会返回 130

## 开发规范对齐修复（2026-07-02）

依据《开发要求-通用》规范文档，补齐以下缺失能力：

* **§7 多树处理 split 模式**：`--multi_tree_mode split` 与 `all` 行为一致（返回 multiPhylo），但语义上明确表示按树拆分输出，供 Snakemake/Nextflow 等下游流水线分派。
* **§8.1 配置文件支持**：新增 `--config` 选项，支持 YAML 配置文件提供默认值。优先级为 CLI 显式参数 > 配置文件 > 内置默认值。包内附带 `config.example.yaml` 模板，列出全部可配置项。`DESCRIPTION` 的 Suggests 新增 `yaml`。
* **§8.2 库模式 API**：导出 `parse_taxonomy()` 和 `read_tree_auto()` 作为稳定库模式 API，供 Snakemake/Nextflow 等外部工作流直接调用，无需通过 `plot_timetree()` 入口。
* **§9.1.1 注释剥离**：新增 `--strip_annotations` 选项及 `strip_tree_annotations()` 辅助函数，可在渲染前剥离 bootstrap/NHX 节点注释以减小输出体积。批处理与单树路径均已接入。
* **§10.1 临时文件权限**：`managed_tempfile()` 创建后立即 `Sys.chmod(mode = "0600")`，`managed_tempdir()` 创建后立即 `Sys.chmod(mode = "0700")`，满足 HPC 共享环境下的安全要求。
* **§12.1 CI 覆盖率阈值**：新增 `codecov.yml`，整体覆盖率和 patch 覆盖率目标均为 85%，core 模块（parse-taxonomy/taxonomy-file/validate-deep/monophyly/compute-mrca/read-input）单独标记；CI 工作流 `fail_ci_if_error` 保持为 `false`（未配置 CODECOV_TOKEN），覆盖率上传失败不会使工作流失败，覆盖率是监控指标而非强制质量门（v1.1.0 据实更正，审稿意见问题 7）。
* **§15 错误信息 [MODULE/FUNCTION] 格式**：logger 的 `log_message()` 及所有公开日志函数（`log_info`/`log_warning`/`log_error`/`log_debug`/`log_critical`）新增可选 `.module` 参数，传入后在日志中插入 `[MODULE/FUNCTION]` 标签。关键 `stop()` 和 `log_warning`/`log_error` 调用已打上来源标签（如 `[validate-deep/check_name_safety]`、`[compute-mrca/compute_mrca_map]` 等）。
* **文档同步**：README.CN.md / README.EN.md / man/*.Rd 全部同步更新新增功能说明。

# Rclade 0.2.0 (2026-06-12)

## 新功能

### 多树处理

* **智能多树检测**：自动检测包含多棵树的文件
* **用户可控行为**：检测到多棵树时，给出信息性错误并提示用户指定处理方式
* **灵活选项**：`--tree_index N` 选择特定树，`--multi_tree_mode` 批量处理（first/last/random/all）
* **批量输出**：使用 `--multi_tree_mode all` 时，输出文件自动附加树索引后缀

### 增强的输入验证

* **深度 Newick 语法验证**：括号平衡、负分支长度检测（CRITICAL）、空节点名、重复节点名、分号结尾检查
* **深度树结构验证**：自环检测、多根检测、负分支长度（CRITICAL，终止）、空末端标签、重复末端标签、边矩阵一致性
* **多树摘要**：检测到多棵树时，在报错前打印每棵树的 tip/节点数摘要
* **序列文件验证**：FASTA/FASTQ 格式检测、重复 ID 检查（ERROR，终止）、字母表自动检测（DNA/RNA/protein）、非法字符定位（行号）、比对长度一致性检查
* **格式自动检测**：通过扩展名和内容检测树格式（Newick/Nexus/BEAST）和序列格式（FASTA/FASTQ）

### 双格式分类学解析

* **格式 A（嵌入式）**：`_d_Bacteria_p_Cyanobacteriota_...`，使用 `_X_` 分隔符
* **格式 B（分号分隔式）**：`d__Bacteria;p__Cyanobacteriota;...`，使用 `X__` 前缀
* **统一数据结构**：两种格式都映射到标准 `{domain, phylum, class, order, family, genus, species}`
* **缺失值处理**：`s__`（空物种）解析为 NA 并记录 DEBUG 日志；缺失等级优雅处理
* **可配置分类等级**：通过 `--taxonomy-levels` 支持扩展等级（kingdom `_k_`、subspecies `_ss_`）

### 跨平台与编码鲁棒性

* **显式 UTF-8**：所有文件读写使用 `encoding="UTF-8"`，编码问题时有回退和 WARNING
* **BOM 处理**：检测并移除 UTF-8 BOM 标记
* **安全路径构建**：`build_path()` 使用 `file.path()`，不用字符串拼接路径
* **换行符归一化**：所有换行符归一化为 Unix 风格（`\n`）
* **托管临时文件**：`managed_tempfile()` 和 `managed_tempdir()` 自动清理

### 优雅中断处理

* **SIGINT (Ctrl+C) 支持**：捕获中断信号、报告进度、清理资源
* **进度报告**：中断时显示已完成/总数和已用时间
* **资源清理**：关闭打开的连接、删除未完成的临时文件
* **批量模式**：`batch_with_interrupt()` 为多树处理提供优雅终止
* **退出码**：用户中断时返回退出码 130（标准 Unix 约定）

### 对抗性输入防护

* **恶意符号注入**：检测节点名中的控制字符（\\x00-\\x1f）和 Unicode BiDi 标记（\\u202E 等），以 ERROR 拒绝
* **零宽字符检测**：警告零宽空格（\\u200B）等不可见字符
* **循环依赖检测**：识别分类表中的循环（例如 d__A;p__B 与 d__B;p__A）
* **空文件拒绝**：0 字节树/序列文件触发 CRITICAL 错误并终止

### 实时日志系统

* **带时间戳输出**：每条日志消息包含时间戳和已用时间
* **步骤跟踪**：多步骤操作显示 [step/total] 进度
* **多级日志**：DEBUG、INFO、WARNING、ERROR、CRITICAL
* **纯文本输出**：无 ANSI 颜色或特殊 Unicode 字符
* **性能计时器**：内置计时函数用于性能测试

### 增强的 CLI 接口

* **标准参数解析**：使用 optparse 库进行稳健的参数处理
* **完整帮助系统**：`-h/--help` 输出所有参数、默认值和用法示例
* **版本选项**：`-v/--version` 显示包版本、git hash 和依赖版本
* **参数验证**：输入文件存在性检查、枚举值验证、数值范围检查
* **详细错误信息**：无效参数给出清晰错误信息

### 外部分类学文件支持

* **基于文件的分类学**：从外部 TSV/CSV 文件读取分类学信息
* **优先级控制**：选择文件分类学覆盖或补充标签解析
* **质量报告**：扩展函数 `summarize_taxonomy_quality_with_file()`

### 特殊祖先节点标识符

* **LUCA**：最后共同祖先（Bacteria 和 Archaea 的 MRCA）
* **LACA**：最后古菌共同祖先
* **LBCA**：最后细菌共同祖先
* **单系性检查**：验证这些类群是否为单系群

### 单系群验证

* **自动单系性检查**：按分类等级折叠前，先检查每组是否为单系群
* **非单系群跳过**：非单系群以信息性警告跳过
* **外来 tip 识别**：警告信息包含 MRCA 子树中不属于该组的外来 tip 数量和名称

## 改进

* **ASCII 艺术 Logo**：启动时显示风格化 Logo（无 Unicode/emoji）
* **更好的错误信息**：多树文件的错误信息更具信息性
* **CLI 增强**：新增多树处理和日志级别控制命令行选项
* **示例树改进**：示例树在所有分类等级上具有正确的单系群

## Bug 修复

* 修复多树处理，使其正确中断并请求用户指定
* 修复 CLI `--help`/`--version` 调用 `stop()` 终止 R 进程的问题，改为正常返回退出码
* 抑制 `tidytree::as_tibble()` 产生的 `Invalid edge matrix` 警告

## 新增导出函数

* `detect_taxonomy_format()`：检测分类标签格式（GTDB/Silva/NCBI/嵌入式），现可直接调用

## 依赖

**必需**：ape (>= 5.0)、ggtree (>= 4.0.0)、deeptime (>= 1.0)、ggplot2 (>= 3.5)、stringr (>= 1.5)、tidytree (>= 0.4)

**可选**：treeio（BEAST2/IQ-TREE 支持）、phangorn（嵌套检测）、viridisLite/RColorBrewer（调色板）、cowplot/patchwork（图例分离）、shiny（Web UI）、optparse（CLI）

---

# Rclade 0.1.0 (2026-05-07)

## 初始发布

### 核心功能

* **自动分类标签解析**：支持 GTDB、Silva、NCBI、custom_rank 和 custom_regex 格式
* **批量分支折叠**：嵌套感知的深度优先排序，自动冲突检测
* **地质时间轴集成**：通过 deeptime 包实现自适应时间刻度（Ma/Ka）
* **智能图例布局**：根据分组数量自动调整行列
* **色盲友好调色板**：默认 viridis，回退链（viridis -> hcl.colors -> rainbow）

### 可视化功能

* **节点支持值显示**：兼容 BEAST2/IQ-TREE posterior/bootstrap 值
* **HPD 区间可视化**：显示最高后验密度区间
* **分支标注标签**：可配置偏移量和字号
* **出版级主题**：自定义 `theme_timetree()` 实现高质量输出
* **多种布局**：矩形和环形树布局

### 输入/输出

* **多种输入格式**：Newick (.nwk/.tre)、Nexus (.nexus/.nex)、treedata 对象
* **多种输出格式**：PDF、PNG、TIFF、SVG、EPS
* **批量处理**：带进度跟踪的目录批量处理

### 用户接口

* **CLI 接口**：通过 optparse 实现的全功能命令行接口
* **Shiny Web 接口**：交互式 Web 可视化

### 质量与可重复性

* **输入验证**：全面的参数检查和单位合理性测试
* **会话信息导出**：`save_session_info()` 保证可重复性
* **分类学质量报告**：`summarize_taxonomy_quality()` 用于标签解析诊断

## 已知限制

* NCBI 分类解析使用基于位置的等级映射，非标准谱系可能产生偏移

## 依赖

**必需**：ape (>= 5.0)、ggtree (>= 4.0.0)、deeptime (>= 1.0)、ggplot2 (>= 3.5)、stringr (>= 1.5)、tidytree (>= 0.4)

**可选**：treeio（BEAST2/IQ-TREE 支持）、phangorn（嵌套检测）、viridisLite/RColorBrewer（调色板）、cowplot/patchwork（图例分离）
