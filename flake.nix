{
  description = "weshy NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    weathr = {
      url = "github:Veirt/weathr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, weathr, ... }:
    let
      system = "x86_64-linux";
      hostName = "weshy";
      userName = "weshy";
    in
    {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.${userName} = {
              imports = [ weathr.homeModules.weathr ];
            };
          }
          (import ./home { inherit hostName userName; })
        ];
      };
    };
}