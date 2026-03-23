{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.develop;
in
{
  options.my.modules.develop.enable = lib.mkEnableOption "development tools";

  options.vscode.enable = lib.mkEnableOption "vs code";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gh
      github-desktop
      gnumake
      gcc
      python3
      fnm
      bun
      uv
      nil
      nixd
      nixfmt-rfc-style
    ];
  };
}