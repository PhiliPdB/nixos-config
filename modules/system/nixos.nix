{ pkgs, user, ... }:
{
  # Enable garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 30d";
  };

  nix.settings = {
    auto-optimise-store = true;
    # Enable flakes
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
      user.username
    ];

    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos-cuda.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };

  # Enable nh
  programs.nh = {
    enable = true;
    flake = "/home/${user.username}/nixos-config";
  };

  environment.systemPackages = with pkgs; [
    dix
    # Expose nix-output-monitor for a nicer build output
    nix-output-monitor
  ];
}
