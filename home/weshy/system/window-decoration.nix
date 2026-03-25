{ config, lib, ... }:

{
  qt.kde.settings = {
    kwinrc = {
      "org.kde.kdecoration2" = {
        NoPlugin = false;
        library = "org.kde.breeze";
        theme = "Breeze";
        ButtonsOnRight = "IAX";
      };
    };

    kglobalshortcutsrc = {
      krunner = {
        _launch = "Alt+Space,Alt+Space,Activate KRunner";
      };
    };
  };

  # Apply macOS button layout on activation
  home.activation.applyColorButtons = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v kwriteconfig6 >/dev/null 2>&1; then
      # Set button positions: all on right
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "IAX"
      
      # Use Breeze decoration
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library "org.kde.breeze"
      kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme "Breeze"
      
      # Reload KWin
      qdbus org.kde.KWin /KWin org.kde.KWin.reloadConfig 2>/dev/null || true
    fi
  '';
}
