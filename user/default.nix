{ ... }: {
  imports = [
    ./applications
    ./desktop
    ./terminal
    ./programming/nix.nix

    ./git.nix
    ./gpg.nix
  ];
}
