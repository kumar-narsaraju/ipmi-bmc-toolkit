#!/usr/bin/env bash
# Shared helper. Remote:  BMC_HOST=10.0.0.50 BMC_USER=admin IPMI_PASSWORD='secret' ./script.sh
# Local (in-band):  leave BMC_HOST unset and run as root.
command -v ipmitool >/dev/null || { echo "ipmitool not found. Install it first (see README)." >&2; exit 127; }
ipmi() {
  if [ -n "${BMC_HOST:-}" ]; then
    : "${BMC_USER:?Set BMC_USER}" "${IPMI_PASSWORD:?Set IPMI_PASSWORD}"
    ipmitool -I lanplus -H "$BMC_HOST" -U "$BMC_USER" -E "$@"
  else
    ipmitool "$@"
  fi
}
TARGET="${BMC_HOST:-local}"
