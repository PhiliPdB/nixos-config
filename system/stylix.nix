{ pkgs, user, ... }:
let
  color-scheme = "humanoid-dark"; # TODO: Move to user object
in
{
  stylix = {
    enable = true;

    image = user.wallpaper;

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${color-scheme}.yaml";

    fonts = {
      monospace = {
        name = "DejaVuSansM Nerd Font";
        package = pkgs.nerdfonts.override { fonts = [ "DejaVuSansMono" ]; };
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      sizes = {
        applications = 10;
        desktop = 10;
      };
    };
  };
}