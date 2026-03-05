{ config, pkgs, ... }:

{
  # Wine with 32-bit support (required by FL Studio and many Windows games)
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable # 64-bit + 32-bit Wine
    winetricks               # Helper scripts for Wine
    bottles                  # GUI Wine prefix manager
  ];
}
