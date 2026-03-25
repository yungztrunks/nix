{ config, ... }:

{
  home.file = {
    ".local/share/icons/macOS".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/Cursors/macOS";
    ".local/share/icons/macOS Light".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/Icons/macOS-Light";
    ".local/share/icons/hicolor/scalable/apps/glutmother.svg".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/AppIcons/glutmother.svg";

    ".local/share/color-schemes/MacOSLighter.colors".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/ColorSchemes/MacOSLighter.colors";
    ".local/share/plasma/desktoptheme/macOS Light".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/PlasmaStyles/macOS-Light";

    ".icons/default/index.theme".source = ./dotfiles/icons-default/index.theme;
  };
}
