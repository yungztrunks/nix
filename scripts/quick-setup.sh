#!/usr/bin/env bash

set -euo pipefail

HOST_NAME="${1:-}"
USER_NAME="${2:-}"

if [[ -z "${HOST_NAME}" || -z "${USER_NAME}" ]]; then
  echo "Usage: $0 <host-name> <user-name>"
  echo "Example: $0 thinkpad alice"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash "${ROOT_DIR}/scripts/generate-host.sh" "${HOST_NAME}"
bash "${ROOT_DIR}/scripts/generate-user.sh" "${USER_NAME}"

echo
echo "Optional next step:"
echo "  just generate-hardware ${HOST_NAME}"
