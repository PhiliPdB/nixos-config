{ config, lib, pkgs, ... }:
let
  cfg = config.cfg.programs.via;
in
{
  options.cfg.programs.via = {
    enable = lib.mkEnableOption "Whether to install VIA application";
  };

  config = lib.mkIf cfg.enable {
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