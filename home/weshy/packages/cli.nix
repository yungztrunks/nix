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
    programs.starship.enable = true;
    programs.fzf.enable = true;
    programs.bat.enable = true;
    programs.neovim.enable = true;

    home.packages = with pkgs; [
      fd
      ripgrep
      exa
      btop
    ];
  };
}
