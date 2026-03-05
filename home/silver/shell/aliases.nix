{ config, pkgs, ... }:

{
  # home.shellAliases applies to all enabled shells (bash, zsh, fish, …)
  home.shellAliases = {
    # Navigation
    ll    = "ls -lahF --color=auto";
    ".."  = "cd ..";
    "..." = "cd ../..";

    # ── NixOS / Nix commands ──────────────────────────────────────────────────
    # Rebuild and activate the current config
    rebuild-switch = "sudo nixos-rebuild switch --flake ~/.config/nixos#desktop";
    # Update all flake inputs and rebuild
    upgrade  = "sudo nix flake update ~/.config/nixos && sudo nixos-rebuild switch --flake ~/.config/nixos#desktop";
    # Rebuild without switching (test / dry run)
    rebuild-test = "sudo nixos-rebuild test --flake ~/.config/nixos#desktop";
    # Rebuild and boot into the new generation on next reboot
    rebuild-boot = "sudo nixos-rebuild boot --flake ~/.config/nixos#desktop";
    # Build only – don't switch (useful for CI / validation)
    rebuild-build = "sudo nixos-rebuild build --flake ~/.config/nixos#desktop";
    # Collect old generations (older than 5 days)
    nix-clean = "sudo nix-collect-garbage --delete-older-than 5d";
    # List installed generations
    nix-generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    # Open a nix shell with a temporary package
    ns = "nix shell nixpkgs#";
    # Search nixpkgs
    np = "nix search nixpkgs";

    # ── Git shortcuts ─────────────────────────────────────────────────────────
    g  = "git";
    gs = "git status";
    gp = "git push";
    gl = "git pull";
    ga = "git add";
    gc = "git commit";
  };
}
