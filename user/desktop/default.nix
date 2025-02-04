{ lib, user, ... }:
{
  imports = [
    ./plasma.nix
  ];

  config = lib.mkIf (user.desktop != null) {
    # Set user icon
    home.file = {
      ".face.icon".source = ../dotfiles/face.icon;
    };

    # QT and GTK styling ?!
  };
}