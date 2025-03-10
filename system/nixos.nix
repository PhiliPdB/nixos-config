{ inputs, user, ... }:
{
  # Install updates weekly
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    # Set flake path and arguments
    flake = inputs.self.outPath;
    flags = [
      "--update-input" "nixpkgs"
      "--no-write-lock-file"
      "--print-build-logs"
    ];
  };

  # Enable garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;

  nix.extraOptions = ''
    trusted-users = root ${user.username}

    extra-substituters = https://nixpkgs-python.cachix.org https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw= nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU=
  '';
}