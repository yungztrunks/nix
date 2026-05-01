{ ... }:

{
  programs.kitty = {
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };
    settings = {
      background_opacity = "0.90";
      dynamic_background_opacity = "yes";
      window_padding_width = 10;
      cursor_shape = "beam";
      cursor_blink_interval = "0.5";
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
      foreground = "#EDEDED";
      background = "#1D1B25";
      selection_foreground = "#F5F5F5";
      selection_background = "#6E5191";
      active_border_color = "#6E5191";
      inactive_border_color = "#3D3352";
      scrollback_lines = 5000;
      copy_on_select = true;
    };
  };
}
