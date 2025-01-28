{ config, lib, ... }:
{
  imports = [
    ./plasma.nix
  ];

  options = {
    desktop-environment.enable = lib.mkEnableOption "enable a desktop environment";
  };

  config = lib.mkIf config.desktop-environment.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable kde plasma by default
    kde-plasma.enable = lib.mkDefault true;
  };
}