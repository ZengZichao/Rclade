#!/usr/bin/env Rscript
#
# Rclade Full Functional Test
# Covers P0-P3 use cases from the test plan, including performance, adversarial,
# encoding, and interrupt extension tests.
#

suppressPackageStartupMessages({
  library(testthat)
  library(Rclade)
})

set_log_level("ERROR")

base_dir <- file.path(getwd(), "tests/functional")
input_dir <- file.path(base_dir, "input")
output_dir <- file.path(base_dir, "output")
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

data(example_tree)

make_unique_tree <- function(n = 10) {
  set.seed(42)
  tree <- ape::rtree(n)
  tree$tip.label <- paste0("tip_", seq_len(n))
  tree
}

make_taxonomy_tree <- function(n_total = 30, n_classes = NULL) {
  set.seed(123)
  phyla <- c("P1", "P2", "P3")
  n_per_phylum <- max(2, floor(n_total / length(phyla)))
  if (is.null(n_classes)) n_classes <- max(1, floor(n_per_phylum / 5))
  subtrees <- list()
  for (i in seq_along(phyla)) {
    st <- ape::rtree(n_per_phylum)
    class_vec <- paste0("C", (seq_len(n_per_phylum) - 1) %% n_classes + 1)
    st$tip.label <- paste0("d__D1;p__", phyla[i], ";c__", class_vec,
                           ";o__O1;f__F1;g__", sample(letters, n_per_phylum, replace = TRUE),
                           ";s__", seq_len(n_per_phylum))
    subtrees[[i]] <- st
  }
  tree <- subtrees[[1]]
  for (i in 2:length(subtrees)) {
    tree <- ape::bind.tree(tree, subtrees[[i]])
  }
  tree
}

output_path <- function(name) {
  f <- file.path(output_dir, name)
  if (file.exists(f)) unlink(f)
  f
}

total <- 0L
pass <- 0L
fail <- 0L
skip <- 0L
results <- list()

run <- function(id, expr, blocked_by = NULL) {
  total <<- total + 1L
  name <- id
  if (!is.null(blocked_by)) {
    skip <<- skip + 1L
    results[[name]] <<- paste0("SKIP (", blocked_by, ")")
    return(invisible(NULL))
  }
  ok <- tryCatch({
    eval(expr)
    TRUE
  }, error = function(e) {
    message("FAIL: ", name, " -- ", conditionMessage(e))
    FALSE
  })
  if (isTRUE(ok)) {
    pass <<- pass + 1L
    results[[name]] <<- "PASS"
  } else {
    fail <<- fail + 1L
    results[[name]] <<- "FAIL"
  }
  invisible(NULL)
}

