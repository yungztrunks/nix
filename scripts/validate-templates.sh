#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "hosts/templates/default.nix"
  "hosts/templates/hardware.nix"
  "hosts/templates/gpu.nix"
  "users/templates/default.nix"
  "users/templates/system/default.nix"
  "users/templates/system/desktop.nix"
  "users/templates/config/default.nix"
  "users/templates/config/cursor.nix"
  "users/templates/config/git.nix"
  "users/templates/config/kitty.nix"
  "users/templates/config/neovim.nix"
  "users/templates/config/noctalia.nix"
  "users/templates/packages/default.nix"
  "users/templates/packages/cli.nix"
  "users/templates/packages/apps.nix"
  "users/templates/packages/development.nix"
  "users/templates/packages/gaming.nix"
  "users/templates/packages/windows-apps.nix"
)

failed=0

for path in "${required_files[@]}"; do
  if [[ ! -f "${ROOT_DIR}/${path}" ]]; then
    echo "Missing template file: ${path}"
    failed=1
  fi
done

if [[ ${failed} -ne 0 ]]; then
  echo "Template validation failed."
  exit 1
fi

for path in "${required_files[@]}"; do
  nix-instantiate --parse "${ROOT_DIR}/${path}" >/dev/null
done

echo "Template validation passed."
