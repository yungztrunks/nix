{ lib, osConfig, ... }:

lib.mkIf (osConfig.programs.hyprland.enable or false) {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "noctalia-shell"
      ];

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$ipc" = "noctalia-shell ipc call";

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, D, exec, $ipc launcher command"
      ];
    };
  };
}
