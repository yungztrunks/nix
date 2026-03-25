{ ... }:

{
  imports = [
    # System integration
    ./system/desktop.nix
    ./system/window-decoration.nix
    ./system/symlinks.nix

    # Configuration
    ./config/git.nix
    ./config/kitty.nix
    ./config/weathr.nix
    ./config/fastfetch.nix
    ./config/plasma-tahoe.nix

    # Packages
    ./packages/cli.nix
    ./packages/apps.nix
    ./packages/development.nix
    ./packages/gaming.nix
    ./packages/windows-apps.nix
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
