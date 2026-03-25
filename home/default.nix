{ hostName, userName }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${userName} = import ./${hostName}/default.nix;
}