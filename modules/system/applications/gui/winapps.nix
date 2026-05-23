{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  guiAppsEnabled = config.cfg.guiApplications;
  cfg = config.cfg.programs.winapps;

  winappsPkgs = inputs.winapps.packages."${pkgs.stdenv.hostPlatform.system}";
in
{
  options.cfg.programs.winapps = {
    enable = lib.mkEnableOption "Whether to enable WinApps to run Windows applications in Docker container";
  };

  config = lib.mkIf (guiAppsEnabled && cfg.enable) {
    environment.systemPackages = with winappsPkgs; [
      winapps
      winapps-launcher
    ];
  };
}
