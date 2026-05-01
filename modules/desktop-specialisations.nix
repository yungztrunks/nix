{ config, lib, ... }:

let
  cfg = config.my.modules.desktopSpecialisations;
  baseDesktopEnabled = {
    hyprland = cfg.buildHyprland;
    niri = cfg.buildNiri;
    kde = cfg.buildKde;
  }.${cfg.baseDesktop};
in
{
  options.my.modules.desktopSpecialisations = {
    enable = lib.mkEnableOption "desktop specialisations";

    # defaults in this module are fallbacks only
    # host values in hosts/thehost123/default.nix decide what is actually built

    baseDesktop = lib.mkOption {
      type = lib.types.enum [ "hyprland" "niri" "kde" ];
      default = "hyprland";
      description = "Desktop stack used by the base generation (non-specialised) boot entry.";
    };

    buildHyprland = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Build Hyprland specialisation.";
    };

    buildNiri = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Build Niri specialisation.";
    };

    buildKde = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Build KDE Plasma specialisation.";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      assertions = [
        {
          assertion = cfg.buildHyprland || cfg.buildNiri || cfg.buildKde;
          message = "At least one desktop specialisation must be enabled.";
        }
        {
          assertion = baseDesktopEnabled;
          message = "baseDesktop must also be enabled via the corresponding build* option.";
        }
      ];
    }

    # Base desktop (non-specialised entry). This avoids a shell-only menu entry.
    (lib.mkIf (cfg.baseDesktop == "hyprland") {
      system.nixos.distroName = "NixOS (hyprland)";
      services.displayManager.ly.enable = true;
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      security.pam.services.hyprlock = { };
    })

    (lib.mkIf (cfg.baseDesktop == "niri") {
      system.nixos.distroName = "NixOS (niri)";
      services.displayManager.ly.enable = true;
      programs.niri.enable = true;
    })

    (lib.mkIf (cfg.baseDesktop == "kde") {
      system.nixos.distroName = "NixOS (kde)";
      services.displayManager.ly.enable = false;
      services.xserver.enable = true;
      services.displayManager.sddm.enable = true;
      services.desktopManager.plasma6.enable = true;
    })

    {
      specialisation = {
        hyprland = lib.mkIf (cfg.buildHyprland && cfg.baseDesktop != "hyprland") {
          configuration = {
            system.nixos.distroName = lib.mkForce "NixOS";
            services.displayManager.ly.enable = true;
            services.displayManager.sddm.enable = lib.mkForce false;
            services.xserver.enable = lib.mkForce false;
            programs.hyprland = {
              enable = true;
              xwayland.enable = true;
            };
            programs.niri.enable = lib.mkForce false;
            services.desktopManager.plasma6.enable = lib.mkForce false;
            security.pam.services.hyprlock = { };
          };
        };

        niri = lib.mkIf (cfg.buildNiri && cfg.baseDesktop != "niri") {
          configuration = {
            system.nixos.distroName = lib.mkForce "NixOS";
            services.displayManager.ly.enable = true;
            services.displayManager.sddm.enable = lib.mkForce false;
            services.xserver.enable = lib.mkForce false;
            programs.hyprland.enable = lib.mkForce false;
            programs.niri.enable = true;
            services.desktopManager.plasma6.enable = lib.mkForce false;
          };
        };

        kde = lib.mkIf (cfg.buildKde && cfg.baseDesktop != "kde") {
          configuration = {
            system.nixos.distroName = lib.mkForce "NixOS";
            services.displayManager.ly.enable = lib.mkForce false;
            services.xserver.enable = true;
            services.displayManager.sddm.enable = true;
            programs.hyprland.enable = lib.mkForce false;
            programs.niri.enable = lib.mkForce false;
            services.desktopManager.plasma6.enable = true;
          };
        };
      };
    }
  ]);
}
