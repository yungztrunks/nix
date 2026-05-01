# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, hostName, hostPath, hostUsers, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hosts/default.nix
      (hostPath + "/default.nix")
      (hostPath + "/hardware.nix")
      ./modules/development.nix
      ./modules/desktop-specialisations.nix
      ./modules/gaming.nix
      ./modules/windows-apps.nix
      ./modules/alias.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = lib.mkDefault hostName; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  assertions = [
    {
      assertion = builtins.length (builtins.attrNames hostUsers) > 0;
      message = "At least one user must be defined for this host in flake.nix.";
    }
  ];

  users.users = lib.mapAttrs
    (userName: userCfg: {
      isNormalUser = true;
      description = userCfg.fullName or userName;
      extraGroups = userCfg.extraGroups or [ "networkmanager" "wheel" ];
    })
    hostUsers;

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Avoid abrupt DM restarts during switch; apply desktop stack changes via boot + reboot.
  # systemd.services.display-manager.restartIfChanged = false;

  my.modules.develop.enable = true;
  my.modules.desktopSpecialisations.enable = true;
  my.modules.gaming.enable = true;
  my.modules.windowsApps.enable = true;
  my.modules.shellAliases.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wayland-utils
      wl-clipboard
      kitty
      xfce.thunar
      kdePackages.ark
      kdePackages.partitionmanager
      kdePackages.kate
      #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
