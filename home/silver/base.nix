{ config, pkgs, ... }:

{
  home.username = "silver";
  home.homeDirectory = "/home/silver";

  home.stateVersion = "25.11";

  programs.git.enable = true;
  programs.bash.enable = true;
}
