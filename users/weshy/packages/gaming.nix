{ pkgs, ... }:

{
  home.packages = with pkgs; [
    heroic
    goverlay
    protonup-qt
    lutris
  ];
}
