{ config, lib, pkgs, ... }:
{
  options = {
    proton-apps.enable = lib.mkEnableOption "enable proton apps";
  };

  config = lib.mkIf config.proton-apps.enable {
    home.packages = with pkgs; [
      unstable.proton-pass
      protonvpn-gui
    ];
  };
}