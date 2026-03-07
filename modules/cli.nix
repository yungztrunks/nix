{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.cli;
in
{
  options.my.modules.cli.enable = lib.mkEnableOption "CLI tools and utilities";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      htop
      fastfetch
      # direnv
      efibootmgr
    ];
  };
}
