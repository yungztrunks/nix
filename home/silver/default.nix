{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ./apps/browsers.nix
    ./apps/apps.nix
    ./apps/development.nix
    ./desktop/hyprland/default.nix
    ./shell/default.nix
  ];
}
