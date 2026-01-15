{ pkgs, inputs, ... }:
let
  dotfilesDir = inputs.self.outputs.dotfiles.default;
in
{
  imports = [
    ./applications
    ./desktop
    ./development
    ./terminal

    ./git.nix
    ./gpg.nix
  ];

  # Usefull user scripts
  home.packages = with pkgs; [
    (writeScriptBin "nr" (builtins.readFile (dotfilesDir + /scripts/nix-run.sh)))
  ];
}
