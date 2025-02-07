{ config, lib, pkgs, pkgs-unstable, ... }:
{
  options = {
    proton-apps.enable = lib.mkEnableOption "enable proton apps";
  };

  config = lib.mkIf config.proton-apps.enable {
    home.packages = with pkgs; [
      pkgs-unstable.proton-pass
      protonvpn-gui
    ];
  };
}