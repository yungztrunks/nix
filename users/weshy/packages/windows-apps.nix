{ config, lib, pkgs, ... }:

let
  cfg = config.my.home.windowsApps;
in
{
  options.my.home.windowsApps.enable = lib.mkEnableOption "windows app compatibility tools";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bottles
    ];
  };
}