# ==============================================================================
# 1. Main pipeline tests (plot_timetree)
# ==============================================================================
run("P-001: phylo object input", {
  p <- plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-002: file path input", {
  p <- plot_timetree(file.path(input_dir, "test_tree_simple.nwk"), add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-003: treedata input", {
  skip_if_not_installed("treeio")
  tree <- make_unique_tree(10)
  td <- treeio::as.treedata(tree)
  p <- plot_timetree(td, rank = "none", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-004: NULL input errors", expect_error(plot_timetree(NULL), "tree"))
run("P-005: nonexistent file errors", expect_error(plot_timetree("nonexistent.tre"), "does not exist|file"))

run("P-006~009: triangle_mode four modes", {
  for (m in c("mixed", "max", "min", "none")) {
    p <- plot_timetree(example_tree, rank = "phylum", triangle_mode = m, add_timescale = FALSE)
    expect_s3_class(p, "ggplot")
  }
})

run("P-010~011: space_mode", {
  for (m in c("equal", "proportional")) {
    p <- plot_timetree(example_tree, rank = "phylum", space_mode = m, add_timescale = FALSE)
    expect_s3_class(p, "ggplot")
  }
})

run("P-012/013: invalid triangle_mode / space_mode", {
  expect_error(plot_timetree(example_tree, rank = "phylum", triangle_mode = "invalid", add_timescale = FALSE))
  expect_error(plot_timetree(example_tree, rank = "phylum", space_mode = "invalid", add_timescale = FALSE))
})

run("P-014: rectangular layout", expect_s3_class(plot_timetree(example_tree, rank = "phylum", layout = "rectangular", add_timescale = FALSE), "ggplot"))
run("P-015: circular layout", expect_s3_class(plot_timetree(example_tree, rank = "phylum", layout = "circular", add_timescale = FALSE), "ggplot"))
run("P-016: circular layout + angle", expect_s3_class(plot_timetree(example_tree, rank = "phylum", layout = "circular", angle = 180, add_timescale = FALSE), "ggplot"))
run("P-018: invalid layout errors", expect_error(plot_timetree(example_tree, rank = "phylum", layout = "radial", add_timescale = FALSE)))
run("P-019/020: timescale and layout combinations", {
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", layout = "circular", add_timescale = TRUE, unit = "Ga"), "ggplot")
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", layout = "rectangular", add_timescale = TRUE, unit = "Ga"), "ggplot")
})

run("P-021/022: 时间轴开关", {
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", add_timescale = TRUE, unit = "Ga"), "ggplot")
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE), "ggplot")
})

run("P-023/024: 单位 Ga / Ma", {
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", unit = "Ga", add_timescale = TRUE), "ggplot")
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", unit = "Ma", add_timescale = TRUE), "ggplot")
})

run("P-040~044: 分类格式", {
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", taxonomy_format = "GTDB", add_timescale = FALSE), "ggplot")
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", taxonomy_format = "Silva", add_timescale = FALSE), "ggplot")
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", taxonomy_format = "NCBI", add_timescale = FALSE), "ggplot")
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", taxonomy_format = "auto", add_timescale = FALSE), "ggplot")
})

run("P-050/051: 返回值与属性", {
  p <- plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  info <- attr(p, "rclade_info")
  expect_true(all(c("n_tips", "n_groups", "taxonomy_format", "rank", "layout") %in% names(info)))
})

run("P-060~062: 外部分类文件", {
  f <- output_path("p_taxonomy_file.pdf")
  p <- plot_timetree(file.path(input_dir, "test_tree.nwk"), rank = "class",
                     taxonomy_file = file.path(input_dir, "test_taxonomy.tsv"),
                     taxonomy_file_header = TRUE,
                     output = f, add_timescale = FALSE, overwrite = "force")
  expect_true(file.exists(f))
})

run("P-070~072: 跨等级 clade 搜索", {
  p <- plot_timetree(example_tree, clade = "P5", taxonomy_format = "GTDB", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  p2 <- plot_timetree(example_tree, clade = "C1", taxonomy_format = "GTDB", add_timescale = FALSE)
  expect_s3_class(p2, "ggplot")
  expect_error(plot_timetree(example_tree, clade = "NonExistent", taxonomy_format = "GTDB", add_timescale = FALSE))
})

run("P-080~083: 地质事件标注", {
  p1 <- plot_timetree(example_tree, rank = "phylum", geo_events = TRUE, add_timescale = TRUE, unit = "Ga")
  expect_s3_class(p1, "ggplot")
  custom <- data.frame(name = "Test", age_min = 1000, age_max = 800, color = "red", stringsAsFactors = FALSE)
  p2 <- plot_timetree(example_tree, rank = "phylum", geo_events = custom, add_timescale = TRUE, unit = "Ga")
  expect_s3_class(p2, "ggplot")
})

run("P-090~092: 高亮组合", {
  p1 <- plot_timetree(example_tree, rank = "phylum", highlight = c("LUCA", "P1"), add_timescale = FALSE)
  expect_s3_class(p1, "ggplot")
  p2 <- plot_timetree(example_tree, rank = "phylum", highlight = c("LUCA", "LBCA"), add_timescale = FALSE)
  expect_s3_class(p2, "ggplot")
})

run("P-100: taxonomy_file_priority = TRUE", {
  p <- plot_timetree(file.path(input_dir, "test_tree.nwk"), rank = "class",
                     taxonomy_file = file.path(input_dir, "test_taxonomy.tsv"),
                     taxonomy_file_header = TRUE, taxonomy_file_priority = TRUE,
                     add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
})

run("P-101/102: taxonomy_source_priority", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  tree$tip.label <- c(
    "d__D1;p__Embedded;c__A;o__A;f__A;g__A;s__A",
    "d__D1;p__Embedded;c__B;o__B;f__B;g__B;s__B",
    "d__D1;p__Embedded;c__C;o__C;f__C;g__C;s__C",
    "d__D1;p__Embedded;c__D;o__D;f__D;g__D;s__D"
  )
  tax_file <- tempfile(fileext = ".tsv")
  on.exit(unlink(tax_file), add = TRUE)
  writeLines(c(
    "tip_id\ttaxonomy",
    "d__D1;p__Embedded;c__A;o__A;f__A;g__A;s__A\td__D1;p__Table",
    "d__D1;p__Embedded;c__B;o__B;f__B;g__B;s__B\td__D1;p__Table",
    "d__D1;p__Embedded;c__C;o__O1;f__F1;g__G1;s__S1\td__D1;p__Table",
    "d__D1;p__Embedded;c__D;o__D;f__D;g__D;s__D\td__D1;p__Table"
  ), tax_file)

  p_table <- plot_timetree(tree, rank = "phylum",
                           taxonomy_file = tax_file, taxonomy_file_header = TRUE,
                           taxonomy_source_priority = "table",
                           add_timescale = FALSE)
  expect_true("Table" %in% unique(na.omit(p_table$data$Group)))

  p_embedded <- plot_timetree(tree, rank = "phylum",
                              taxonomy_file = tax_file, taxonomy_file_header = TRUE,
                              taxonomy_source_priority = "embedded",
                              add_timescale = FALSE)
  expect_true("Embedded" %in% unique(na.omit(p_embedded$data$Group)))
})

run("P-110/111: 多树 + groups", {
  tree1 <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  tree2 <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  mp <- c(tree1, tree2)
  class(mp) <- "multiPhylo"
  mp_file <- tempfile(fileext = ".tre")
  on.exit(unlink(mp_file), add = TRUE)
  ape::write.tree(mp, mp_file)
  plots <- plot_timetree(mp_file, multi_tree_mode = "all",
                         groups = list(G1 = c("A", "B")),
                         rank = "none", add_timescale = FALSE)
  expect_length(plots, 2)
})

run("P-120_128: 自定义分组", {
  tree <- ape::read.tree(text = "((A:0.1,B:0.15):0.1,(C:0.2,D:0.25):0.1):0.05;")
  groups_ok <- list(Group1 = c("A", "B"), Group2 = c("C", "D"))
  expect_s3_class(plot_timetree(tree, groups = groups_ok, add_timescale = FALSE), "ggplot")
  expect_error(plot_timetree(tree, groups = list(c("A", "B")), add_timescale = FALSE))              # 非命名 list
  empty_name_group <- list(c("A"))
  names(empty_name_group) <- ""
  expect_error(plot_timetree(tree, groups = empty_name_group, add_timescale = FALSE))                # 空组名
  expect_error(plot_timetree(tree, groups = list(G = c("X")), add_timescale = FALSE))               # tip 不存在
  expect_error(plot_timetree(tree, groups = list(G1 = c("A"), G2 = c("A")), add_timescale = FALSE)) # 重复 tip
  expect_error(plot_timetree(tree, rank = "phylum", groups = groups_ok, add_timescale = FALSE))     # rank + groups
  expect_error(plot_timetree(tree, clade = "A", groups = groups_ok, add_timescale = FALSE))         # clade + groups
})

run("P-130: low_memory 模式", {
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", add_timescale = FALSE, low_memory = TRUE), "ggplot")
})

run("P-131/132: ignore_malformed 模式", {
  tree <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  expect_error(plot_timetree(tree, clade = "NonExistent", ignore_malformed = FALSE, add_timescale = FALSE))
  expect_s3_class(plot_timetree(tree, ignore_malformed = TRUE, add_timescale = FALSE), "ggplot")

  # 批量模式：一个正常树 + 一个畸形树，ignore_malformed = TRUE 应跳过畸形树
  tree_good <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  tree_bad <- ape::read.tree(text = "((A:1,B:1):1,(C:1,D:1):1):1;")
  tree_bad$edge.length <- NULL  # 缺失 edge.length 会使 validate_inputs 报错
  mp <- c(tree_good, tree_bad)
  class(mp) <- "multiPhylo"
  mp_file <- tempfile(fileext = ".tre")
  on.exit(unlink(mp_file), add = TRUE)
  ape::write.tree(mp, mp_file)
  plots <- plot_timetree(mp_file, multi_tree_mode = "all",
                         ignore_malformed = TRUE, add_timescale = FALSE)
  expect_length(plots, 2)
  expect_s3_class(plots[[1]], "ggplot")
  expect_null(plots[[2]])
})

# ==============================================================================
# 2. 分类学解析测试
# ==============================================================================
run("T-001~008: 格式自动检测", {
  expect_equal(detect_taxonomy_format("d__D1;p__P1"), "GTDB")
  expect_equal(detect_taxonomy_format("_d_D1_p_P1"), "embedded")
  # 真实 Silva 风格标签（域名前缀）检测为 Silva；
  # 无特征前缀的编码标签保守退化为 "unknown"
  expect_equal(detect_taxonomy_format("Bacteria;P1;C1"), "Silva")
  suppressMessages(expect_equal(detect_taxonomy_format("D1;P1;C1"), "unknown"))
  expect_equal(detect_taxonomy_format("cellular organisms;D1;P1"), "NCBI")
  # 空输入通过日志系统发 WARNING 消息（log_warning 而非 warning()）
  withr::with_options(list(rclade.log_level = "WARNING"), {
    expect_message(detect_taxonomy_format(character(0)), "No valid labels")
  })
  expect_equal(detect_taxonomy_format("tip1,tip2,tip3"), "unknown")
})

run("T-010~014: 嵌入式解析", {
  r <- Rclade:::parse_embedded("GB_GCA_001_d_D1_p_P1_c_C1")
  expect_equal(r$domain[1], "D1")
  expect_equal(r$phylum[1], "P1")
})

run("T-015~017: 嵌入式 delimiter_mode", {
  label <- "prefix_d_D1_p_Foo_bar_c_C1"
  r_rev <- Rclade:::parse_embedded(label, delimiter_mode = "reverse")
  r_seg <- Rclade:::parse_embedded(label, delimiter_mode = "segment")
  r_gre <- Rclade:::parse_embedded(label, delimiter_mode = "greedy")
  expect_equal(r_seg$phylum[1], "Foo_bar")
  expect_equal(r_seg$class[1], "C1")
  expect_equal(r_rev$domain[1], "D1")
  expect_equal(r_gre$domain[1], "D1")
})

run("T-020~024: 分号式 / GTDB 解析", {
  r <- Rclade:::parse_gtdb("d__D1;p__P1;c__C1")
  expect_equal(r$domain[1], "D1")
  expect_true(is.na(Rclade:::parse_gtdb("d__D1;p__;c__")$phylum[1]))
})

run("T-030~032: Silva 解析", {
  r <- Rclade:::parse_silva("D1;P1;C1")
  expect_equal(r$domain[1], "D1")
  r2 <- Rclade:::parse_silva("D1;unclassified;C1")
  expect_true(is.na(r2$phylum[1]))
})

run("T-040~044: NCBI 解析", {
  r <- Rclade:::parse_ncbi("cellular organisms;D1;P1", quiet = TRUE)
  expect_equal(r$domain[1], "D1")
})

run("T-060~063: 分类质量报告", {
  r <- summarize_taxonomy_quality(example_tree$tip.label, format = "GTDB")
  expect_true(!is.null(r) && "format" %in% names(r))
})

# ==============================================================================
# 3. MRCA 计算与折叠测试
# ==============================================================================
run("M-001~008: MRCA 计算", {
  taxa <- Rclade:::parse_taxonomy(example_tree$tip.label, "phylum", "GTDB", NULL)
  group_vec <- setNames(taxa$Group, taxa$label)
  mrca_map <- Rclade:::compute_mrca_map(example_tree, group_vec, check_monophyly = TRUE, strict = FALSE)
  expect_type(mrca_map, "list")
  expect_true(length(mrca_map) >= 1)
})

run("M-010~012: 深度排序", {
  tree <- ape::read.tree(text = "(((A:1,B:1):1,(C:1,D:1):1):1,((E:1,F:1):1,(G:1,H:1):1):1);")
  # L-A4 起，跨组重复 tip 按设计报错（每个 tip 只能属于一个组）
  dup_groups <- list(Outer1 = c("A", "B", "C", "D"), Inner1 = c("A", "B"))
  expect_error(Rclade:::build_group_vec(dup_groups, tree$tip.label), "more than once")
  # 非重叠组的 MRCA 映射与深度排序
  groups <- list(Left = c("A", "B", "C", "D"), Right = c("E", "F", "G", "H"))
  group_vec <- Rclade:::build_group_vec(groups, tree$tip.label)
  mrca_map <- Rclade:::compute_mrca_map(tree, group_vec, check_monophyly = TRUE, strict = FALSE)
  expect_true(length(mrca_map) >= 1)
  sorted <- Rclade:::sort_by_depth(names(mrca_map), mrca_map, tree)
  expect_setequal(sorted, names(mrca_map))
})

run("M-020~028: 折叠执行", {
  p <- plot_timetree(example_tree, rank = "phylum", triangle_mode = "mixed",
                     space_mode = "proportional", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  expect_true(attr(p, "rclade_info")$n_groups >= 1)
})

# ==============================================================================
# 4. 单系群判定测试
# ==============================================================================
run("MO-001~010: 单系群判定", {
  r1 <- check_monophyly(example_tree, "P5", rank = "phylum", format = "GTDB", quiet = TRUE)
  expect_true(r1$is_monophyletic)
  r2 <- check_monophyly(example_tree, "NonExistent", rank = "phylum", format = "GTDB", quiet = TRUE)
  expect_false(r2$is_monophyletic)
  # 大小写不敏感
  r3 <- check_monophyly(example_tree, "p5", rank = "phylum", format = "GTDB", quiet = TRUE)
  expect_true(r3$is_monophyletic)
  # 非 phylo 对象报错
  expect_error(check_monophyly(data.frame(), "A", rank = "none", quiet = TRUE))
})

# ==============================================================================
# 5. 特殊标识符测试
# ==============================================================================
run("S-001~044: 特殊标识符", {
  r_root <- Rclade:::resolve_special_identifier(example_tree, "ROOT", quiet = TRUE)
  expect_equal(r_root$node, ape::Ntip(example_tree) + 1)
  r_luca <- Rclade:::resolve_special_identifier(example_tree, "LUCA", quiet = TRUE)
  expect_true(!is.null(r_luca$node))
  r_lbca <- Rclade:::resolve_special_identifier(example_tree, "LBCA", quiet = TRUE)
  expect_true(!is.null(r_lbca$node))
  expect_error(Rclade:::resolve_special_identifier(example_tree, "FOOBAR", quiet = TRUE))
  expect_equal(Rclade:::resolve_special_identifier(example_tree, "LUCA", quiet = TRUE)$node,
               Rclade:::resolve_special_identifier(example_tree, "luca", quiet = TRUE)$node)
})

# ==============================================================================
# 6. 输入验证测试
# ==============================================================================
run("V-001~010: Newick 语法验证", {
  expect_error(Rclade:::validate_newick_syntax("", "test"), "empty")
  expect_error(Rclade:::validate_newick_syntax("((A:1,B:1):1;", "test"), "unmatched")
  expect_error(Rclade:::validate_newick_syntax("(A:1,B:1)):1;", "test"), "unmatched")
  expect_error(Rclade:::validate_newick_syntax("(A:-1,B:1):1;", "test"), "Negative")
})

run("V-011~022: 树结构验证", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  expect_error(Rclade:::validate_tree_deep(data.frame(), "test"), "phylo")
  tree_bad <- tree
  tree_bad$edge <- NULL
  expect_error(Rclade:::validate_tree_deep(tree_bad, "test"))
})

run("V-040~054: 序列文件验证", {
  f <- file.path(input_dir, "test_sequences.fasta")
  expect_equal(validate_sequence_file(f), "fasta")
  r <- validate_sequence_deep(f)
  expect_true(!is.null(r$alphabet))
})

# ==============================================================================
# 7. 日志系统测试
# ==============================================================================
run("L-001~021: 日志函数", {
  expect_silent(set_log_level("DEBUG"))
  expect_error(set_log_level("INVALID"), "Invalid")
  expect_silent(set_log_enabled(FALSE))
  expect_silent(set_log_enabled(TRUE))
  tmp <- tempfile(fileext = ".log")
  on.exit(unlink(tmp), add = TRUE)
  set_log_file(tmp)
  Rclade:::log_info("test message")
  set_log_file(NULL)
  expect_true(file.exists(tmp))
})

# ==============================================================================
# 8. 中断处理测试
# ==============================================================================
run("I-001~009: 中断处理基础", {
  r <- Rclade:::with_graceful_interrupt({ 1 + 1 })
  expect_equal(r, 2)
})

run("I-004: 批量中断", {
  r <- Rclade:::batch_with_interrupt(items = 1:3, fun = function(i, idx) i * 2)
  expect_equal(r, list(2, 4, 6))
})

# ==============================================================================
# 9. 编码与跨平台测试
# ==============================================================================
run("E-001~012: 编码与路径", {
  txt <- "D1\u00e9\u00e8"  # Latin accented chars
  f <- tempfile(fileext = ".txt")
  on.exit(unlink(f), add = TRUE)
  writeLines(txt, f, useBytes = TRUE)
  expect_equal(Rclade:::detect_encoding(f), "UTF-8")
  expect_equal(Rclade:::build_path("a", "b"), file.path("a", "b"))
  d <- tempfile()
  Rclade:::ensure_dir(d)
  expect_true(dir.exists(d))
})

# ==============================================================================
# 10. 外部分类学文件测试
# ==============================================================================
run("F-001~012: 外部分类文件", {
  r <- read_taxonomy_file(file.path(input_dir, "test_taxonomy.tsv"), sep = "\t", header = TRUE)
  expect_true(!is.null(r))
  expect_true(ncol(r) >= 2)
})

# ==============================================================================
# 11. 自检模式测试
# ==============================================================================
run("ST-001: 自检全部通过", expect_equal(run_rclade_selftest(), 0L))

# ==============================================================================
# 12. 输出保存测试
# ==============================================================================
run("O-001~005: 多格式输出", {
  for (ext in c("pdf", "png", "svg")) {
    f <- output_path(paste0("full_output.", ext))
    p <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "force")
    expect_true(file.exists(f))
  }
})

run("O-006: 不支持扩展名回退 PDF", {
  f <- output_path("full_output.xyz")
  p <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "force")
  expect_true(file.exists(sub("\\.xyz$", ".pdf", f)))
})

run("O-007~009: overwrite 模式", {
  f <- output_path("full_overwrite.pdf")
  p <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "force")
  expect_true(file.exists(f))
  p2 <- plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "no-clobber")
  expect_s3_class(p2, "ggplot")
  # ask 在非交互会话降级为跳过保存（不报错、不覆盖；见 save-timetree.R M-D5）
  before <- file.info(f)$mtime
  p3 <- suppressMessages(
    plot_timetree(example_tree, rank = "phylum", output = f, add_timescale = FALSE, overwrite = "ask")
  )
  expect_s3_class(p3, "ggplot")
  expect_equal(file.info(f)$mtime, before)
})

