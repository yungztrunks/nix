#!/usr/bin/env bash

set -euo pipefail

HOST_NAME="${1:-}"
USER_NAME="${2:-}"
DEFAULT_DE="${3:-}"

if [[ -z "${HOST_NAME}" || -z "${USER_NAME}" ]]; then
  echo "Usage: $0 <host-name> <user-name> [hyprland|niri|kde]"
  echo "Example: $0 thinkpad alice hyprland"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash "${ROOT_DIR}/scripts/generate-host.sh" "${HOST_NAME}"
bash "${ROOT_DIR}/scripts/generate-user.sh" "${USER_NAME}" "${DEFAULT_DE}"

echo
echo "Optional next step:"
echo "  just generate-hardware ${HOST_NAME}"
