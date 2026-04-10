{ config, lib, ... }:

let
  cfg = config.my.modules.desktopSpecialisations;
in
{
  options.my.modules.desktopSpecialisations = {
    enable = lib.mkEnableOption "desktop specialisations";

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

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.buildHyprland || cfg.buildNiri || cfg.buildKde;
        message = "At least one desktop specialisation must be enabled.";
      }
    ];

    specialisation = {
      hyprland = lib.mkIf cfg.buildHyprland {
        configuration = {
          services.displayManager.ly.enable = true;
          programs.hyprland = {
            enable = true;
            xwayland.enable = true;
          };
          security.pam.services.hyprlock = { };
        };
      };

      niri = lib.mkIf cfg.buildNiri {
        configuration = {
          services.displayManager.ly.enable = true;
          programs.niri.enable = true;
        };
      };

      kde = lib.mkIf cfg.buildKde {
        configuration = {
          services.displayManager.ly.enable = lib.mkForce false;
          services.xserver.enable = true;
          services.displayManager.sddm.enable = true;
          services.desktopManager.plasma6.enable = true;
        };
      };
    };
  };
}
