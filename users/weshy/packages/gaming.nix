{ config, lib, pkgs, ... }:

let
  cfg = config.my.home.gaming;
in
{
  options.my.home.gaming.enable = lib.mkEnableOption "gaming tools and launchers";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      heroic
      goverlay
      protonup-qt
      lutris
    ];
  };
}
