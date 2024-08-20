{ self, pkgs, config, lib, ... }:
let
  spicePkgs = self.inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ self.inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = lib.mkDefault {
    enable = true;
  };
}
