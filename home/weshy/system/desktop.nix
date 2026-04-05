{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,macOS"
      ];

      monitor = ",preferred,auto,1.0";

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "0xff6e5194";
        "col.inactive_border" = "0xff3e3e3e";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      input = {
        kb_layout = "de";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          natural_scroll = false;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      exec-once = [
        "noctalia-shell"
      ];

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$ipc" = "noctalia-shell ipc call";

      bind = [
        "$mod, T, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, L, exit,"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"

        # Workspace keybinds
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Zoom
        # "binde = $mod, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
        # "binde = $mod, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
      ];

      bindel = [
        # Volume controls
        ", XF86AudioRaiseVolume, exec, $ipc volume increase"
        ", XF86AudioLowerVolume, exec, $ipc volume decrease"
        # Brightness controls
        ", XF86MonBrightnessUp, exec, $ipc brightness increase"
        ", XF86MonBrightnessDown, exec, $ipc brightness decrease"
        # Media controls
        ", XF86AudioPlay, exec, $ipc media playPause"
        ", XF86AudioNext, exec, $ipc media next"
        ", XF86AudioPrev, exec, $ipc media previous"
      ];

      # bindl = [
      #   # Mute controls (no repeat)
      #   ", XF86AudioMute, exec, $ipc volume muteOutput"
      #   ", XF86AudioMicMute, exec, $ipc volume muteInput"
      # ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

    };
  };

  # GTK settings
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "macOS Light";
      package = null;
    };
    font = {
      name = "JetBrains Mono";
      size = 11;
    };
  };

  # Qt settings
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
