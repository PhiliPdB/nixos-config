{ pkgs, inputs, ... }:
{
  home.packages = [
    pkgs.nixd
    pkgs.nixfmt
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
