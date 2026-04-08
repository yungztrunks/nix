{ hostName, userNames ? [ ] }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.users = builtins.listToAttrs (
    map
      (userName: {
        name = userName;
        value = import ./${hostName}/default.nix;
      })
      userNames
  );
}