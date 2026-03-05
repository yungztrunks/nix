{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ./apps/browsers.nix
    ./apps/media.nix
    ./apps/development.nix
    ./apps/gaming.nix
    ./desktop/hyprland/default.nix
    ./shell/default.nix
  ];
}
