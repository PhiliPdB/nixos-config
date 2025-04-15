{ ... }: {
  imports = [
    ./applications
    ./desktop
    ./development
    ./terminal

    ./git.nix
    ./gpg.nix
  ];
}
