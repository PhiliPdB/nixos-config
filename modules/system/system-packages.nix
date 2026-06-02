{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    htop
    ripgrep
    sl
    wget
  ];
}
