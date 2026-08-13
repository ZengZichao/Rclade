# Build internal geological timescale data
# Based on ICS (International Commission on Stratigraphy) 2023/2024 standard
# Reference: https://stratigraphy.org/ICSchart/ChronostratChart2023-09.pdf
# Run this script once to generate R/sysdata.rda

geo_eons <- data.frame(
  name = c("Hadean", "Archean", "Proterozoic", "Phanerozoic"),
  abbr = c("Hadean", "Archean", "Proterozoic", "Phan."),
  max_age = c(4567, 4031, 2500, 538.8),
  min_age = c(4031, 2500, 538.8, 0),
  color = c("#B41E8D", "#F9A602", "#7B3F00", "#87CEEB"),
  lab_color = c("white", "black", "white", "black"),
  stringsAsFactors = FALSE
)

geo_eras <- data.frame(
  name = c("Eoarchean", "Paleoarchean", "Mesoarchean", "Neoarchean",
           "Paleoproterozoic", "Mesoproterozoic", "Neoproterozoic",
           "Paleozoic", "Mesozoic", "Cenozoic"),
  abbr = c("Eoar.", "Palear.", "Mesoar.", "Neoar.",
           "Paleoprot.", "Mesoprot.", "Neoprot.",
           "Paleozoic", "Mesozoic", "Cenozoic"),
  max_age = c(4031, 3600, 3200, 2800, 2500, 1600, 1000, 538.8, 251.902, 66),
  min_age = c(3600, 3200, 2800, 2500, 1600, 1000, 538.8, 251.902, 66, 0),
  color = c("#F9A602", "#FFD700", "#FFA500", "#FF8C00",
            "#7B3F00", "#8B4513", "#A0522D",
            "#9ACD32", "#5F9EA0", "#FFDAB9"),
  lab_color = c("black", "black", "black", "black",
                "white", "white", "white",
                "black", "white", "black"),
  stringsAsFactors = FALSE
)

geo_periods <- data.frame(
  name = c("Ediacaran", "Cryogenian", "Tonian",
           "Cambrian", "Ordovician", "Silurian", "Devonian", "Carboniferous", "Permian",
           "Triassic", "Jurassic", "Cretaceous",
           "Paleogene", "Neogene", "Quaternary"),
  abbr = c("Ediac.", "Cryog.", "Ton.",
           "Camb.", "Ord.", "Sil.", "Dev.", "Carb.", "Perm.",
           "Tri.", "Jura.", "Cret.",
           "Paleog.", "Neo.", "Quat."),
  max_age = c(635, 720, 1000,
               538.8, 485.4, 443.8, 419.2, 358.9, 298.9,
               251.902, 201.4, 145,
               66, 23.03, 2.58),
  min_age = c(538.8, 635, 720,
               485.4, 443.8, 419.2, 358.9, 298.9, 251.902,
               201.4, 145, 66,
               23.03, 2.58, 0),
  color = c("#9932CC", "#8B008B", "#6A0DAD",
            "#7FFFD4", "#00CED1", "#48D1CC", "#008B8B", "#2E8B57", "#228B22",
            "#8B0000", "#CD853F", "#FFFF00",
            "#FFDAB9", "#FFE4B5", "#FFFACD"),
  lab_color = c("white", "white", "white",
                "black", "black", "black", "white", "white", "white",
                "white", "black", "black",
                "black", "black", "black"),
  stringsAsFactors = FALSE
)

# Save as internal data (sysdata.rda)
usethis::use_data(geo_eons, geo_eras, geo_periods, internal = TRUE, overwrite = TRUE)

cat("Geological timescale data saved to R/sysdata.rda\n")
