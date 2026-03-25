{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];

  home.file = {
    ".local/bin/plasma-tahoe-layout" = {
      source = ./dotfiles/bin/plasma-tahoe-layout;
    };

    ".config/kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
    ".config/autostart/plasma-tahoe-layout.desktop".source = ./dotfiles/autostart/plasma-tahoe-layout.desktop;
  };
}
