# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  lib,
  config,
  pkgs,
  inputs,
  user,
  meta,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Set latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pdb-workstation"; # Define your hostname.
  # Enable networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openvpn ];
  };

  # Do not enable wifi and bluetooth (at least for now)
  networking.wireless.enable = false;
  hardware.bluetooth.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Set the desktop environment
  cfg.desktop = {
    enable = true;
    manager = "plasma";
  };

  # Setup hardware graphics
  cfg.hardware.graphics = {
    enable = true;
    manufacturer = "nvidia";
  };
  # Setup audio
  cfg.hardware.audio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.name;
    extraGroups = [
      "docker"
      "podman"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
  # Enable zsh as it is the default shell
  programs.zsh.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = lib.mkIf (config.cfg.desktop.manager == "plasma") [
      inputs.plasma-manager.homeModules.plasma-manager
    ];

    users = {
      ${user.username} = import ./home.nix;
    };
    # also pass the inputs to home-manager modules
    extraSpecialArgs = {
      inherit inputs user meta;
      # Share custom system config
      sysCfg = config.cfg;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Enable Docker/Podman related tools
  cfg.docker.enable = true;

  # Setup fonts
  cfg.fonts.enable = true;

  # Setup system programs
  cfg.programs = {
    # Install steam and steam-related applications
    steam.enable = true;
    # Enable VIA
    via.enable = true;
    # Enable winapps for MS Office
    winapps.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kamera # For camera communication in KDE Plasma

    # GUI for the onedrive client
    onedrivegui

    # Add gparted for visual partition management
    gparted

    # Oversteer for steering wheel management
    oversteer
  ];

  # Add oversteer to udev
  services.udev.packages = with pkgs; [ oversteer ];

  # Enable nix-ld for csharp development
  programs.nix-ld.enable = true;

  # List services that you want to enable:

  # Enable Onedrive synchronisation service
  # TODO: With the GUI is this still needed?
  services.onedrive.enable = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?
}
