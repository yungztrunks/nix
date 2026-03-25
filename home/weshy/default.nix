{ ... }:

{
  imports = [
    ./desktop.nix
    ./window-decoration.nix
    ./symlinks.nix
    ./applications.nix
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