# ==============================================================================
# 13. 批量处理测试
# ==============================================================================
run("B-001~010: batch_plot", {
  tmp_in <- tempfile()
  dir.create(tmp_in)
  on.exit(unlink(tmp_in, recursive = TRUE), add = TRUE)
  tree <- make_unique_tree(10)
  for (i in 1:3) {
    ape::write.tree(tree, file.path(tmp_in, paste0("tree_", i, ".tre")))
  }
  tmp_out <- tempfile()
  res <- batch_plot(tmp_in, output_dir = tmp_out, rank = "none", add_timescale = FALSE)
  expect_equal(length(res), 3)
})

# ==============================================================================
# 14. 可视化组件测试
# ==============================================================================
run("CL-001~011: 颜色生成", {
  expect_equal(length(Rclade:::generate_colors(character(0))), 0)
  expect_equal(length(Rclade:::generate_colors(letters[1:5], palette = "viridis")), 5)
  expect_equal(length(Rclade:::generate_colors(letters[1:5], palette = "rainbow")), 5)
  expect_equal(length(Rclade:::generate_colors(letters[1:3], palette = "Set1")), 3)
})

run("TS-001~005: 时间轴", {
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", add_timescale = TRUE, unit = "Ga"), "ggplot")
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", add_timescale = TRUE, unit = "Ma"), "ggplot")
})

