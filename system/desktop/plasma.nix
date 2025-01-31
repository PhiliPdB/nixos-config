{ config, lib, pkgs, ... }:
{
  options = {
    kde-plasma.enable = lib.mkEnableOption "enable the plasma desktop environment";
  };

  config = lib.mkIf (config.desktop-environment.enable && config.kde-plasma.enable) {
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Install packages related to theming
    environment.systemPackages = with pkgs; [
      (callPackage ./customization/icons.nix { colorVariants = [ "Blue" "Blue-Dark" ]; })
    #   materia-kde-theme
    #   papirus-icon-theme
    ];
  };
}