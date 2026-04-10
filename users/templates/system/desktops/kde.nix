{ lib, osConfig, ... }:

lib.mkIf (osConfig.services.desktopManager.plasma6.enable or false) {
  # KDE Plasma-specific Home Manager settings.
}
