{ pkgs, ... }:

{
  programs.kitty.enable = true;
  programs.firefox.enable = false;
  programs.obs-studio.enable = true;

  home.packages = with pkgs; [
    spotify
    vlc
    discord
    qbittorrent
  ];
}
