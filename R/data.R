# Copyright (c) 2026 Zeng Zichao
# Licensed under the MIT License (see LICENSE file)

#' Example phylogenetic tree with GTDB-style labels
#'
#' A \code{phylo} object with 50 tips containing GTDB-format taxonomic labels
#' spanning 5 coded phyla (P1, P2, P3, P4, P5) and 10 coded classes (C1, ..., C10)
#' for demonstration and testing purposes. Branch lengths are in Ma (mega-annum).
#' This tree is fully bifurcating with proper monophyletic groups at all
#' taxonomic levels. All labels are artificial codes, not real taxon names.
#'
#' @format A \code{phylo} object with 50 tips and 49 internal nodes.
#' @usage data(example_tree)
#' @source Simulated data for package demonstration.
"example_tree"

#' Example phylogenetic tree with polytomies
#'
#' A \code{phylo} object with 9 tips containing intentional polytomies
#' (multifurcations) for testing polytomy handling. This tree has a structure
#' of ((A,B,C),(D,E),(F,G,H,I)) with three multifurcating clades.
#'
#' @format A \code{phylo} object with 9 tips.
#' @usage data(polytomy_tree)
#' @source Simulated data for testing polytomy handling.
"polytomy_tree"
