{ config, lib, pkgs, ... }:
{
  options = {
    office.enable = lib.mkEnableOption "Office applications";
  };

  config = lib.mkIf config.office.enable {
    home.packages = with pkgs; [
      libreoffice-qt6-fresh

      hunspell
      hunspellDicts.en_GB-ize
      hunspellDicts.nl_NL
    ];
  };
}