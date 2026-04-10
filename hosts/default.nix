{ ... }:

{
  # Shared host defaults.
  networking.networkmanager.enable = true;

  my.modules.desktopSpecialisations = {
    baseDesktop = "hyprland";
    buildHyprland = true;
    buildNiri = true;
    buildKde = true;
  };
}
