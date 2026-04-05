{ pkgs, ... }:

{
  home.packages = [ pkgs.apple_cursor ];

  home.pointerCursor = {
    name = "macOS";
    package = pkgs.apple_cursor;
    size = 24;
    x11.enable = true;
  };
}
