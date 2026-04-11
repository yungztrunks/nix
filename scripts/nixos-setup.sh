#!/usr/bin/env bash

set -euo pipefail

echo "NixOS setup wizard"
echo

read -r -p "Host name: " HOST_NAME
read -r -p "Primary user name: " USER_NAME

if [[ -z "${HOST_NAME}" || -z "${USER_NAME}" ]]; then
  echo "Host and user are required."
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
bash "${ROOT_DIR}/scripts/quick-setup.sh" "${HOST_NAME}" "${USER_NAME}"
