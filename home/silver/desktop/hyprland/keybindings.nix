{ config, pkgs, ... }:

{
  xdg.configFile."hypr/keybindings.conf".text = ''
    # ══════════════════════════════════════════════════════════════════════════
    # Hyprland key bindings
    # Edit this file to customise shortcuts.  Run `hyprctl reload` to apply.
    # ══════════════════════════════════════════════════════════════════════════

    $mainMod = SUPER

    # ── Application launchers ────────────────────────────────────────────────
    bind = $mainMod,       Return, exec, kitty
    bind = $mainMod,       D,      exec, rofi -show drun
    bind = $mainMod,       E,      exec, dolphin

    # ── Window management ────────────────────────────────────────────────────
    bind = $mainMod,       Q,      killactive,
    bind = $mainMod SHIFT, Q,      exit,
    bind = $mainMod,       V,      togglefloating,
    bind = $mainMod,       F,      fullscreen,
    bind = $mainMod,       P,      pseudo,
    bind = $mainMod,       J,      togglesplit,

    # ── Session ──────────────────────────────────────────────────────────────
    bind = $mainMod,       L,      exec, hyprlock

    # ── Theme / wallpaper switchers ──────────────────────────────────────────
    bind = $mainMod,       T,      exec, pick-theme
    bind = $mainMod,       W,      exec, waypaper

    # ── Focus movement (arrow keys) ──────────────────────────────────────────
    bind = $mainMod, left,  movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up,    movefocus, u
    bind = $mainMod, down,  movefocus, d

    # ── Move windows ─────────────────────────────────────────────────────────
    bind = $mainMod SHIFT, left,  movewindow, l
    bind = $mainMod SHIFT, right, movewindow, r
    bind = $mainMod SHIFT, up,    movewindow, u
    bind = $mainMod SHIFT, down,  movewindow, d

    # ── Workspace switching (1 – 9, 0 = 10) ──────────────────────────────────
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

    # ── Move window to workspace ──────────────────────────────────────────────
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

    # ── Scroll through workspaces on mouse wheel ──────────────────────────────
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up,   workspace, e-1

    # ── Drag / resize windows with mouse ─────────────────────────────────────
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    # ── Screenshots ───────────────────────────────────────────────────────────
    bind = ,      Print, exec, grim -g "$(slurp)" - | wl-copy   # Screenshot selected region
    bind = SHIFT, Print, exec, grim - | wl-copy                  # Screenshot entire screen

    # ── Volume / media keys ───────────────────────────────────────────────────
    bind = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bind = , XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bind = , XF86AudioPlay,        exec, playerctl play-pause
    bind = , XF86AudioNext,        exec, playerctl next
    bind = , XF86AudioPrev,        exec, playerctl prev
  '';
}