run("GE-001~008: 地质事件", {
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", geo_events = TRUE, add_timescale = TRUE, unit = "Ga"), "ggplot")
})

run("LG-001~007: 图例", {
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", legend_position = "bottom", add_timescale = FALSE), "ggplot")
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", legend_position = "none", add_timescale = FALSE), "ggplot")
})

run("TH-001~004: 出版主题", {
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", theme_fun = theme_timetree, add_timescale = FALSE), "ggplot")
  expect_s3_class(plot_timetree(example_tree, rank = "phylum", theme_fun = NULL, add_timescale = FALSE), "ggplot")
})

# ==============================================================================
# 15. 对抗性输入测试
# ==============================================================================
run("AD-001~003: 恶意符号", {
  # NUL byte (\x00) 无法直接存在于 R 字符串中，改用可控控制字符 \x01 测试同一路径
  expect_error(Rclade:::validate_newick_syntax("(A\x01:1,B:1):1;", "test"))
  expect_error(Rclade:::validate_newick_syntax("(A\u202E:1,B:1):1;", "test"))
})

run("AD-004: 循环依赖", {
  df <- data.frame(domain = c("A", "B"), phylum = c("B", "A"), stringsAsFactors = FALSE)
  expect_error(Rclade:::validate_taxonomy_no_cycles(df, "test"), "Circular")
})

