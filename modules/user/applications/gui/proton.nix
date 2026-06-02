{
  lib,
  config,
  sysCfg,
  pkgs,
  ...
}:
let
  guiAppsEnabled = sysCfg.guiApplications;
  cfg = config.cfg.programs.proton;
in
{
  options.cfg.programs.proton = {
    enable = lib.mkEnableOption "Whether to enable Proton apps";
  };

  config = lib.mkIf (guiAppsEnabled && cfg.enable) {
    home.packages = with pkgs; [
      unstable.proton-pass
      proton-vpn
    ];
  };
}
