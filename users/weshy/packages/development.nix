{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  home.packages = with pkgs; [
    gh
    github-desktop
    fnm
    bun
    uv
  ];
}
