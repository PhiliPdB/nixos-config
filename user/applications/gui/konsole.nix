{ lib, sysCfg, meta, ... }:
let
  guiAppsEnabled = sysCfg.guiApplications;
in
{
  config = lib.mkIf guiAppsEnabled {
    programs.konsole = {
      enable = true;

      customColorSchemes = {
        "Oxygen" = meta.themesPath + /color-schemes/Oxygen.colorscheme;
        "Material Darker" = meta.themesPath + /color-schemes/Material-darker.colorscheme;
      };

      defaultProfile = "CustomProfile";
      profiles."CustomProfile" = {
        colorScheme = "Material Darker";
      };

      ui.colorScheme = "Material Darker";
    };
  };
}
