{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    git
    gparted
    htop
    neofetch
    sl
    wget
  ];
}