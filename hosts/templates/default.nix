{ ... }:

{
  # Host template: customize per host.
  # Optional future host-local GPU config can be imported from ./gpu.nix.

  # Build-time desktop boot entries.
  my.modules.desktopSpecialisations = {
    buildHyprland = true;
    buildNiri = true;
    buildKde = false;
  };

  # Host-specific multimedia stack.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
