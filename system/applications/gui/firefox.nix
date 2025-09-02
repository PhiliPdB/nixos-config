{ lib, config, ... }:
let
  guiAppsEnabled = config.cfg.guiApplications;
in
{
  programs.firefox = {
    enable = lib.mkDefault guiAppsEnabled;
    languagePacks = [ "en-US" "nl" ];

    preferences = {
      "browser.download.start_downloads_in_tmp_dir" = true;

      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}
