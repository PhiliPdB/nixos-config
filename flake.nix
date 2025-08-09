{
  description = "Nixos config flake";

  inputs = {
    # Define nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home and Plasma Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # General theming
    stylix.url = "github:nix-community/stylix/release-25.05";
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
        wallpaper = {
          desktop    = ./wallpapers/ribblehead-station.jpg;
          lockscreen = ./wallpapers/partial-solar-eclipse.jpg;
        };
      };

      themesPath = ./themes;

      unstable-overlay = {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              system = final.system;
              config.allowUnfree = true;
            };
          })
        ];
      };
    in
    {
      nixosConfigurations = {
        hyper-v-trial =
          let
            system = "x86_64-linux";

            meta = {
              inherit themesPath;
              systemName = "hyper-v-trial";
            };
          in
            nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = { inherit inputs user meta; };
              modules = [
                unstable-overlay
                ./hosts/hyper-v-trial/configuration.nix
                ./system
              ];
            };
        workstation-trial =
          let
            system = "x86_64-linux";

            meta = {
              inherit themesPath;
              systemName = "workstation-trial";
            };
          in
            nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = { inherit inputs user meta; };
              modules = [
                unstable-overlay
                ./hosts/workstation-trial/configuration.nix
                ./system
              ];
            };
      };

      homeManagerModules.default = ./user;
    };
}
