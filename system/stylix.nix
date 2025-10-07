{ pkgs, meta, inputs, ... }: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    # autoEnable = false;

    polarity = "dark";
    base16Scheme = meta.themesPath + /color-schemes/Material-darker.yaml;

    fonts = {
      monospace = {
        name = "DejaVuSansM Nerd Font";
        package = pkgs.nerd-fonts.dejavu-sans-mono;
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

    cursor = {
      name = "Bibata-Original-Ice";
      size = 28;
      package = pkgs.bibata-cursors;
    };
  };
}
