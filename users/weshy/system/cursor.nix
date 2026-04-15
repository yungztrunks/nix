{ pkgs, ... }:

{
  home.packages = [ pkgs.apple-cursor ];

  home.pointerCursor = {
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
    x11.enable = true;
  };
}
