{
  description = "Next generation of my Desktop-as-a-Code (DaaC) implementation based on NixOS + Nix Flakes for my home hosts.";

  nixConfig = {
    extra-substituters = [
      "https://nukdokplex.cachix.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nukdokplex.cachix.org-1:yLUFm5kbNrwexi9tBzqACj7fF0clQJ+lG7Qpb4BaEa0="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    # nixpkgs is master, other inputs should be sorted alphabetically
    # also each input must be one-liner for easy sorting in editors such as vim
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs"; inputs.darwin.follows = ""; };
    disko = { url = "github:nix-community/disko"; inputs.nixpkgs.follows = "nixpkgs"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland = { url = "github:hyprwm/Hyprland"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland-plugins = { url = "github:hyprwm/hyprland-plugins"; inputs.hyprland.follows = "hyprland"; };
    lanzaboote = { url = "github:nix-community/lanzaboote"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixvim = { url = "github:nix-community/nixvim"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur = { url = "github:nix-community/NUR"; inputs.nixpkgs.follows = "nixpkgs"; };
    pre-commit-hooks = { url = "github:cachix/git-hooks.nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    spicetify-nix = { url = "github:Gerg-L/spicetify-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    stylix = { url = "github:danth/stylix"; inputs.nixpkgs.follows = "nixpkgs"; };
  }; # well i really hate how flake's inputs looks like but th

  outputs = { self, ... }:
    let
      allHosts = [
        "sleipnir"
        "gladr"
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
                self.inputs.nur.modules.nixos.default
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
                    sharedModules = [
                      self.inputs.nixvim.homeManagerModules.default
                      self.inputs.nur.modules.homeManager.default
                    ];
                  };
                }
              ];
            });
    };
}
