{ themesPath, ... }: {
  programs.konsole = {
    enable = true;

    customColorSchemes = {
      "Oxygen" = themesPath + /color-schemes/Oxygen.colorscheme;
      "Material Darker" = themesPath + /color-schemes/Material-darker.colorscheme;
    };

    defaultProfile = "CustomProfile";
    profiles."CustomProfile" = {
      colorScheme = "Material Darker";
    };

    ui.colorScheme = "Material Darker";
  };
}
