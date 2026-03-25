{ config, lib, ... }:

{
  qt.kde.settings = {
    kwinrc = {
      "org.kde.kdecoration2" = {
        NoPlugin = false;
        library = "org.kde.breeze";
        theme = "Breeze";
        # macOS style: all buttons on right - I=minimize (green), A=maximize (yellow), X=close (red)
        ButtonsOnLeft = "";
        ButtonsOnRight = "IAX";
      };
    };

    kdeglobals = {
      "Colors:Button" = {
        # Red for close button (X - ForegroundNegative)
        ForegroundNegative = "255,95,86";
        # Yellow for maximize button (A - ForegroundNeutral)
        ForegroundNeutral = "255,189,46";
        # Green for minimize button (M - ForegroundPositive)
        ForegroundPositive = "39,201,142";
      };
    };

    kglobalshortcutsrc = {
      krunner = {
        _launch = "Alt+Space,Alt+Space,Activate KRunner";
      };
    };
  };

  home.file = {
    ".local/bin/setup-macos-buttons" = {
      source = ./dotfiles/bin/setup-macos-buttons;
      executable = true;
    };
    ".local/bin/apply-color-circles" = {
      source = ./dotfiles/bin/apply-color-circles;
      executable = true;
    };
    ".local/share/kwin/decorations/ColorCircles" = {
      source = ./dotfiles/kwin-decorations/ColorCircles;
      recursive = true;
    };
  };

  # Apply macOS button colors on activation
  home.activation.applyMacOSButtons = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v kwriteconfig6 >/dev/null 2>&1; then
      # Copy color circles decoration to KWin
      mkdir -p "''${HOME}/.local/share/kwin/decorations"
      
      # Set button positions: all on right - I (minimize), A (maximize), X (close)
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft ""
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "IAX"
      
      # Use Breeze library with custom colors
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library "org.kde.breeze"
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme "Breeze"
      
      # Apply button colors to make them appear as colored circles
      # Green (39,201,142) for Minimize button (ForegroundPositive)
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key ForegroundPositive "39,201,142"
      # Yellow (255,189,46) for Maximize button (ForegroundNeutral)
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key ForegroundNeutral "255,189,46"
      # Red (255,95,86) for Close button (ForegroundNegative)
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key ForegroundNegative "255,95,86"
      
      # Also set button backgrounds to solid colors for visual appearance
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key BackgroundNormal "245,245,247"
      
      # Reload KWin to apply changes
      qdbus org.kde.KWin /KWin org.kde.KWin.reloadConfig 2>/dev/null || true
    fi
  '';
}
