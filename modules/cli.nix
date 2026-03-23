{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.cli;
in
{
  options.my.modules.cli.enable = lib.mkEnableOption "CLI tools and utilities";

  config = lib.mkIf cfg.enable {
    programs.htop.enable = true;

    environment.systemPackages = with pkgs; [
      fastfetch
      # direnv
      efibootmgr
    ];
  };
}
