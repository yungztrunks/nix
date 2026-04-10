#!/usr/bin/env bash

set -euo pipefail

USER_NAME="${1:-}"
DEFAULT_DE_INPUT="${2:-}"

if [[ -z "${USER_NAME}" ]]; then
  echo "Usage: $0 <user-name> [hyprland|niri|kde]"
  echo "Example: $0 alice hyprland"
  exit 1
fi

normalize_de() {
  local raw="${1:-}"
  local lowered="${raw,,}"

  case "${lowered}" in
    hyprland|niri|kde)
      echo "${lowered}"
      ;;
    *)
      return 1
      ;;
  esac
}

DEFAULT_DE=""

if [[ -n "${DEFAULT_DE_INPUT}" ]]; then
  if ! DEFAULT_DE="$(normalize_de "${DEFAULT_DE_INPUT}")"; then
    echo "Invalid desktop '${DEFAULT_DE_INPUT}'. Expected one of: hyprland, niri, kde"
    exit 1
  fi
fi

if [[ -z "${DEFAULT_DE}" ]]; then
  if [[ -t 0 ]]; then
    echo "Choose default desktop for this user scaffold:"
    PS3="Desktop [1-3]: "
    select de in hyprland niri kde; do
      if [[ -n "${de:-}" ]]; then
        DEFAULT_DE="${de}"
        break
      fi
      echo "Please choose 1, 2, or 3."
    done
  else
    DEFAULT_DE="hyprland"
    echo "No terminal prompt available, defaulting desktop scaffold to: ${DEFAULT_DE}"
  fi
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

DESKTOP_IMPORTS_FILE="${TARGET_DIR}/system/desktops/00default.nix"

if [[ -f "${DESKTOP_IMPORTS_FILE}" ]]; then
  case "${DEFAULT_DE}" in
    hyprland)
      first="./hyprland.nix"
      second="./niri.nix"
      third="./kde.nix"
      ;;
    niri)
      first="./niri.nix"
      second="./hyprland.nix"
      third="./kde.nix"
      ;;
    kde)
      first="./kde.nix"
      second="./hyprland.nix"
      third="./niri.nix"
      ;;
  esac

  cat > "${DESKTOP_IMPORTS_FILE}" <<EOF
{ ... }:

{
  imports = [
    ${first}
    ${second}
    ${third}
    ./wayland-common.nix
  ];
}
EOF
fi

echo "Created user scaffold: users/${USER_NAME}"
echo "Scaffold includes: config/, packages/, system/, default.nix"
echo "Desktop scaffold preference: ${DEFAULT_DE}"
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
echo
echo "3) Set host default desktop for this user flow (optional):"
echo "   my.modules.desktopSpecialisations.baseDesktop = \"${DEFAULT_DE}\";"
