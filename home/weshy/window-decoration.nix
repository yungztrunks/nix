{ config, lib, ... }:

{
  qt.kde.settings = {
    kwinrc = {
      "org.kde.kdecoration2" = {
        NoPlugin = false;
        library = "org.kde.breeze";
        theme = "Breeze";
        # macOS style: all buttons on right - M=minimize (green), A=maximize (yellow), X=close (red)
        ButtonsOnLeft = "";
        ButtonsOnRight = "MAX";
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
  };

  # Apply macOS button colors on activation
  home.activation.applyMacOSButtons = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v kwriteconfig6 >/dev/null 2>&1; then
      # Set button positions: all on right - M (minimize), A (maximize), X (close)
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft ""
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "MAX"
      
      # Apply button colors
      # Red (255,95,86) for Close button
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key ForegroundNegative "255,95,86"
      # Yellow (255,189,46) for Maximize button
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key ForegroundNeutral "255,189,46"
      # Green (39,201,142) for Minimize button
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key ForegroundPositive "39,201,142"
      
      # Force breeze library
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library "org.kde.breeze"
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme "Breeze"
      
      # Reload KWin
      qdbus org.kde.KWin /KWin org.kde.KWin.reloadConfig 2>/dev/null || true
    fi
  '';
  '';
}
