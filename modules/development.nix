{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.develop;
in
{
  options.my.modules.develop.enable = lib.mkEnableOption "development tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
      git
      gh
      github-desktop
      gnumake
      gcc
      python3
      nvm
      bun
      uv
      nil
      nixd
      nixfmt-rfc-style
    ];
  };
}