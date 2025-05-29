{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    nerd-fonts.dejavu-sans-mono
    noto-fonts
    noto-fonts-emoji
    open-sans
    roboto
    vistafonts
  ];
}
