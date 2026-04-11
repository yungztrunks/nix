{ userConfig, ... }:

{
  # Structured user template.
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
