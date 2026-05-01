set shell := ["bash", "-cu"]

default:
    @just --list

# Rebuild and switch to the active generation for a host.
switch host=`hostname`:
    sudo nixos-rebuild switch --flake .#{{host}}

# Rebuild in test mode for a host.
test host=`hostname`:
    sudo nixos-rebuild test --flake .#{{host}}

# Build and register as next boot generation for a host.
boot host=`hostname`:
    sudo nixos-rebuild boot --flake .#{{host}}

# Build the system configuration without switching.
build host=`hostname`:
    sudo nixos-rebuild build --flake .#{{host}}

# Wrapper around scripts/rebuild.sh with action + host arguments.
rebuild action="switch" host=`hostname`:
    bash scripts/rebuild.sh {{action}} {{host}}

# Update flake inputs and lock file.
update:
    nix flake update

# Evaluate flake checks without building derivations.
flake-check:
    nix flake check --no-build --accept-flake-config

# Format Nix files.
fmt:
    nix fmt .

# Run statix lints.
lint:
    nix run nixpkgs#statix -- check .

# Detect dead Nix code.
dead-code-check:
    nix run nixpkgs#deadnix -- --fail .

# Run all quality checks.
quality:
    just flake-check
    just lint
    just dead-code-check

# Install pre-commit hooks.
hook-setup:
    pre-commit install

# Run pre-commit on all files.
hook-run:
    pre-commit run --all-files

# Update pre-commit hook versions.
hook-update:
    pre-commit autoupdate

# Scaffold a new host directory from templates.
generate-host host system="x86_64-linux":
    bash scripts/generate-host.sh {{host}} {{system}}

# Scaffold a new user directory from templates.
generate-user user:
    bash scripts/generate-user.sh {{user}}

# Generate host hardware.nix from current machine.
generate-hardware host:
    bash scripts/generate-hardware.sh {{host}}

# Build an install ISO from a flake host output.
build-iso host:
    bash scripts/build-iso.sh {{host}}

# Verify required commands and base prerequisites.
check-prerequisites:
    bash scripts/check-prerequisites.sh

# SOPS: generate age key
sops-keygen:
    mkdir -p ~/.config/sops/age
    nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt

# SOPS: show public key
sops-pubkey:
    nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt

# SOPS: edit secrets file
sops-edit:
    nix shell nixpkgs#sops -c sops secrets/secrets.yaml

# SOPS: re-encrypt with updated keys
sops-updatekeys:
    nix shell nixpkgs#sops -c sops updatekeys secrets/secrets.yaml

# Detect hardware profile summary.
detect-hardware:
    bash scripts/detect-hardware.sh

# Validate template files exist and parse correctly.
validate-templates:
    bash scripts/validate-templates.sh

# Run host + user scaffold quick setup.
quick-setup host user:
    bash scripts/quick-setup.sh {{host}} {{user}}

# Interactive setup wizard.
setup-wizard:
    bash scripts/nixos-setup.sh

# Interactive nix garbage collection helper.
garbagecollect:
    bash scripts/garbagecollect.sh
