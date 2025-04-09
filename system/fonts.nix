{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" "DejaVuSansMono" ]; })
    noto-fonts
    noto-fonts-emoji
    open-sans
    roboto
    vistafonts
  ];
}
