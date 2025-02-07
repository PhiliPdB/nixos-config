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
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      user = {
        name = "Philip";
        username = "philipdb";
        githubName = "PhiliPdB";
        email = "phlpdbrn@gmail.com";
        gpgKey = "4EC55FB707DC24C4";

        desktop = "plasma";
        profileImage = ./user/dotfiles/profile.png;
        wallpaper = ./wallpapers/nyhavn-copenhagen.jpg;
      };
    in
    {
      nixosConfigurations = {
        hyper-v-trial = 
        let 
          system = "x86_64-linux";
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
        in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs pkgs-unstable user; };
            modules = [
              ./hosts/hyper-v-trial/configuration.nix
              ./system
            ];
          };
      };

      homeManagerModules.default = ./user;
    };
}
