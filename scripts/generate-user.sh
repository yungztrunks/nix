#!/usr/bin/env bash

set -euo pipefail

USER_NAME="${1:-}"

if [[ -z "${USER_NAME}" ]]; then
  echo "Usage: $0 <user-name>"
  echo "Example: $0 alice"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_DIR="${ROOT_DIR}/users/templates"
TARGET_DIR="${ROOT_DIR}/users/${USER_NAME}"

if [[ -d "${TARGET_DIR}" ]]; then
  echo "User directory already exists: ${TARGET_DIR}"
  exit 1
fi

mkdir -p "${TARGET_DIR}"
cp -R "${TEMPLATE_DIR}/." "${TARGET_DIR}/"

echo "Created user scaffold: users/${USER_NAME}"
echo "Scaffold includes: config/, packages/, system/, default.nix"
echo
echo "Next steps (manual wiring):"
echo "1) Add user in global users map in flake.nix:"
echo "   ${USER_NAME} = {"
echo "     fullName = \"${USER_NAME}\";"
echo "     gitName = \"${USER_NAME}\";"
echo "     gitEmail = \"${USER_NAME}@example.com\";"
echo "     homeModule = ./users/${USER_NAME}/default.nix;"
echo "     extraGroups = [ \"networkmanager\" \"wheel\" ];"
echo "   };"
echo
echo "2) Add user to a host userRefs list in flake.nix:"
echo "   userRefs = [ \"weshy\" \"${USER_NAME}\" ];"
