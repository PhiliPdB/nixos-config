{ lib, user, ... }:
{
  imports = [
    ./gtk.nix

    ./plasma.nix
  ];

  config = lib.mkIf (user.desktop != null) {
    # Set user icon
    home.file = {
      ".face.icon".source = user.profileImage;
    };
  };
}
