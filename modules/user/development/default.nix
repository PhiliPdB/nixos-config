{ pkgs, inputs, ... }:
let
  dotfilesDir = inputs.self.outputs.dotfiles.default;
in
{
  imports = [
    ./lua.nix
    ./nix.nix
  ];

  # Enable direnv
  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    (writeScriptBin "sf" (builtins.readFile (dotfilesDir + /scripts/setup-flake.sh)))
  ];
}
