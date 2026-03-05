{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Music
    spotify # Music streaming (unfree)

    # Social / voice
    discord # Chat & voice for gaming (unfree)

    # Gaming clients (Steam & Heroic are managed system-wide in modules/gaming.nix)
    # Nothing extra needed here – they appear in the app launcher automatically
  ];
}
