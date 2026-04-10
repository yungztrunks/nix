{ lib, osConfig, ... }:

lib.mkIf (osConfig.programs.niri.enable or false) {
  # Add Niri-specific Home Manager settings here.
}
