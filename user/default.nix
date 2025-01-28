{ ... }: {
  imports = [
    ./applications
    ./terminal
    ./programming/nix.nix

    ./git.nix
    ./gpg.nix
  ];
}