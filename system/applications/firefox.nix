{ ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" "nl" ];

    preferences = {
      "browser.download.start_downloads_in_tmp_dir" = true;

      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}
