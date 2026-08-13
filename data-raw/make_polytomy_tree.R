# Build example tree with polytomies for testing
# This tree intentionally has multifurcations at certain nodes

set.seed(123)
library(ape)

# Create a tree with polytomies
# Structure: ((A,B,C),(D,E),(F,G,H,I))
# The first clade has 3 species (polytomy), second has 2, third has 4

polytomy_newick <- "((sp001,sp002,sp003),(sp004,sp005),(sp006,sp007,sp008,sp009));"
polytomy_tree <- read.tree(text = polytomy_newick)

# Add branch lengths
set.seed(123)
polytomy_tree$edge.length <- runif(length(polytomy_tree$edge.length), 100, 500)

# Add tip labels with coded taxonomy (D1 = domain; P1-P3 = phyla; C1-C5 = classes)
polytomy_tree$tip.label <- c(
  "d__D1;p__P1;c__C1",
  "d__D1;p__P1;c__C1",
  "d__D1;p__P1;c__C2",
  "d__D1;p__P2;c__C3",
  "d__D1;p__P2;c__C3",
  "d__D1;p__P3;c__C4",
  "d__D1;p__P3;c__C4",
  "d__D1;p__P3;c__C5",
  "d__D1;p__P3;c__C5"
)

cat("Polytomy tree created:\n")
cat("Number of tips:", Ntip(polytomy_tree), "\n")
cat("Is binary:", is.binary(polytomy_tree), "\n")
cat("Polytomies found:", any(tabulate(polytomy_tree$edge[, 1]) > 2), "\n")

# Save
save(polytomy_tree, file = "data/polytomy_tree.rda")
cat("\nPolytomy tree saved to data/polytomy_tree.rda\n")
