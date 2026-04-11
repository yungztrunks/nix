#!/usr/bin/env bash

set -euo pipefail

detect_type() {
  if systemd-detect-virt --quiet; then
    echo "vm"
    return
  fi

  if [[ -d /sys/class/power_supply/BAT0 || -d /sys/class/power_supply/BAT1 ]]; then
    echo "laptop"
    return
  fi

  echo "desktop"
}

TYPE="$(detect_type)"

echo "HARDWARE_TYPE=${TYPE}"
echo "CPU=$(lscpu | awk -F: '/Model name/ {gsub(/^ +/, "", $2); print $2; exit}')"
echo "MEMORY_GB=$(awk '/MemTotal/ {printf "%.0f", $2/1024/1024}' /proc/meminfo)"
