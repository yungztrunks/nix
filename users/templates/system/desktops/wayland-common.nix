{ lib, osConfig, ... }:

let
  isWaylandDesktop =
    (osConfig.programs.hyprland.enable or false)
    || (osConfig.programs.niri.enable or false);
in
lib.mkIf isWaylandDesktop {
  # Shared Wayland settings for Hyprland/Niri.
}
