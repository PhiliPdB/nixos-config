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
    # Generated hardware config
    ./hardware-configuration.nix

    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.home-manager.nixosModules.default
  ];

  # Disable systemd-boot because lanzaboot replaces it.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  boot.initrd.luks.devices."luks-3315d2a5-77b5-4ca1-b516-3715f606ce18".device =
    "/dev/disk/by-uuid/3315d2a5-77b5-4ca1-b516-3715f606ce18";

  # Networking setup
  networking.hostName = "pdb-spectre";
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openvpn ];
  };

  # Configure other device hardware
  hardware.bluetooth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Set the desktop environment
  cfg.desktop = {
    enable = true;
    manager = "plasma";
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

  # Nixpkgs config
  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;
  };

  # Enable Docker/Podman related tools
  cfg.docker.enable = true;

  # Setup fonts
  cfg.fonts.enable = true;

  # Setup system programs
  cfg.programs = {
    steam.enable = false;
    via.enable = false;
    winapps.enable = false;
  };

  environment.systemPackages = with pkgs; [
    # Add gparted for visual partition management
    gparted

    # Easy temporary firewall management
    nixos-firewall-tool

    # For debugging and troubleshooting Secure Boot
    sbctl
  ];

  # Enable nix-ld for csharp development
  programs.nix-ld.enable = true;

  # List services that you want to enable:

  # Enable Onedrive synchronisation service
  services.onedrive = {
    enable = true;
    package = pkgs.unstable.onedrive;
  };

  # Configure vm for `nixos-rebuild build-vm`
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 1024 * 4;
      cores = 4;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
