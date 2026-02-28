{
  description = "Nixos config flake";

  inputs = {
    # Define nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Define nixos-wsl
    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.11";

    # Home and Plasma Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Disko (currently only used for Hetzner)
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # General theming
    stylix.url = "github:nix-community/stylix/release-25.11";

    # Run windows apps in Docker
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      user = {
        name = "Philip";
        username = "philipdb";
        githubName = "PhiliPdB";
        email = "phlpdbrn@gmail.com";
        gpgKey = "4EC55FB707DC24C4";

        profileImage = ./dotfiles/profile.png;
        wallpaper = {
          desktop = ./wallpapers/ribblehead-station.jpg;
          lockscreen = ./wallpapers/partial-solar-eclipse.jpg;
        };
      };

      themesPath = ./themes;

      unstable-overlay = {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit (final) config;
              localSystem = final.stdenv.hostPlatform;
            };
          })
        ];
      };
    in
    {
      nixosConfigurations = {
        cloud =
          let
            system = "x86_64-linux";

            meta = {
              inherit themesPath;
              systemName = "cloud";
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs user meta; };
            modules = [
              inputs.disko.nixosModules.default
              ./hosts/cloud/configuration.nix
              ./system
            ];
          };
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
              ./system/stylix.nix
              ./system/system-packages.nix
            ];
          };
      };

      deploy.nodes = {
        hetzner = {
          hostname = "philipdb.com";
          sshUser = user.username;
          interactiveSudo = true;
          profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib."x86_64-linux".activate.nixos self.nixosConfigurations.cloud;
          };
        };
      };

      checks = builtins.mapAttrs (
        system: deployLib: deployLib.deployChecks self.deploy
      ) inputs.deploy-rs.lib;

      homeModules.default = ./user;
      dotfiles.default = ./dotfiles;
    };
}
