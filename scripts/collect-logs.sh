#!/usr/bin/env bash
# Collect BMC data into a timestamped folder + .tar.gz (handy for vendor support / RCA).
DIR="$(cd "$(dirname "$0")" && pwd)"; . "$DIR/_lib.sh"
OUT="bmc-report-${TARGET}-$(date +%Y%m%d-%H%M%S)"; mkdir -p "$OUT"
run() { name="$1"; shift; echo "collecting $name ..."; ipmi "$@" > "$OUT/$name.txt" 2>&1 || echo "  (failed: $name)"; }
run mc_info mc info
run chassis_status chassis status
run fru fru print
run sensors sensor list
run sdr_elist sdr elist
run sel_info sel info
run sel_events sel elist
run lan_ch1 lan print 1
run users_ch1 user list 1
tar -czf "$OUT.tar.gz" "$OUT" && echo "Done: $OUT.tar.gz"
