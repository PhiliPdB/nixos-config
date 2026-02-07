{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cfg.fonts;
in
{
  options.cfg.fonts = {
    enable = pkgs.lib.mkEnableOption "Install extra fonts";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.dejavu-sans-mono
      noto-fonts
      noto-fonts-color-emoji
      open-sans
      roboto
      vista-fonts
    ];
  };
}
