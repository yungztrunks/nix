{ config, pkgs, ... }:

{
  # Enable Hyprland Wayland compositor
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # XDG portal support for screen sharing, file pickers, etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable Wayland on SDDM display manager
  services.displayManager.sddm.wayland.enable = true;

  # Extra Wayland-related packages available system-wide
  environment.systemPackages = with pkgs; [
    wayland
    wayland-utils
    wlr-randr
  ];
}
