{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    fd
    ripgrep
    eza
    btop
    yazi
    # TODO: sowas wie 7zip
  ];
}
