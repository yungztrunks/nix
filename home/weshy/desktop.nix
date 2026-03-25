{ config, lib, ... }:

{
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

    plasmarc = {
      Theme = {
        name = "macOS Light";
      };
    };
  };
}
