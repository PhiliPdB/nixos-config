{ lib, sysCfg, pkgs, ... }:
let
  displayManager = if sysCfg.desktop.enable then sysCfg.desktop.manager else null;
in
{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = lib.mkDefault (
      if displayManager == "plasma" then pkgs.pinentry-qt
      else pkgs.pinentry-tty
    );
    enableSshSupport = true;
  };
}
