{ lib, osConfig, ... }:

lib.mkIf (osConfig.programs.hyprland.enable or false) {
  # Hyprland-specific Home Manager settings.
}
