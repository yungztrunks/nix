{ lib, osConfig, ... }:

lib.mkIf (osConfig.programs.niri.enable or false) {
  # Niri-specific Home Manager settings.
}
