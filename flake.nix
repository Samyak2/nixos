{
  description = "My Nix OS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "github:Samyak2/nvim-config";
      flake = false;
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    firefox-csshacks = {
      url = "github:MrOtherGuy/firefox-csshacks";
      flake = false;
    };

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    mac-app-util,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations.nixos = let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      plasma-manager = inputs.plasma-manager.homeManagerModules.plasma-manager;
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
        };

        modules = [
          ./nixos

          {
            fileSystems."/mnt/e-drive" = {
              device = "/dev/disk/by-uuid/2A828CFA828CCBAF";
              fsType = "ntfs-3g";
              # 1000 is the user id. how to ensure this is always correct?
              options = ["rw" "uid=1000"];
            };
          }

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.samyak = import ./home;

            home-manager.extraSpecialArgs = {
              inherit inputs pkgs-unstable;
              username = "samyak";
              email = "samyak201@gmail.com";
            };

            home-manager.sharedModules = [plasma-manager];
          }
        ];
      };

    homeConfigurations.samyak = let
      system = "aarch64-darwin";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-unstable;
        modules = [
          mac-app-util.homeManagerModules.default
          ./home
          {
            config = {
              local.copilot-enabled = false;
            };
          }
        ];
        extraSpecialArgs = {
          inherit inputs pkgs-unstable;
          username = "samyak";
          email = "samyak201@gmail.com";
        };
      };

    homeConfigurations.samyak-nz = let
      system = "aarch64-darwin";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-unstable;
        modules = [
          ./home
          {
            config = {
              local.copilot-enabled = true;
            };
          }
        ];
        extraSpecialArgs = {
          inherit inputs pkgs-unstable;
          username = "samyak-nz";
          email = "samyak@normalyze.ai";
        };
      };

    homeConfigurations.samyak-e6 = let
      system = "aarch64-darwin";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-unstable;
        modules = [
          mac-app-util.homeManagerModules.default
          ./home
          {
            config = {
              local.copilot-enabled = true;
              local.java = true;
              local.cloud.aws = true;
              local.cloud.azure = true;
              local.k8s = true;
              local.jinja = true;
              local.sophos = true;
            };
          }
        ];
        extraSpecialArgs = {
          inherit inputs pkgs-unstable;
          username = "samyak-e6";
          email = "samyak@e6x.io";
        };
      };

    # cloud server
    homeConfigurations.ubuntu = let
      system = "aarch64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      plasma-manager = inputs.plasma-manager.homeManagerModules.plasma-manager;
    in
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-unstable;
        modules = [
          {
            config = {
              local.copilot-enabled = false;
              local.headless = true;
            };
          }
          plasma-manager
          ./home
        ];
        extraSpecialArgs = {
          inherit inputs pkgs-unstable;
          username = "ubuntu";
          email = "samyak201@gmail.com";
        };
      };
  };
}
