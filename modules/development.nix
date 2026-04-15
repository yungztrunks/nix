{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.develop;
in
{
  options.my.modules.develop.enable = lib.mkEnableOption "system-level development infrastructure";

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      silent = false;
      loadInNixShell = true;
      nix-direnv.enable = true;
    };

    programs.nix-ld.enable = true;
    programs.nix-index-database.comma.enable = true;

    environment.systemPackages = with pkgs; [
      just
      gnumake
      gcc
      python3
      nil
      nixd
      nixfmt-rfc-style
    ];
  };
}
