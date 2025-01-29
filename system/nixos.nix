{ ... }:
{
  # Install updates weekly
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  # Enable garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;
}