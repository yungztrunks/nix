{ ... }:

{
  # Host-specific desktop selection controls.
  my.modules.desktopSpecialisations = {
    buildHyprland = true;
    buildNiri = true;
    buildKde = true;
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
