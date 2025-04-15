{ pkgs, inputs, ... }:
{
  home.packages = [
    pkgs.nixd
    pkgs.nixfmt-rfc-style
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}