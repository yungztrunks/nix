{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.cli;
in
{
  options.my.modules.cli.enable = lib.mkEnableOption "system-level CLI utilities";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      efibootmgr
    ];
  };
}
