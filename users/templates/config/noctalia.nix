{ lib, osConfig, ... }:

let
  useNoctalia =
    (osConfig.programs.hyprland.enable or false) || (osConfig.programs.niri.enable or false);
in
lib.mkIf useNoctalia {
  programs.noctalia-shell = {
    enable = true;
  };
}
