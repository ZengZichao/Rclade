# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

# Package startup and version-compatibility guards
#
# .onAttach is placed here (zzz.R) following standard R package conventions,
# ensuring it is always sourced regardless of file load order.

.onAttach <- function(libname, pkgname) {
  if (requireNamespace("ggtree", quietly = TRUE)) {
    ggtree_ver <- utils::packageVersion("ggtree")
    if (ggtree_ver < package_version("4.0") || ggtree_ver >= package_version("5.0")) {
      packageStartupMessage(
        "NOTE: Rclade was developed and tested with ggtree 4.x (tested on 4.0.4). ",
        "Custom GeomPolygonStraight / GeomSegmentStraight behaviour may change ",
        "with ggtree version ", ggtree_ver, "."
      )
    }
  }
  if (requireNamespace("ggplot2", quietly = TRUE)) {
    ggplot2_ver <- utils::packageVersion("ggplot2")
    if (ggplot2_ver < package_version("3.5") || ggplot2_ver >= package_version("5.0")) {
      packageStartupMessage(
        "NOTE: Rclade was developed and tested with ggplot2 3.5.x-4.x. ",
        "Custom GeomPolygonStraight / GeomSegmentStraight rely on coord$transform() ",
        "and internal constants (e.g. .pt) that may differ in ggplot2 ",
        "version ", ggplot2_ver, "."
      )
    }
  }
}
