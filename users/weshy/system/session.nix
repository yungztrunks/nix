{ lib, osConfig, ... }:

let
  hyprlandEnabled = osConfig.programs.hyprland.enable or false;
  niriEnabled = osConfig.programs.niri.enable or false;
  kdeEnabled = osConfig.services.desktopManager.plasma6.enable or false;

  activeDesktopCount = builtins.length (builtins.filter (enabled: enabled) [
    hyprlandEnabled
    niriEnabled
    # kdeEnabled
  ]);
in
{
  imports = [
    ./desktops/00default.nix
  ];

  assertions = [
    {
      assertion = activeDesktopCount <= 1;
      message = "At most one desktop stack should be active per generation (hyprland, niri, kde).";
    }
  ];
}
