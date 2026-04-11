{ config, lib, pkgs, ... }:

let
  cfg = config.my.home.cli;
in
{
  options.my.home.cli.enable = lib.mkEnableOption "CLI tools and utilities";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      htop
      fd
      ripgrep
      eza
      btop
      yazi
      # TODO: sowas wie 7zip
    ];
  };
}
