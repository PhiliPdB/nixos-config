{ config, lib, pkgs, ... }:
let
  cfg = config.cfg.desktop;
in
{
  config = lib.mkIf (cfg.enable && cfg.manager == "plasma") {
    # Enable the KDE Plasma Desktop Environment.
    services.desktopManager.plasma6.enable = true;

    # Install packages related to theming
    environment.systemPackages = with pkgs; [
      papirus-icon-theme
    ];
  };
}
