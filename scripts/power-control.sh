#!/usr/bin/env bash
# Safe wrapper for chassis power. Usage: ./power-control.sh <status|on|off|soft|cycle|reset> [--yes]
DIR="$(cd "$(dirname "$0")" && pwd)"; . "$DIR/_lib.sh"
A="${1:-status}"
case "$A" in status) ipmi chassis power status; exit;; on|off|soft|cycle|reset) ;; *) echo "Usage: $0 <status|on|off|soft|cycle|reset> [--yes]"; exit 2;; esac
if [ "${2:-}" != "--yes" ]; then
  echo "This will run 'chassis power $A' on: $TARGET"
  read -r -p "Type the target name ($TARGET) to confirm: " C; [ "$C" = "$TARGET" ] || { echo "Cancelled."; exit 1; }
fi
ipmi chassis power "$A" && sleep 3 && ipmi chassis power status
