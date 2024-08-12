{
  description = "Next generation of my Desktop-as-a-Code (DaaC) implentation based on NixOS + Nix Flakes for my home hosts.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    epson_201310w = {
      url = "github:nukdokplex/epson_201310w";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, ... }:
    let
      linuxSystems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      hosts = [
        "sleipnir"
        "gladr"
        "testvm"
      ];
    in
    {
      packages = (self.inputs.nixpkgs.lib.genAttrs linuxSystems) (
        system: {
          default = self.inputs.nixpkgs.legacyPackages.${system}.writeShellApplication {
            name = "clean-install";
            text = ./assets/scripts/clean-install.sh;
          };
        }
      );

      modules = {
        nixos.default = ./modules/nixos;
        homeManager.default = ./modules/homeManager;
      };

      instances = {
        hosts = {
          sleipnir = ./instances/hosts/sleipnir;
          gladr = ./instances/hosts/gladr;
          testvm = ./instances/hosts/testvm;
        };

        homes = {
          nukdokplex = ./instances/homes/nukdokplex;
        };

        secrets = ./instances/secrets;
      };

      nixosConfigurations = (self.inputs.nixpkgs.lib.genAttrs hosts) (
        host: self.inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit self;
            hostname = host;
          };
          modules = [
            self.modules.nixos.default
            self.inputs.disko.nixosModules.default
            self.inputs.home-manager.nixosModules.home-manager
            self.inputs.agenix.nixosModules.default
            self.instances.hosts.${host}
            self.instances.secrets
            {
              nixpkgs.config.allowUnfree = true;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { 
                  inherit self; 
                  hostname = host;
                };
              };
            }
          ];
        }
      );
    };
}
