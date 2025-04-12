{ pkgs, lib, ... }: {
  gtk = {
    enable = true;

    theme = lib.mkForce {
      name = "Breeze-Dark";
      package = pkgs.breeze-gtk;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
