{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    fd
    ripgrep
    eza
    btop
    yazi
    unrar
    unzip
    zip
    p7zip
  ];
}
