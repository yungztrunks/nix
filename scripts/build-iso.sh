#!/usr/bin/env bash

set -euo pipefail

HOST_NAME="${1:-}"

if [[ -z "${HOST_NAME}" ]]; then
  echo "Usage: $0 <host-name>"
  echo "Example: $0 aspire"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="${ROOT_DIR}/result/iso-${HOST_NAME}"

mkdir -p "${OUTPUT_DIR}"

echo "Building ISO for host: ${HOST_NAME}"
echo "Output directory: ${OUTPUT_DIR}"

cd "${ROOT_DIR}"
nix run github:nix-community/nixos-generators -- \
  --format iso \
  --flake ".#${HOST_NAME}" \
  -o "${OUTPUT_DIR}"

echo "ISO build complete for host: ${HOST_NAME}"
