{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    microsoft-edge # Primary browser (unfree)
    # Firefox is enabled via programs.firefox in configuration.nix
  ];
}
