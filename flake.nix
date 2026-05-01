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
    hyprland = {
      url = "github:hyprwm/Hyprland";
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
  };

  outputs = { nixpkgs, nixpkgs-hyprland-plugins-fix, home-manager, hyprland, noctalia, nix-index-database, helium, sops-nix, ... }:
    let
      lib = nixpkgs.lib;

      users = {
        weshy = {
          fullName = "weshy";
          gitName = "*weshford";
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

      enabledHosts = lib.filterAttrs (_: hostCfg: hostCfg.enabled or true) hosts;
      hostSystems = lib.unique (map (hostCfg: hostCfg.system) (builtins.attrValues enabledHosts));

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
          hyprbarsPluginPackage = nixpkgs-hyprland-plugins-fix.legacyPackages.${hostCfg.system}.hyprlandPlugins.hyprbars;
        in
        lib.nixosSystem {
          system = hostCfg.system;
          specialArgs = {
            inherit hostName;
            hostPath = ./hosts/${hostName};
            inherit hostUsers;
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
                sops-nix.homeManagerModules.sops
              ];
            }
            (import ./users {
              users = hostUsers;
              inherit hyprbarsPluginPackage;
            })
          ];
        };

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

      mkRunTargets = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          hyprlandPkg = hyprland.packages.${system}.default or pkgs.hyprland;
          noctaliaPkg = if builtins.hasAttr "noctalia-shell" pkgs then pkgs."noctalia-shell" else null;

          desktopPrelude = ''
            export NIXOS_OZONE_WL=1
            export XDG_SESSION_TYPE=wayland
            export XDG_CURRENT_DESKTOP=weshy
            if command -v noctalia-shell >/dev/null 2>&1; then
              (noctalia-shell >/dev/null 2>&1 &) || true
            fi
          '';

          mkDesktopLauncher = {
            name,
            command,
            runtimeInputs ? [ ],
          }:
            pkgs.writeShellApplication {
              inherit name;
              runtimeInputs =
                [ pkgs.kitty ]
                ++ runtimeInputs
                ++ lib.optional (noctaliaPkg != null) noctaliaPkg;
              text = ''
                ${desktopPrelude}
                exec ${command} "$@"
              '';
            };

          desktopLaunchers = {
            "weshy-hyprland" = mkDesktopLauncher {
              name = "weshy-hyprland";
              command = "${hyprlandPkg}/bin/Hyprland";
              runtimeInputs = [ hyprlandPkg ];
            };
            "weshy-niri" = mkDesktopLauncher {
              name = "weshy-niri";
              command = "${pkgs.niri}/bin/niri";
              runtimeInputs = [ pkgs.niri ];
            };
          };

          weshtty = pkgs.writeShellApplication {
            name = "weshtty";
            runtimeInputs = with pkgs; [
              bashInteractive
              kitty
              neovim
              git
              lazygit
              htop
              fd
              ripgrep
              eza
              btop
              yazi
              unzip
              zip
              p7zip
              gh
              uv
              fnm
              bun
              direnv
            ];
            text = ''
              export EDITOR=nvim
              export VISUAL=nvim

              if [[ -n "''${WAYLAND_DISPLAY:-}" || -n "''${DISPLAY:-}" ]]; then
                exec kitty -e bash -lc 'exec bash -i'
              fi

              echo "No graphical session detected; starting interactive shell in current terminal."
              exec bash -i
            '';
          };

          mkApp = name: drv: {
            type = "app";
            program = "${drv}/bin/${name}";
          };
        in
        {
          packages = desktopLaunchers // {
            weshtty = weshtty;
          };

          apps =
            (builtins.mapAttrs mkApp desktopLaunchers)
            // {
              weshtty = mkApp "weshtty" weshtty;
            };
        };

      runTargetsBySystem = lib.genAttrs hostSystems mkRunTargets;
    in
    {
      devShells = lib.genAttrs hostSystems (system: {
        default = mkDevShell system;
      });

      packages = lib.mapAttrs (_: targets: targets.packages) runTargetsBySystem;
      apps = lib.mapAttrs (_: targets: targets.apps) runTargetsBySystem;

      nixosConfigurations = lib.mapAttrs mkHost enabledHosts;
    };
}