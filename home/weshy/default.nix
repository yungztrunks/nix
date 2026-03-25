{ config, pkgs, lib, ... }:

{
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    kitty
  ];

  qt.enable = true;
  qt.platformTheme.name = "kde";

  qt.kde.settings = {
    kdeglobals = {
      General = {
        ColorScheme = "MacOSLighter";
        AccentColor = "110,81,145";
        TerminalApplication = "kitty";
        TerminalService = "kitty.desktop";
      };
      Icons = {
        Theme = "macOS Light";
      };
      KDE = {
        widgetStyle = "Breeze";
      };
      "Colors:Button" = {
        DecorationFocus = "110,81,145";
        DecorationHover = "110,81,145";
      };
      "Colors:View" = {
        DecorationFocus = "110,81,145";
        DecorationHover = "110,81,145";
      };
      "Colors:Window" = {
        DecorationFocus = "110,81,145";
        DecorationHover = "110,81,145";
      };
      WM = {
        activeBackground = "245,245,247";
        activeForeground = "36,36,36";
        activeBlend = "245,245,247";
        inactiveBackground = "236,236,239";
        inactiveForeground = "90,90,95";
        inactiveBlend = "236,236,239";
      };
    };

    kcminputrc = {
      Mouse = {
        cursorTheme = "macOS";
      };
    };

    kwinrc = {
      "org.kde.kdecoration2" = {
        NoPlugin = false;
        library = "org.kde.breeze";
        theme = "Breeze";
        ButtonsOnLeft = "";
        ButtonsOnRight = "IAX";
      };
    };

    kglobalshortcutsrc = {
      krunner = {
        _launch = "Alt+Space,Alt+Space,Activate KRunner";
      };
    };

    plasmarc = {
      Theme = {
        name = "macOS Light";
      };
    };
  };

  home.file = {
    ".local/share/icons/macOS".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/Cursors/macOS";
    ".local/share/icons/macOS Light".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/Icons/macOS-Light";
    ".local/share/icons/hicolor/scalable/apps/glutmother.svg".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/AppIcons/glutmother.svg";

    ".local/share/color-schemes/MacOSLighter.colors".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/ColorSchemes/MacOSLighter.colors";
    ".local/share/plasma/desktoptheme/macOS Light".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/assets/plasma-tahoe/PlasmaStyles/macOS-Light";

    ".icons/default/index.theme".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home/weshy/dotfiles/icons-default/index.theme";

    ".local/bin/plasma-tahoe-layout" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home/weshy/dotfiles/bin/plasma-tahoe-layout";
      executable = true;
    };

    ".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home/weshy/dotfiles/kitty/kitty.conf";
    ".config/autostart/plasma-tahoe-layout.desktop".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home/weshy/dotfiles/autostart/plasma-tahoe-layout.desktop";
  };

  home.activation.kdeDecorationReload = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v kwriteconfig6 >/dev/null 2>&1; then
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft ""
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "IAX"
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library "org.kde.breeze"
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme "Breeze"
    fi
  '';
}
