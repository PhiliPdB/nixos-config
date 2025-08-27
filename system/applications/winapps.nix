{ config, lib, pkgs, inputs, ... }:
let
  winappsPkgs = inputs.winapps.packages."${pkgs.system}";
in {
  options = {
    winapps.enable = lib.mkEnableOption "Enable WinApps to run Windows applications in Docker container";
  };

  config = lib.mkIf config.winapps.enable {
    environment.systemPackages = with winappsPkgs; [
      winapps
      winapps-launcher
    ];
  };
}
