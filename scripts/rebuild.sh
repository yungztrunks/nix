#!/usr/bin/env bash

set -euo pipefail

ACTION="${1:-switch}"
HOST="${2:-$(hostname)}"

case "${ACTION}" in
  switch|test|boot|build)
    ;;
  *)
    echo "Usage: $0 [switch|test|boot|build] [host]"
    exit 1
    ;;
esac

sudo nixos-rebuild "${ACTION}" --flake ".#${HOST}"
