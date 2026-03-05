{ config, pkgs, ... }:

{
  home.username = "silver";
  home.homeDirectory = "/home/silver";

  home.stateVersion = "25.11";

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
