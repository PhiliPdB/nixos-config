{
  description = "Nixos config flake";

  inputs = {
    # Define nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Define nixos-wsl
    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.05";

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

    # Run windows apps in Docker
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      user = {
        name = "Philip";
        username = "philipdb";
        githubName = "PhiliPdB";
        email = "phlpdbrn@gmail.com";
        gpgKey = "4EC55FB707DC24C4";

        profileImage = ./dotfiles/profile.png;
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
        workstation =
          let
            system = "x86_64-linux";

            meta = {
              inherit themesPath;
              systemName = "workstation";
            };
          in
            nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = { inherit inputs user meta; };
              modules = [
                unstable-overlay
                ./hosts/workstation/configuration.nix
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
        wsl =
          let
            system = "x86_64-linux";

            meta = {
              inherit themesPath;
              systemName = "nixos-wsl";
            };
          in
            nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = { inherit inputs user meta; };
              modules = [
                inputs.nixos-wsl.nixosModules.default
                unstable-overlay
                ./hosts/wsl/configuration.nix
                # Import the relevant common config
                # TODO: Update config so this can be ./system
                ./system/applications
                ./system/desktop
                ./system/localization.nix
                ./system/nixos.nix
                ./system/system-packages.nix
              ];
            };
      };

      homeModules.default = ./user;
      dotfiles.default = ./dotfiles;
    };
}
