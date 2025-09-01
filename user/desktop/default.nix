{ lib, sysCfg, user, ... }:
let
  cfg = sysCfg.desktop;
in
{
  imports = [
    ./gtk.nix

    ./plasma.nix
  ];

  config = lib.mkIf cfg.enable {
    # Set user icon
    home.file = {
      ".face.icon".source = user.profileImage;
    };
  };
}
