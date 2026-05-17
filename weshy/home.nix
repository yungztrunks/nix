{ userConfig, hyprbarsPluginPackage ? null, spicetifyPkgs ? null, appleFontsPkgs ? null }: # temporary

{ config, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup-${config.system.nixos.label}";
  home-manager.sharedModules = [
    ({ lib, osConfig, ... }: {
      programs.noctalia-shell.enable = lib.mkDefault (
        osConfig.programs.hyprland.enable or false
      );
    })
  ];

  home-manager.users.${userConfig.username} = {
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

    _module.args.userConfig = userConfig;
    _module.args.hyprbarsPluginPackage = hyprbarsPluginPackage; # temporary
    _module.args.spicetifyPkgs = spicetifyPkgs;
    _module.args.appleFontsPkgs = appleFontsPkgs;
  };
}
