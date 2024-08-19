{ self, pkgs, config, lib, ... }:
let
  spicetify-nix = self.inputs.spicetify-nix;
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];

  programs.spicetify = lib.mkDefault {
    enable = true;
    spotifyPackage = pkgs.spotify;
  };
}
