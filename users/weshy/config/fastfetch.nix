{ ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "auto";
        padding = {
          top = 1;
          left = 2;
        };
      };

      display = {
        separator = "  ";
      };

      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "de"
        "wm"
        "icons"
        "font"
        "cursor"
        "terminal"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "localip"
        "locale"
        "colors"
      ];
    };
  };
}