{ config, lib, pkgs, ... }:
{
  options = {
    via.enable = lib.mkEnableOption "Install VIA application";
  };

  config = lib.mkIf config.via.enable {
    # Expose QMK to non-root users
    hardware.keyboard.qmk.enable = true;

    # Install via
    environment.systemPackages = with pkgs; [
      via
    ];
    # Add via to udev
    services.udev.packages = with pkgs; [ via ];
  };
}