{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.shellAliases;
in
{
  options.my.modules.shellAliases.enable = lib.mkEnableOption "shell aliases for common commands";

  config = lib.mkIf cfg.enable {
    environment.shellAliases = {
      # nix alias
      "nixbuild" = "sudo nixos-rebuild switch --flake ~/.nixos#$(hostname)";
      "nixtest" = "sudo nixos-rebuild test --flake ~/.nixos#$(hostname)";
      "nixboot" = "sudo nixos-rebuild boot --flake ~/.nixos#$(hostname)";
      "nixdry" = "sudo nixos-rebuild dry-activate --flake ~/.nixos#$(hostname)";
      "hm-remove" = "find \"$HOME\" -name '*.hm-backup' -delete";
      
      # flake alias
      "flakebuild" = "nix build ~/.nixos#";
      "flakeshow" = "nix flake show ~/.nixos";
      "flakeupdate" = "nix flake update --flake ~/.nixos";
      "flakecheck" = "nix flake check ~/.nixos";
      
      # ls
      "ll" = "ls -alh";
      "la" = "ls -A";
      "l" = "ls -CF";
      "ls" = "ls --color=auto";
      
      # grep
      "grep" = "grep --color=auto";

      # random
      "cls" = "clear";
    };
  };
}
