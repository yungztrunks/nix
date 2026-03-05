{ config, pkgs, ... }:

{
  # Steam with Proton for Windows games
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    # Enable Proton-GE and other compatibility tools
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  # GameMode for performance optimisation during gaming sessions
  programs.gamemode.enable = true;

  # Extra gaming packages available system-wide
  environment.systemPackages = with pkgs; [
    heroic       # Epic Games Launcher (Rocket League, etc.)
    lutris       # General Windows game runner
    mangohud     # In-game performance overlay
  ];
}
