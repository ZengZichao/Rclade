# Build example tree data for Rclade
# Run this script once to generate data/example_tree.rda
#
# Tree topology is built deterministically to ensure:
# 1. Fully bifurcating (no polytomies)
# 2. Each phylum and class is monophyletic with proper MRCA nodes
# 3. Classification hierarchy is consistent (phylum > class > species)

set.seed(42)
library(ape)

# Define taxonomy hierarchy using codes instead of real taxon names.
# Domain = D1; Phyla = P1..P5; Classes = C1..C10.
taxonomy <- list(
  "P1" = c("C1", "C2"),
  "P2" = c("C3", "C4"),
  "P3" = c("C5", "C6"),
  "P4" = c("C7", "C8"),
  "P5" = c("C9", "C10")
)

phylum_names <- names(taxonomy)

# ---------------------------------------------------------------------------
# Helper: build a bifurcating Newick subtree from a vector of tip labels
# Uses recursive binary splitting
# ---------------------------------------------------------------------------
build_binary_clade <- function(labels) {
  n <- length(labels)
  if (n == 1) {
    return(labels[1])
  }
  mid <- ceiling(n / 2)
  left <- build_binary_clade(labels[1:mid])
  right <- build_binary_clade(labels[(mid + 1):n])
  paste0("(", left, ",", right, ")")
}

# ---------------------------------------------------------------------------
# Build the full tree structure:
# 5 phyla, each with 2 classes, each with 5 species
# This ensures each phylum and class has a proper MRCA (not root)
# ---------------------------------------------------------------------------
tip_counter <- 1
phylum_clades <- character(5)
tip_taxonomy <- list()  # Store taxonomy for each tip

for (i in 1:5) {
  phylum <- phylum_names[i]
  classes <- taxonomy[[phylum]]

  class_clades <- character(2)
  for (j in 1:2) {
    class_name <- classes[j]
    tips <- paste0("sp", sprintf("%03d", tip_counter:(tip_counter + 4)))
    tip_counter <- tip_counter + 5

    # Store taxonomy for each tip
    for (tip in tips) {
      tip_taxonomy[[tip]] <- list(
        domain = "D1",
        phylum = phylum,
        class = class_name
      )
    }

    class_clades[j] <- build_binary_clade(tips)
  }

  # Bind 2 classes into a phylum (binary)
  phylum_clades[i] <- paste0("(", class_clades[1], ",", class_clades[2], ")")
}

# Bind 5 phyla into root using nested binary structure
# (((p1,p2),p3),(p4,p5))  -- fully bifurcating
root_clade <- paste0(
  "(((", phylum_clades[1], ",", phylum_clades[2], "),", phylum_clades[3], "),(",
  phylum_clades[4], ",", phylum_clades[5], "))"
)

newick_str <- paste0(root_clade, ";")
example_tree <- read.tree(text = newick_str)

# ---------------------------------------------------------------------------
# Assign branch lengths (~3000 Ma, STRICTLY ultrametric)
# All tips must be at exactly the same depth (3000 Ma) so that after revts()
# they align at x = 0 (present time).
# ---------------------------------------------------------------------------
set.seed(42)
n_edges <- nrow(example_tree$edge)

# Initialize all edge lengths
example_tree$edge.length <- numeric(nrow(example_tree$edge))

# Step 1: Assign internal edge lengths (small, positive, with slight variation)
internal_edges <- example_tree$edge[, 2] > length(example_tree$tip.label)
example_tree$edge.length[internal_edges] <- runif(sum(internal_edges), 40, 80)

# Step 2: Assign terminal edge lengths so that ALL tips reach exactly 3000 Ma
# parent_depth + terminal_length = 3000
for (i in seq_along(example_tree$edge.length)) {
  child <- example_tree$edge[i, 2]
  if (child <= length(example_tree$tip.label)) {
    parent_node <- example_tree$edge[i, 1]
    parent_depth <- node.depth.edgelength(example_tree)[parent_node]
    example_tree$edge.length[i] <- 3000 - parent_depth
  }
}

