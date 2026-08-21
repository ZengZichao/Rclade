# Evaluation Data

Supporting evaluation data for the Rclade manuscript (Molecular Ecology
Resources submission).

| File | Description |
|---|---|
| `parsing_accuracy_real_data.csv` | Real-data parsing accuracy on the complete GTDB R232 ar53 taxonomy table (10,122 labels): non-NA rate and exact-match rate at all seven ranks (domain to species), all 100%. |
| `verify_gtdb_parsing_accuracy.R` | Reproducible verification script. Run: `Rscript verify_gtdb_parsing_accuracy.R <ar53_taxonomy.tsv> <out.csv>` with Rclade >= 1.0.0 installed. |

The GTDB ar53 taxonomy table is obtained from the Genome Taxonomy Database
(https://gtdb.ecogenomic.org/downloads; CC BY-SA 4.0) and is not redistributed
here.
