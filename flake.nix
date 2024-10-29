{
  description = "Next generation of my Desktop-as-a-Code (DaaC) implentation based on NixOS + Nix Flakes for my home hosts.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

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
      url = "github:nix-community/home-manager";
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
      url = "github:szaffarano/wofi-power-menu/v0.2.2";
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

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }:
    let
      allHosts = [
        "sleipnir"
        "gladr"
        "testvm"
      ];
    in
    {

      checks = self.inputs.flake-utils.lib.eachDefaultSystemPassThrough (
        system:
        {
          ${system}.pre-commit-check = self.inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
            };
          };
        }
      );
      devShells = self.inputs.flake-utils.lib.eachDefaultSystemPassThrough (
        system:
        let
          pkgs = import self.inputs.nixpkgs { inherit system; };
        in
        {
          ${system}.default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
          };
        }
      );
      formatter = self.inputs.flake-utils.lib.eachDefaultSystemPassThrough (
        system:
        let
          pkgs = import self.inputs.nixpkgs { inherit system; };
        in
        { ${system} = pkgs.nixpkgs-fmt; }
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
