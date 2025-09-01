{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.cfg.programs.winapps;
  winappsPkgs = inputs.winapps.packages."${pkgs.system}";
in {
  options.cfg.programs.winapps = {
    enable = lib.mkEnableOption "Whether to enable WinApps to run Windows applications in Docker container";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with winappsPkgs; [
      winapps
      winapps-launcher
    ];
  };
}
