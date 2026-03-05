{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Wayland status bar
    waybar

    # Application launcher
    rofi-wayland

    # Wallpaper daemon
    hyprpaper

    # Screen locker & idle daemon
    hyprlock
    hypridle

    # Notification daemon
    dunst

    # Terminal emulator
    kitty

    # File manager (KDE Dolphin – fits alongside the existing KDE Plasma install)
    dolphin

    # Screenshot & screen recording
    grim   # Wayland screenshot tool
    slurp  # Interactive region selector
    wf-recorder # Screen recorder

    # Clipboard
    wl-clipboard

    # Theme-switching helper
    (writeShellScriptBin "switch-hyprland-theme" ''
      #!/usr/bin/env bash
      THEMES_DIR="$HOME/.config/hypr/themes"
      ACTIVE="$THEMES_DIR/active.conf"

      case "$1" in
        standard)
          ln -sf "$THEMES_DIR/standard.conf" "$ACTIVE"
          echo "Switched to standard theme"
          ;;
        macos)
          ln -sf "$THEMES_DIR/macos.conf" "$ACTIVE"
          echo "Switched to macOS theme"
          ;;
        riced)
          ln -sf "$THEMES_DIR/riced.conf" "$ACTIVE"
          echo "Switched to riced (Catppuccin Mocha) theme"
          ;;
        *)
          echo "Usage: switch-hyprland-theme [standard|macos|riced]"
          echo "Current: $(readlink -f "$ACTIVE" 2>/dev/null | xargs basename 2>/dev/null || echo 'none')"
          exit 1
          ;;
      esac

      # Reload Hyprland so the new theme takes effect immediately
      hyprctl reload
    '')
  ];

  # ── Main Hyprland configuration ─────────────────────────────────────────────
  xdg.configFile."hypr/hyprland.conf".text = ''
    # Source the active theme (colors, borders, animations, blur)
    # Run `switch-hyprland-theme [standard|macos|riced]` to change it.
    source = ~/.config/hypr/themes/active.conf

    # ── Monitor ──────────────────────────────────────────────────────────────
    monitor = ,preferred,auto,1

    # ── Default applications ─────────────────────────────────────────────────
    $terminal    = kitty
    $fileManager = dolphin
    $menu        = rofi -show drun

    # ── Autostart ────────────────────────────────────────────────────────────
    exec-once = waybar
    exec-once = hyprpaper
    exec-once = dunst
    exec-once = hypridle

    # ── Input ────────────────────────────────────────────────────────────────
    input {
      kb_layout = de
      follow_mouse = 1
      sensitivity = 0
      touchpad {
        natural_scroll = false
      }
    }

    # ── Layouts ──────────────────────────────────────────────────────────────
    dwindle {
      pseudotile     = true
      preserve_split = true
    }

    master {
      new_status = master
    }

    # ── Miscellaneous ────────────────────────────────────────────────────────
    misc {
      force_default_wallpaper = 0
      disable_hyprland_logo   = true
    }

    # ── Key bindings ─────────────────────────────────────────────────────────
    $mainMod = SUPER

    bind = $mainMod,       Return, exec,           $terminal
    bind = $mainMod,       Q,      killactive,
    bind = $mainMod SHIFT, Q,      exit,
    bind = $mainMod,       E,      exec,           $fileManager
    bind = $mainMod,       D,      exec,           $menu
    bind = $mainMod,       V,      togglefloating,
    bind = $mainMod,       F,      fullscreen,
    bind = $mainMod,       P,      pseudo,
    bind = $mainMod,       J,      togglesplit,
    bind = $mainMod,       L,      exec,           hyprlock

    # Focus movement
    bind = $mainMod, left,  movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up,    movefocus, u
    bind = $mainMod, down,  movefocus, d

    # Move windows
    bind = $mainMod SHIFT, left,  movewindow, l
    bind = $mainMod SHIFT, right, movewindow, r
    bind = $mainMod SHIFT, up,    movewindow, u
    bind = $mainMod SHIFT, down,  movewindow, d

    # Workspace switching (1-9)
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move window to workspace
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through workspaces on mouse wheel over bar
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up,   workspace, e-1

    # Drag / resize windows with mouse
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    # Screenshots
    bind = ,      Print, exec, grim -g "$(slurp)" - | wl-copy
    bind = SHIFT, Print, exec, grim - | wl-copy

    # Volume / media keys
    bind = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bind = , XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bind = , XF86AudioPlay,        exec, playerctl play-pause
    bind = , XF86AudioNext,        exec, playerctl next
    bind = , XF86AudioPrev,        exec, playerctl prev

    # ── Window rules ─────────────────────────────────────────────────────────
    windowrulev2 = suppressevent maximize, class:.*
    windowrulev2 = float, class:^(org.kde.dolphin)$, title:^(.*Properties.*)$
  '';

  # ── Hyprpaper (wallpaper daemon) ────────────────────────────────────────────
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    # Add your wallpaper path here and uncomment the lines below.
    # preload = /path/to/wallpaper.png
    # wallpaper = ,/path/to/wallpaper.png
    splash = false
  '';

  # ── Hypridle (idle / lock daemon) ───────────────────────────────────────────
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd      = pidof hyprlock || hyprlock
      before_sleep_cmd = loginctl lock-session
      after_sleep_cmd  = hyprctl dispatch dpms on
    }

    listener {
      timeout  = 300
      on-timeout = brightnessctl -s set 10
      on-resume  = brightnessctl -r
    }

    listener {
      timeout  = 600
      on-timeout = loginctl lock-session
    }

    listener {
      timeout  = 900
      on-timeout = systemctl suspend
    }
  '';

  # ── Waybar ───────────────────────────────────────────────────────────────────
  xdg.configFile."waybar/config.jsonc".text = ''
    {
      "layer":    "top",
      "position": "top",
      "height": 32,
      "spacing": 4,

      "modules-left":   ["hyprland/workspaces"],
      "modules-center": ["hyprland/window"],
      "modules-right":  [
        "pulseaudio", "network", "cpu", "memory",
        "battery", "clock", "tray"
      ],

      "hyprland/workspaces": {
        "format": "{id}",
        "on-click": "activate"
      },
      "clock": {
        "format":     "{:%H:%M}",
        "format-alt": "{:%Y-%m-%d %H:%M}",
        "tooltip-format": "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>"
      },
      "cpu": {
        "format": " {usage}%",
        "tooltip": false
      },
      "memory": {
        "format": " {}%"
      },
      "battery": {
        "states": { "warning": 30, "critical": 15 },
        "format": "{icon} {capacity}%",
        "format-charging": " {capacity}%",
        "format-icons": ["", "", "", "", ""]
      },
      "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": " muted",
        "format-icons": { "default": ["", "", ""] },
        "on-click": "pavucontrol"
      },
      "network": {
        "format-wifi":       " {signalStrength}%",
        "format-ethernet":   " connected",
        "format-disconnected": "⚠ offline",
        "tooltip-format": "{essid} ({signalStrength}%) via {gwaddr}"
      },
      "tray": {
        "spacing": 10
      }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      font-family: "JetBrainsMono Nerd Font", monospace;
      font-size: 13px;
      min-height: 0;
    }

    window#waybar {
      background: rgba(26, 27, 38, 0.9);
      color: #cdd6f4;
      border-bottom: 2px solid rgba(100, 114, 125, 0.5);
    }

    #workspaces button {
      padding: 0 6px;
      color: #7f849c;
      background: transparent;
      border: none;
    }

    #workspaces button.active {
      color: #cba6f7;
      font-weight: bold;
    }

    #workspaces button:hover {
      background: rgba(255, 255, 255, 0.1);
    }

    #clock, #cpu, #memory, #battery,
    #network, #pulseaudio, #tray {
      padding: 0 10px;
      color: #cdd6f4;
    }

    #clock { color: #89b4fa; }
    #cpu   { color: #a6e3a1; }
    #memory { color: #fab387; }
    #battery { color: #a6e3a1; }
    #battery.warning  { color: #f9e2af; }
    #battery.critical { color: #f38ba8; }
    #network { color: #89dceb; }
    #pulseaudio { color: #cba6f7; }
  '';

  # ── Kitty terminal ───────────────────────────────────────────────────────────
  xdg.configFile."kitty/kitty.conf".text = ''
    # Font
    font_family      JetBrains Mono
    font_size        12.0

    # Catppuccin Mocha colour scheme
    background            #1e1e2e
    foreground            #cdd6f4
    selection_background  #585b70
    selection_foreground  #cdd6f4
    cursor                #f5e0dc
    cursor_text_color     #1e1e2e

    color0  #45475a
    color1  #f38ba8
    color2  #a6e3a1
    color3  #f9e2af
    color4  #89b4fa
    color5  #f5c2e7
    color6  #94e2d5
    color7  #bac2de
    color8  #585b70
    color9  #f38ba8
    color10 #a6e3a1
    color11 #f9e2af
    color12 #89b4fa
    color13 #f5c2e7
    color14 #94e2d5
    color15 #a6adc8

    # Window
    window_padding_width 8
    confirm_os_window_close 0
  '';
}
