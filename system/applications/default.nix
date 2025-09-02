{ lib, config, ... }:
{
  imports = [
    ./tui/vim.nix

    ./gui/firefox.nix
    ./gui/steam.nix
    ./gui/via.nix
    ./gui/winapps.nix
  ];

  options.cfg.guiApplications =
    lib.mkEnableOption "Whether to install GUI applications by default."
    // {
      default = config.cfg.desktop.enable;
      defaultText = "true if desktop environment is enabled";
    };
}
