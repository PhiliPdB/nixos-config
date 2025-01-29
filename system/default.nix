{ ... }: {
  imports = [
    ./applications
    ./desktop

    ./fonts.nix
    ./nixos.nix
    ./system-packages.nix
  ];
}