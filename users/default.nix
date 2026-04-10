{ users ? { } }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.sharedModules = [
    ({ lib, osConfig, ... }: {
      programs.noctalia-shell.enable = lib.mkDefault (
        (osConfig.programs.hyprland.enable or false) || (osConfig.programs.niri.enable or false)
      );
    })
  ];
  home-manager.users = builtins.mapAttrs
    (userName: userCfg:
      let
        resolvedUserCfg = userCfg // {
          username = userCfg.username or userName;
        };
      in
      {
        imports = [ resolvedUserCfg.homeModule ];
        _module.args.userConfig = resolvedUserCfg;
      })
    users;
}