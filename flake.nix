{
  description = "weshy NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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

  outputs = { nixpkgs, home-manager, noctalia, ... }:
    let
      hosts = {
        aspire = {
          system = "x86_64-linux";
          users = {
            weshy = {
              fullName = "weshy";
              gitName = "weshford";
              gitEmail = "95880628+weshford@users.noreply.github.com";
              homeModule = ./users/weshy/default.nix;
              extraGroups = [ "networkmanager" "wheel" ];
            };
          };
        };
      };

      enabledHosts = nixpkgs.lib.filterAttrs (_: hostCfg: hostCfg.enabled or true) hosts;

      mkHost = hostName: hostCfg:
        nixpkgs.lib.nixosSystem {
          system = hostCfg.system;
          specialArgs = {
            inherit hostName;
            hostPath = ./hosts/${hostName};
            hostUsers = hostCfg.users;
          };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                noctalia.homeModules.default
              ];
            }
            (import ./users {
              users = hostCfg.users;
            })
          ];
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkHost enabledHosts;
    };
}