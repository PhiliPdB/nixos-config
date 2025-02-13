{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    devenv
    git
    gparted
    htop
    neofetch
    sl
    wget
  ];
}