run("AD-007/008: 超长 / Unicode 标签", {
  # ape 5.8.1 aborts the process on labels > ~512 chars on Linux, so overlong
  # labels must go through Rclade's guarded reader, which truncates them.
  long_label <- paste0(rep("A", 10000), collapse = "")
  f <- tempfile(fileext = ".nwk")
  writeLines(paste0("(", long_label, ":1,B:1):1;"), f)
  on.exit(unlink(f), add = TRUE)
  tree <- read_tree_auto(f)
  expect_true(all(nchar(tree$tip.label) <= 500))
  expect_s3_class(plot_timetree(tree, rank = "none", add_timescale = FALSE), "ggplot")
})

# ==============================================================================
# 16. 性能与边界测试
# ==============================================================================
run("PF-001: 最小树", {
  tree <- ape::read.tree(text = "(A:1,B:1):1;")
  expect_s3_class(plot_timetree(tree, rank = "none", add_timescale = FALSE), "ggplot")
})

run("PF-002/003: 中型树性能", {
  tree <- make_unique_tree(1000)
  t <- system.time(p <- plot_timetree(tree, rank = "none", add_timescale = FALSE))
  expect_s3_class(p, "ggplot")
  expect_true(t["elapsed"] < 10)  # 放宽到 10s 避免 CI 抖动
})

