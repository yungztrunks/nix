{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.develop;
in
{
  options.my.modules.develop.enable = lib.mkEnableOption "system-level development infrastructure";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnumake
      gcc
      python3
      nil
      nixd
      nixfmt-rfc-style
    ];
  };
}
