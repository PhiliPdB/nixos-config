{ pkgs, user, meta, ... }: {
  stylix = {
    enable = true;
    # autoEnable = false;

    image = user.wallpaper;

    polarity = "dark";
    base16Scheme = meta.themesPath + /color-schemes/Material-darker.yaml;

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