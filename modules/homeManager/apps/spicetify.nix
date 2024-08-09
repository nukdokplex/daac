{ self, pkgs, config, lib, ... }: {
  options.cor.home.apps.spicetify = {
    enable = lib.cor.mkEnableOption
      false
      "Whether to enable spicetify in current Home Manager configuration."
    ;
  };
  imports = [ self.inputs.spicetify-nix.homeManagerModule ];

  config = lib.mkIf config.cor.home.apps.spicetify.enable {

    programs.spicetify =
      let
        spicePkgs = self.inputs.spicetify-nix.packages.${pkgs.system}.default;
      in
      {
        enable = true;
        spotifyPackage = pkgs.spotify;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };
  };
}
