{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      user = {
        name = "philipdb";
        githubName = "PhiliPdB";
        email = "phlpdbrn@gmail.com";
        gpgKey = "4EC55FB707DC24C4";
      };
    in
    {
      nixosConfigurations = {
        hyper-v-trial = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs user; };
          modules = [
            ./hosts/hyper-v-trial/configuration.nix
            ./system
          ];
        };
      };

      homeManagerModules.default = ./user;
    };
}
