{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      user = {
        name = "philipdb";
        githubName = "PhiliPdB";
        email = "phlpdbrn@gmail.com";
        gpgKey = "4EC55FB707DC24C4";

        desktop = "plasma";
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
