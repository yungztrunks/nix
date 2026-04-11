{ config, lib, pkgs, ... }:

let
  cfg = config.my.home.apps;
in
{
  options.my.home.apps.enable = lib.mkEnableOption "daily-use applications";

  config = lib.mkIf cfg.enable {
    programs.kitty.enable = true;
    programs.firefox.enable = true;
    programs.obs-studio.enable = true;

    home.packages = with pkgs; [
      spotify
      vlc
      discord
      puddletag
      qbittorrent
    ];
  };
}
