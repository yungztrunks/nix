{ lib, osConfig, pkgs, ... }:

let
  isWaylandDesktop =
    (osConfig.programs.hyprland.enable or false)
    || (osConfig.programs.niri.enable or false);
in
lib.mkIf isWaylandDesktop {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "macOS Light";
      package = null;
    };
    font = {
      name = "JetBrains Mono";
      size = 11;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
