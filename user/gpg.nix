{ pkgs, ... }:
{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSshSupport = true;
  };

  home.packages = with pkgs; [
    # To make the gnome3 entry work
    gcr
    # GUI from kde
    kgpg
  ];
}