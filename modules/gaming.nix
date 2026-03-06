{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.gaming;
in
{
  options.my.modules.gaming.enable = lib.mkEnableOption "gaming things, tools and launchers";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      heroic
      mangohud
      goverlay
      protonup-qt
    ];
  };
}