{
  config,
  pkgs,
  lib,
  ...
}:
{
  gtk = {
    enable = true;

    theme = lib.mkForce {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    gtk4.theme = config.gtk.theme;

    cursorTheme = {
      name = "Bibata-Original-Ice";
      size = 28;
      package = pkgs.bibata-cursors;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
