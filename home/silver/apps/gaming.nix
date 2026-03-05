{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord # Chat & voice for gaming (unfree)
    # Steam and Heroic are managed at system level via modules/gaming.nix
  ];
}
