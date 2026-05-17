{
  description = "weshy NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # temporary! until a patch for hyprplugins is available; currently builds fail bzw. dependencies are wrong
    nixpkgs-hyprland-plugins-fix.url = "github:NixOS/nixpkgs/231ea250eee538df1b939ca7899e0e80e7bcb08c";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-fonts-nix = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-hyprland-plugins-fix, home-manager, spicetify-nix, noctalia, nix-index-database, helium, sops-nix, apple-fonts-nix, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      userConfig = {
        username = "weshy";
        fullName = "weshy";
        gitName = "*weshford";
        gitEmail = "95880628+weshford@users.noreply.github.com";
        extraGroups = [ "networkmanager" "wheel" ];
      };

      hyprbarsPluginPackage = nixpkgs-hyprland-plugins-fix.legacyPackages.${system}.hyprlandPlugins.hyprbars;

      mkDevShell = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
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

    in
    {
      devShells = {
        ${system} = {
          default = mkDevShell system;
        };
      };

      nixosConfigurations.aspire = lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit userConfig;
        };
        modules = [
          ./configuration.nix
          sops-nix.nixosModules.sops
          {
            nixpkgs.overlays = [
              (final: prev: {
                helium = helium.packages.${prev.system}.default;
              })
            ];
          }
          home-manager.nixosModules.home-manager
          nix-index-database.nixosModules.nix-index
          {
            home-manager.sharedModules = [
              noctalia.homeModules.default
              spicetify-nix.homeManagerModules.default
              sops-nix.homeManagerModules.sops
            ];
          }
          (import ./weshy/home.nix {
            inherit userConfig hyprbarsPluginPackage;
            spicetifyPkgs = spicetify-nix.legacyPackages.${system};
            appleFontsPkgs = apple-fonts-nix.packages.${system};
          })
        ];
      };
    };
}