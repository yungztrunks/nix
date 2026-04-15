#!/usr/bin/env bash

set -euo pipefail

prompt_days() {
  local value
  while true; do
    read -rp "How many days of generations to keep? [30] (0 = collect all): " value
    value="${value:-30}"

    if [[ "${value}" =~ ^[0-9]+$ ]]; then
      echo "${value}"
      return 0
    fi

    echo "Invalid input. Please enter a non-negative integer."
  done
}

prompt_scope() {
  local value
  while true; do
    read -rp "Scope [both/system/user] (default: both): " value
    value="${value,,}"
    value="${value:-both}"

    case "${value}" in
      both|system|user)
        echo "${value}"
        return 0
        ;;
      *)
        echo "Invalid scope. Choose: both, system, or user."
        ;;
    esac
  done
}

prompt_yes_no() {
  local prompt_text="${1}"
  local default="${2:-n}"
  local value
  while true; do
    if [[ "${default}" == "y" ]]; then
      read -rp "${prompt_text} [Y/n]: " value
      value="${value:-y}"
    else
      read -rp "${prompt_text} [y/N]: " value
      value="${value:-n}"
    fi

    value="${value,,}"
    case "${value}" in
      y|yes)
        echo "y"
        return 0
        ;;
      n|no)
        echo "n"
        return 0
        ;;
      *)
        echo "Invalid choice. Please answer y or n."
        ;;
    esac
  done
}

run_gc() {
  local scope="${1}"
  shift

  case "${scope}" in
    user)
      nix-collect-garbage "$@"
      ;;
    system)
      sudo nix-collect-garbage "$@"
      ;;
    both)
      nix-collect-garbage "$@"
      sudo nix-collect-garbage "$@"
      ;;
  esac
}

run_optimise() {
  local scope="${1}"

  case "${scope}" in
    user)
      nix store optimise
      ;;
    system)
      sudo nix store optimise
      ;;
    both)
      nix store optimise
      sudo nix store optimise
      ;;
  esac
}

main() {
  local days scope optimise
  local -a gc_args

  days="$(prompt_days)"

  if [[ "${days}" == "0" ]]; then
    if [[ "$(prompt_yes_no 'This will collect all old generations. Continue?' 'n')" != "y" ]]; then
      echo "Cancelled."
      exit 0
    fi
    gc_args=(-d)
  else
    gc_args=(--delete-older-than "${days}d")
  fi

  scope="$(prompt_scope)"
  optimise="$(prompt_yes_no 'Run store optimisation afterwards?' 'n')"

  run_gc "${scope}" "${gc_args[@]}"

  if [[ "${optimise}" == "y" ]]; then
    run_optimise "${scope}"
  fi

  echo "Garbage collection complete."
}

main "$@"
