{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.windowsApps;
in
{
  options.my.modules.windowsApps.enable = lib.mkEnableOption "windows app compatibility tools";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bottles
      winetricks
      wineWowPackages.stable
    ];
  };
}