run("PF-005: 多组折叠", {
  p <- plot_timetree(example_tree, rank = "class", add_timescale = FALSE)
  expect_s3_class(p, "ggplot")
  info <- attr(p, "rclade_info")
  expect_true(info$n_groups >= 5)  # example_tree 有 10 个 class，至少应折叠出若干单系 class
})

# ==============================================================================
# 17. CLI 扩展测试
# ==============================================================================
run("C-020~029: CLI 参数校验", {
  tree <- make_unique_tree(10)
  tree_file <- tempfile(fileext = ".tre")
  on.exit(unlink(tree_file), add = TRUE)
  ape::write.tree(tree, tree_file)

  # "kingdom" 是合法 rank（见 validate_cli_params），应能通过参数校验；
  # 真正非法的 rank（如 "tribe"）应返回参数错误码 2
  expect_equal(run_rclade_cli(c("-f", tree_file, "-r", "tribe")), 2L)
  expect_equal(run_rclade_cli(c("-f", tree_file, "--triangle_mode", "big")), 2L)
  expect_equal(run_rclade_cli(c("-f", tree_file, "--space_mode", "fixed")), 2L)
  expect_equal(run_rclade_cli(c("-f", tree_file, "-l", "radial")), 2L)
  expect_equal(run_rclade_cli(c("-f", tree_file, "-u", "ka")), 2L)
  expect_equal(run_rclade_cli(c("-f", tree_file, "--tree_index", "0")), 2L)
})

