{ lib, sysCfg, pkgs, ... }:
let
  guiAppsEnabled = sysCfg.guiApplications;
in
{
  config = lib.mkIf guiAppsEnabled {
    home.packages = with pkgs; [
      vscode
      vscode-runner
    ];
  };
}
