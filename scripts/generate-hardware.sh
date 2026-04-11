#!/usr/bin/env bash

set -euo pipefail

HOST_NAME="${1:-}"

if [[ -z "${HOST_NAME}" ]]; then
  echo "Usage: $0 <host-name>"
  echo "Example: $0 aspire"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="${ROOT_DIR}/hosts/${HOST_NAME}"
TARGET_FILE="${TARGET_DIR}/hardware.nix"

if [[ ! -d "${TARGET_DIR}" ]]; then
  echo "Host directory does not exist: ${TARGET_DIR}"
  echo "Create it first with: just generate-host ${HOST_NAME}"
  exit 1
fi

if [[ -f "${TARGET_FILE}" ]]; then
  BACKUP_FILE="${TARGET_FILE}.bak.$(date +%Y%m%d%H%M%S)"
  cp "${TARGET_FILE}" "${BACKUP_FILE}"
  echo "Backed up existing hardware file to: ${BACKUP_FILE}"
fi

sudo nixos-generate-config --show-hardware-config > "${TARGET_FILE}"
echo "Generated hardware file: hosts/${HOST_NAME}/hardware.nix"
