{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    git
    htop
    neofetch
    ripgrep
    sl
    wget
  ];
}
