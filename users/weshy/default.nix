{ userConfig, ... }:

{
  # Enable all home packages
  # my.home.cli.enable = true;
  # my.home.development.enable = true;
  # my.home.gaming.enable = true;
  # my.home.windowsApps.enable = true;

  imports = [
    ./system/00default.nix
    ./config/00default.nix
    ./packages/00default.nix
  ];

  home.username = userConfig.username;
  home.homeDirectory = "/home/${userConfig.username}";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
