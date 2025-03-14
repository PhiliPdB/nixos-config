{ ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" "nl"];

    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}