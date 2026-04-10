#!/usr/bin/env bash

set -euo pipefail

HOST_NAME="${1:-}"
SYSTEM="${2:-x86_64-linux}"

if [[ -z "${HOST_NAME}" ]]; then
  echo "Usage: $0 <host-name> [system]"
  echo "Example: $0 thinkpad x86_64-linux"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_DIR="${ROOT_DIR}/hosts/templates"
TARGET_DIR="${ROOT_DIR}/hosts/${HOST_NAME}"

if [[ -d "${TARGET_DIR}" ]]; then
  echo "Host directory already exists: ${TARGET_DIR}"
  exit 1
fi

mkdir -p "${TARGET_DIR}"
cp "${TEMPLATE_DIR}/default.nix" "${TARGET_DIR}/default.nix"
cp "${TEMPLATE_DIR}/hardware.nix" "${TARGET_DIR}/hardware.nix"
cp "${TEMPLATE_DIR}/gpu.nix" "${TARGET_DIR}/gpu.nix"

echo "Created host scaffold: hosts/${HOST_NAME}"
echo
echo "Next steps (manual wiring):"
echo "1) Generate real hardware file:"
echo "   just generate-hardware ${HOST_NAME}"
echo
echo "2) Add host to flake hosts map in flake.nix:"
echo "   ${HOST_NAME} = {"
echo "     system = \"${SYSTEM}\";"
echo "     userRefs = [ \"weshy\" ];"
echo "   };"
echo
echo "3) Build/test it:"
echo "   just test ${HOST_NAME}"
