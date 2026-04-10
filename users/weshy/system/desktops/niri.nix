{ lib, osConfig, ... }:

lib.mkIf (osConfig.programs.niri.enable or false) {
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.file.".config/niri/config.kdl".text = ''
    spawn-at-startup "noctalia-shell"

    binds {
      Mod+Return { spawn "kitty"; }
      Mod+D { spawn "noctalia-shell" "ipc" "call" "launcher" "command"; }
    }
  '';
}