# Verify ultrametric
tip_depths <- node.depth.edgelength(example_tree)[1:length(example_tree$tip.label)]
if (max(tip_depths) - min(tip_depths) > 1e-6) {
  warning("Tree is not strictly ultrametric!")
}

# ---------------------------------------------------------------------------
# Assign taxonomy labels
# The tip order in read.tree follows the Newick order
# ---------------------------------------------------------------------------
tip_labels <- character(50)
for (i in 1:50) {
  tip_name <- paste0("sp", sprintf("%03d", i))
  tax <- tip_taxonomy[[tip_name]]
  tip_labels[i] <- paste0(
    "d__", tax$domain,
    ";p__", tax$phylum,
    ";c__", tax$class
  )
}
example_tree$tip.label <- tip_labels

# ---------------------------------------------------------------------------
# Generate simulated HPD (Highest Posterior Density) intervals for all nodes
# This enables demonstration of the show_hpd feature in plot_timetree()
# ---------------------------------------------------------------------------
n_nodes <- ape::Ntip(example_tree) + ape::Nnode(example_tree)
node_heights <- node.depth.edgelength(example_tree)

# Create HPD intervals with ~10% uncertainty around each node height
set.seed(42)
hpd_list <- lapply(1:n_nodes, function(i) {
  h <- node_heights[i]
  # Uncertainty proportional to depth, with a minimum of 20 Ma
  unc <- max(20, h * runif(1, 0.05, 0.15))
  lower <- max(0, h - unc)
  upper <- h + unc
  c(lower, upper)
})

example_tree$node.data <- data.frame(
  node = 1:n_nodes,
  height = node_heights,
  height_0.95_HPD = I(hpd_list),
  stringsAsFactors = FALSE
)

cat("Simulated HPD intervals generated for", n_nodes, "nodes\n")

# ---------------------------------------------------------------------------
# Save and verify
# ---------------------------------------------------------------------------
save(example_tree, file = "data/example_tree.rda")
cat("Example tree saved to data/example_tree.rda\n")

# Extract and display taxonomy distribution
tip_phyla <- sapply(tip_taxonomy, function(x) x$phylum)
tip_classes <- sapply(tip_taxonomy, function(x) x$class)

cat("\nPhylum distribution:\n")
print(table(tip_phyla))

cat("\nClass distribution:\n")
print(table(tip_classes))

cat("\nVerifying monophyly of phyla:\n")
for (p in phylum_names) {
  tips <- grep(paste0("p__", p), example_tree$tip.label)
  mrca <- getMRCA(example_tree, tips)
  is_mono <- is.monophyletic(example_tree, tips)
  cat(sprintf("  %-20s: monophyletic=%s, MRCA node=%d, n_tips=%d\n",
      p, is_mono, mrca, length(tips)))
}

cat("\nVerifying monophyly of classes:\n")
all_classes <- unique(unlist(taxonomy))
for (cl in all_classes) {
  # Use an anchored regex so "C1" does not match "C10"
  tips <- grep(paste0("c__", cl, "(;|$)"), example_tree$tip.label)
  if (length(tips) > 0) {
    mrca <- getMRCA(example_tree, tips)
    is_mono <- is.monophyletic(example_tree, tips)
    cat(sprintf("  %-25s: monophyletic=%s, MRCA node=%d, n_tips=%d\n",
        cl, is_mono, mrca, length(tips)))
  }
}

cat("\nIs tree bifurcating:", is.binary(example_tree), "\n")
cat("Any polytomies:", any(tabulate(example_tree$edge[, 1]) > 2), "\n")

# Check branch lengths
cat("Max tip depth:", max(node.depth.edgelength(example_tree)), "Ma\n")
cat("Min edge length:", min(example_tree$edge.length), "\n")

# Verify no MRCA is at root
root_node <- Ntip(example_tree) + 1
cat("\nRoot node:", root_node, "\n")
cat("All phyla MRCA are NOT root:",
    all(sapply(phylum_names, function(p) {
      tips <- grep(paste0("p__", p), example_tree$tip.label)
      getMRCA(example_tree, tips) != root_node
    })), "\n")
