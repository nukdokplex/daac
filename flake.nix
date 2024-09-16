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

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nukdokplex-nix-repository = {
      url = "github:nukdokplex/nukdokplex-nix-repository";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wofi-power-menu = {
      url = "github:szaffarano/wofi-power-menu";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...}: let
    allSystems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    allHosts = [
      "sleipnir"
      "gladr"
      "testvm"
    ];
    # genAttrs [ "foo" "bar" ] (name: "x_" + name)
    #   => { foo = "x_foo"; bar = "x_bar"; }
  in {
    formatter =
      self.inputs.nixpkgs.lib.genAttrs
      allSystems
      (system: let pkgs = import self.inputs.nixpkgs {inherit system;}; in pkgs.alejandra);

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
    };

    nixosConfigurations =
      self.inputs.nixpkgs.lib.genAttrs
      allHosts
      (host:
        self.inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit self;
            hostname = host;
          };
          modules = [
            self.modules.nixos.default
            self.inputs.disko.nixosModules.default
            self.inputs.home-manager.nixosModules.home-manager
            self.inputs.agenix.nixosModules.default
            self.inputs.stylix.nixosModules.stylix
            self.instances.hosts.${host}
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
        });
  };
}
