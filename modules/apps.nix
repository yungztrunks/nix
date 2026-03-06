{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.normal;
in
{
  options.my.modules.normal.enable = lib.mkEnableOption "normal daily-use apps";

  config = lib.mkIf cfg.enable {
    programs.firefox.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      spotify
      obs-studio
      vlc
    ];
  };
}