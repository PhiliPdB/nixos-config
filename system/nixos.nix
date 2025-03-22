{ user, ... }:
{
  # Enable garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  nix.settings = {
    auto-optimise-store = true;
    # Enable flakes
    experimental-features = [ "nix-command" "flakes" ];

    trusted-users = [ "root" user.username ];

    substituters = [
      "https://devenv.cachix.org"
      "https://nixpkgs-python.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
    ];
  };
}
