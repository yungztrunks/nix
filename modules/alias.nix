{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.shellAliases;
in
{
  options.my.modules.shellAliases.enable = lib.mkEnableOption "shell aliases for common commands";

  config = lib.mkIf cfg.enable {
    environment.shellAliases = {
      # nix alias
      "nixbuild" = "sudo nixos-rebuild switch --flake /etc/nixos#weshy";
      "nixtest" = "sudo nixos-rebuild test --flake /etc/nixos#weshy";
      "nixboot" = "sudo nixos-rebuild boot --flake /etc/nixos#weshy";
      "nixdry" = "sudo nixos-rebuild dry-activate --flake /etc/nixos#weshy";
      
      # flake alias
      "flakebuild" = "nix build .#";
      "flakeshow" = "nix flake show";
      "flakeupdate" = "nix flake update";
      "flakecheck" = "nix flake check";
      
      # ls
      "ll" = "ls -alh";
      "la" = "ls -A";
      "l" = "ls -CF";
      "ls" = "ls --color=auto";
      
      # grep
      "grep" = "grep --color=auto";
      "..=" = "cd ..";
      "...=" = "cd ../..";
    };
  };
}
