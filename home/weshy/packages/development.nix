{ config, lib, pkgs, ... }:

let
  cfg = config.my.home.development;
in
{
  options.my.home.development.enable = lib.mkEnableOption "development tools";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
    };

    home.packages = with pkgs; [
      gh
      github-desktop
      fnm
      bun
      uv
    ];
  };
}
