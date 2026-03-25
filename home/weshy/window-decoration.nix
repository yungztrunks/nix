{ config, lib, ... }:

{
  qt.kde.settings = {
    kwinrc = {
      "org.kde.kdecoration2" = {
        NoPlugin = false;
        library = "org.kde.breeze";
        theme = "Breeze";
        # macOS style: left=minimize (green), right=maximize & close (yellow & red)
        ButtonsOnRight = "IAX";
      };
    };

    kglobalshortcutsrc = {
      krunner = {
        _launch = "Alt+Space,Alt+Space,Activate KRunner";
      };
    };
  };

  home.file = {
    ".local/bin/apply-macos-buttons" = {
      source = ./dotfiles/bin/apply-macos-buttons;
      executable = true;
    };
  };

  # Apply button configuration and colors on activation
  home.activation.kdeDecorationReload = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v kwriteconfig6 >/dev/null 2>&1; then
      # Set macOS button positions: minimize on left, maximize & close on right
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "IAX"
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library "org.kde.breeze"
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme "Breeze"
      
      # Set button colors in kdeglobals
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key ForegroundNegative "255,95,86"
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key ForegroundNeutral "255,189,46"
      kwriteconfig6 --file kdeglobals --group "Colors:Button" --key ForegroundPositive "39,201,142"
      
      # Reload KWin to apply changes
      qdbus org.kde.KWin /KWin org.kde.KWin.reloadConfig 2>/dev/null || true
    fi
  '';
}
