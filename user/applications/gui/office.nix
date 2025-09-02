{ lib, config, sysCfg, pkgs, ... }:
let
  guiAppsEnabled = sysCfg.guiApplications;
  cfg = config.cfg.programs.office;
in
{
  options.cfg.programs.office = {
    enable = lib.mkEnableOption "Whether to enable office applications";
  };

  config = lib.mkIf (guiAppsEnabled && cfg.enable) {
    home.packages = with pkgs; [
      libreoffice-qt6-fresh

      hunspell
      hunspellDicts.en_GB-ize
      hunspellDicts.nl_NL
    ];
  };
}