run("C-040~068: CLI 功能选项", {
  tree <- make_unique_tree(10)
  tree_file <- tempfile(fileext = ".tre")
  on.exit(unlink(tree_file), add = TRUE)
  ape::write.tree(tree, tree_file)

  tmp <- tempfile(fileext = ".pdf")
  on.exit(unlink(tmp), add = TRUE)
  expect_equal(run_rclade_cli(c("-f", tree_file, "-r", "none", "-o", tmp)), 0L)

  tmp2 <- tempfile(fileext = ".png")
  on.exit(unlink(tmp2), add = TRUE)
  expect_equal(run_rclade_cli(c("-f", tree_file, "-r", "none", "-l", "circular", "-o", tmp2)), 0L)
})

run("C-069: 交叉验证失败返回退出码 3", {
  tree <- make_unique_tree(10)
  tree_file <- tempfile(fileext = ".tre")
  on.exit(unlink(tree_file), add = TRUE)
  ape::write.tree(tree, tree_file)

  # 序列 ID 与树 tip label 完全不匹配
  seq_file <- tempfile(fileext = ".fasta")
  on.exit(unlink(seq_file), add = TRUE)
  writeLines(c(
    ">SEQ1", "ACGTACGT",
    ">SEQ2", "TGCATGCA"
  ), seq_file)

  expect_equal(run_rclade_cli(c("-f", tree_file, "--sequence_file", seq_file, "-r", "none")), 3L)
})

