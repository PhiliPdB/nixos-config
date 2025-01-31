{ lib, user, ... }:
{
  config = lib.mkIf (user.desktop == "plasma") {
    programs.plasma = {
      enable = true;

      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        iconTheme = "Flatery-Blue-Dark";
      };
    };
  };
}