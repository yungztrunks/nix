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
      users = {
        weshy = {
          fullName = "weshy";
          gitName = "weshford";
          gitEmail = "95880628+weshford@users.noreply.github.com";
          homeModule = ./users/weshy/default.nix;
          extraGroups = [ "networkmanager" "wheel" ];
        };
      };

      hosts = {
        aspire = {
          system = "x86_64-linux";
          userRefs = [ "weshy" ];
        };
      };

      enabledHosts = nixpkgs.lib.filterAttrs (_: hostCfg: hostCfg.enabled or true) hosts;

      resolveUser = userName:
        if builtins.hasAttr userName users then
          (users.${userName} // {
            username = users.${userName}.username or userName;
          })
        else
          throw "Host references unknown user '${userName}'";

      resolveHostUsers = hostCfg:
        builtins.listToAttrs (map
          (userName: {
            name = userName;
            value = resolveUser userName;
          })
          hostCfg.userRefs);

      mkHost = hostName: hostCfg:
        let
          hostUsers = resolveHostUsers hostCfg;
        in
        nixpkgs.lib.nixosSystem {
          system = hostCfg.system;
          specialArgs = {
            inherit hostName;
            hostPath = ./hosts/${hostName};
            inherit hostUsers;
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
              users = hostUsers;
            })
          ];
        };
    in
    {
      devShells = {
        x86_64-linux.default =
          let
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
          in
          pkgs.mkShell {
            packages = with pkgs; [
              git
              just
              nixfmt-rfc-style
              statix
              deadnix
              nil
              nixd
              python3
              uv
              neovim
            ];
          };
      };

      nixosConfigurations = nixpkgs.lib.mapAttrs mkHost enabledHosts;
    };
}