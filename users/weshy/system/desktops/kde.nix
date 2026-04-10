{ lib, osConfig, ... }:

lib.mkIf (osConfig.services.desktopManager.plasma6.enable or false) {
  qt = {
    enable = true;
    platformTheme.name = "kde";
  };
}
