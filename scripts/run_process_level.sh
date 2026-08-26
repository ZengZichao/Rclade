#!/bin/bash
# Process-level wall-clock / peak RSS / CPU measurements (unified protocol,
# 2026-08 revision). Complements the in-session bench::mark medians: this
# series includes R startup + package loading, and provides peak RSS via
# /usr/bin/time -l (macOS reports bytes; converted to MB below).
set -u
# Portable interpreter resolution (v1.1.0, reviewer issue 6): use Rscript
# from PATH by default; override with RSCRIPT=/path/to/Rscript if a
# specific environment is required.
R45="${RSCRIPT:-Rscript}"
command -v "$R45" >/dev/null 2>&1 || { echo "error: '$R45' not found; set RSCRIPT to a valid Rscript path" >&2; exit 2; }
OUT=benchmark_results/process_level_metrics.csv
REPS="${REPS:-5}"   # v1.1.0 (reviewer issue 3): >=5 independent process runs per config
echo "config,rep,wall_s,max_rss_mb,cpu_pct" > "$OUT"

measure() {
  local cfg="$1" rep="$2"; shift 2
  local tmp; tmp="$(/usr/bin/time -l "$@" 2>&1 >/dev/null)"
  local wall rss cpu
  wall=$(echo "$tmp" | awk '/ real / {print $1; exit}')
  rss=$(echo "$tmp"  | awk '/maximum resident set size/ {printf "%.0f", $1/1048576}')
  cpu=$(echo "$tmp"  | awk '/percent of CPU/ {print $1; exit}')
  echo "$cfg,$rep,$wall,$rss,$cpu" >> "$OUT"
  echo "$cfg rep=$rep wall=${wall}s rss=${rss}MB cpu=${cpu}%"
}

for n in 200 1000 5000 10000; do
  for rep in $(seq 1 "$REPS"); do
    measure "synthetic_n${n}_rclade" "$rep" "$R45" scripts/benchmark_synthetic_once.R "$n" rclade
    measure "synthetic_n${n}_ggtree" "$rep" "$R45" scripts/benchmark_synthetic_once.R "$n" ggtree
  done
done

echo "done -> $OUT (${REPS} replicates per configuration; medians computed downstream)"
