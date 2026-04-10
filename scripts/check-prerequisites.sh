#!/usr/bin/env bash

set -euo pipefail

required_commands=(
  nix
  git
  nixos-rebuild
  nixos-generate-config
)

missing=0

if [[ ! -f /etc/NIXOS ]]; then
  echo "Not running on NixOS."
  exit 1
fi

for cmd in "${required_commands[@]}"; do
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "Missing command: ${cmd}"
    missing=1
  fi
done

if [[ ${missing} -ne 0 ]]; then
  echo "Prerequisite check failed."
  exit 1
fi

echo "Prerequisite check passed."
