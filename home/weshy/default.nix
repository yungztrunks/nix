{ ... }:

{
  # Enable all home packages
  my.home.cli.enable = true;
  my.home.apps.enable = true;
  my.home.development.enable = true;
  my.home.gaming.enable = true;
  my.home.windowsApps.enable = true;

  imports = [
    # System integration
    ./system/desktop.nix
    
    # Configuration
    ./config/cursor.nix
    ./config/git.nix
    ./config/kitty.nix
    ./config/fastfetch.nix
    ./config/noctalia.nix

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
