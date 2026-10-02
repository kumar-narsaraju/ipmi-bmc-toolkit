#!/usr/bin/env bash
# Quick BMC health report: identity, power, sensors that are not OK, last events.
DIR="$(cd "$(dirname "$0")" && pwd)"; . "$DIR/_lib.sh"
hr() { printf '\n==== %s ====\n' "$1"; }
echo "BMC health check: $TARGET   $(date '+%F %T')"
if [ -n "${BMC_HOST:-}" ]; then
  hr "Network reachability"; ping -c 2 -W 2 "$BMC_HOST" >/dev/null 2>&1 && echo "Ping OK" || echo "Ping FAILED (ICMP may be blocked, continuing)"
fi
hr "BMC info";        ipmi mc info || { echo "Cannot talk to the BMC. See Troubleshooting in README."; exit 1; }
hr "Chassis status";  ipmi chassis status
hr "Sensors not OK";  ipmi sdr elist | awk -F'|' '{s=$3; gsub(/ /,"",s)} s!="ok" && s!="ns" && s!=""' || true
hr "Temperatures";    ipmi sdr type Temperature
hr "Fans";            ipmi sdr type Fan
hr "Last 10 events";  ipmi sel elist | tail -n 10
