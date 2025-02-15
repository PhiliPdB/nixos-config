{ inputs, ... }: {
  imports = [
    inputs.stylix.nixosModules.stylix

    ./applications
    ./desktop

    ./docker.nix
    ./fonts.nix
    ./localization.nix
    ./nixos.nix
    ./stylix.nix
    ./system-packages.nix
  ];
}