# ==============================================================================
# 7. CLI 包装脚本测试
# ==============================================================================
run("W-001/002: rclade 包装脚本", {
  wrapper <- system.file("bin/rclade", package = "Rclade")
  skip_if_not(file.exists(wrapper), "rclade wrapper not found")
  skip_if_not(file.access(wrapper, 1) == 0, "rclade wrapper not executable")

  tree <- make_unique_tree(10)
  tree_file <- tempfile(fileext = ".tre")
  on.exit(unlink(tree_file), add = TRUE)
  ape::write.tree(tree, tree_file)

  tmp <- tempfile(fileext = ".pdf")
  on.exit(unlink(tmp), add = TRUE)
  cmd <- sprintf("%s -f %s -r none -o %s --force > /dev/null 2>&1",
                 shQuote(wrapper), shQuote(tree_file), shQuote(tmp))
  expect_equal(system(cmd), 0L)
  expect_true(file.exists(tmp))

  # 参数错误应返回 2
  err_cmd <- sprintf("%s -r phylum > /dev/null 2>&1", shQuote(wrapper))
  expect_equal(system(err_cmd), 2L)
})

# ==============================================================================
# 报告输出
# ==============================================================================
cat("\n")
cat(paste(rep("=", 70), collapse = ""), "\n", sep = "")
cat("  Rclade 完整功能流程测试报告\n")
cat(paste(rep("=", 70), collapse = ""), "\n\n", sep = "")

cat(sprintf("  %-55s %s\n", "测试用例", "结果"))
cat(paste(rep("-", 70), collapse = ""), "\n", sep = "")
for (nm in names(results)) {
  cat(sprintf("  %-55s [%s]\n", nm, results[[nm]]))
}

cat("\n")
cat(paste(rep("=", 70), collapse = ""), "\n", sep = "")
cat(sprintf("  总测试数: %d\n", total))
cat(sprintf("  通过:     %d\n", pass))
cat(sprintf("  失败:     %d\n", fail))
cat(sprintf("  跳过:     %d\n", skip))
cat(sprintf("  通过率:   %.1f%%\n", (pass / total) * 100))
cat(paste(rep("=", 70), collapse = ""), "\n\n", sep = "")

if (fail > 0) {
  cat("存在失败用例，请检查上方输出。\n")
  quit(status = 1)
}
