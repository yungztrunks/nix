set shell := ["bash", "-cu"]

default:
    @just --list

switch host=`hostname`:
    sudo nixos-rebuild switch --flake .#{{host}}

test host=`hostname`:
    sudo nixos-rebuild test --flake .#{{host}}

boot host=`hostname`:
    sudo nixos-rebuild boot --flake .#{{host}}

build host=`hostname`:
    sudo nixos-rebuild build --flake .#{{host}}

rebuild action="switch" host=`hostname`:
    bash scripts/rebuild.sh {{action}} {{host}}

update:
    nix flake update

flake-check:
    nix flake check --no-build --accept-flake-config

fmt:
    nix fmt .

lint:
    nix run nixpkgs#statix -- check .

dead-code-check:
    nix run nixpkgs#deadnix -- --fail .

quality:
    just flake-check
    just lint
    just dead-code-check

hook-setup:
    pre-commit install

hook-run:
    pre-commit run --all-files

hook-update:
    pre-commit autoupdate

generate-host host system="x86_64-linux":
    bash scripts/generate-host.sh {{host}} {{system}}

generate-user user:
    bash scripts/generate-user.sh {{user}}

generate-hardware host:
    bash scripts/generate-hardware.sh {{host}}

build-iso host:
    bash scripts/build-iso.sh {{host}}

check-prerequisites:
    bash scripts/check-prerequisites.sh

detect-hardware:
    bash scripts/detect-hardware.sh

validate-templates:
    bash scripts/validate-templates.sh

quick-setup host user:
    bash scripts/quick-setup.sh {{host}} {{user}}

setup-wizard:
    bash scripts/nixos-setup.sh
