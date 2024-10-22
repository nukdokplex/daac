{
  self,
  pkgs,
  config,
  ...
}: let
  spicePkgs = self.inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [self.inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
  };
}
