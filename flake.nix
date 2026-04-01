{
  description = "weshy NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    weathr = {
      url = "github:Veirt/weathr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, weathr, noctalia, ... }:
    let
      hosts = {
        weshy = {
          system = "x86_64-linux";
          userNames = [ "weshy" ];
        };

        # Example ARM machine. Enable it once `./home/arm-laptop` exists.
        # arm-laptop = {
        #   enabled = false;
        #   system = "aarch64-linux";
        #   userNames = [ "weshy" ];
        # };
      };

      enabledHosts = nixpkgs.lib.filterAttrs (_: hostCfg: hostCfg.enabled or true) hosts;

      mkHost = hostName: hostCfg:
        nixpkgs.lib.nixosSystem {
          system = hostCfg.system;
          specialArgs = {
            inherit hostName;
            hostPath = ./home/${hostName};
            primaryUser = builtins.head hostCfg.userNames;
          };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                weathr.homeModules.weathr
                noctalia.homeModules.default
              ];
            }
            (import ./home {
              inherit hostName;
              userNames = hostCfg.userNames;
            })
          ];
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkHost enabledHosts;
    };
}