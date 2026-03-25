{ config, lib, pkgs, ... }:

let
  cfg = config.my.home.cli;
in
{
  options.my.home.cli.enable = lib.mkEnableOption "CLI tools and utilities";

  config = lib.mkIf cfg.enable {
    programs.htop.enable = true;
    programs.fastfetch.enable = true;
    programs.weathr.enable = true;
  };
}
