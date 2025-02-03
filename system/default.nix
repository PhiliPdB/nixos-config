{ inputs, ... }: {
  imports = [
    inputs.stylix.nixosModules.stylix

    ./applications
    ./desktop

    ./fonts.nix
    ./nixos.nix
    ./stylix.nix
    ./system-packages.nix
  ];
}