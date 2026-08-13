#!/bin/bash
# Process-level wall-clock / peak RSS / CPU measurements (unified protocol,
# 2026-08 revision). Complements the in-session bench::mark medians: this
# series includes R startup + package loading, and provides peak RSS via
# /usr/bin/time -l (macOS reports bytes; converted to MB below).
set -u
R45=/Users/zengzichao/.local/share/mamba/envs/r-4.5.3/bin/Rscript
OUT=benchmark_results/process_level_metrics.csv
echo "config,wall_s,max_rss_mb,cpu_pct" > "$OUT"

measure() {
  local cfg="$1"; shift
  local tmp; tmp="$(/usr/bin/time -l "$@" 2>&1 >/dev/null)"
  local wall rss cpu
  wall=$(echo "$tmp" | awk '/ real / {print $1; exit}')
  rss=$(echo "$tmp"  | awk '/maximum resident set size/ {printf "%.0f", $1/1048576}')
  cpu=$(echo "$tmp"  | awk '/percent of CPU/ {print $1; exit}')
  echo "$cfg,$wall,$rss,$cpu" >> "$OUT"
  echo "$cfg wall=${wall}s rss=${rss}MB cpu=${cpu}%"
}

for n in 200 1000 5000 10000; do
  measure "synthetic_n${n}_rclade" "$R45" scripts/benchmark_synthetic_once.R "$n" rclade
  measure "synthetic_n${n}_ggtree" "$R45" scripts/benchmark_synthetic_once.R "$n" ggtree
done

echo "done -> $OUT"
