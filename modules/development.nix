{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.develop;
in
{
  options.my.modules.develop.enable = lib.mkEnableOption "development tools";

  config = lib.mkIf cfg.enable {

    # programs.vscode.enable = true;

    environment.systemPackages = with pkgs; [
      vscode
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
