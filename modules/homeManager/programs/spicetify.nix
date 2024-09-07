{ self, pkgs, config, lib, ... }:
let
  spicePkgs = self.inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ self.inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.dreary;
    colorScheme = "custom";
    customColorScheme = with config.lib.stylix.colors; {
      text               = base0D;
      subtext            = base05;
      button-text        = base00;
      main               = base00;
      sidebar            = base01;
      player             = base01;
      subbutton-text     = base00;
      card               = base01;
      shadow             = base00;
      selected-row       = base02;
      sub-button         = base0D;
      button             = base0D;
      button-active      = base0D;
      button-disabled    = base02;
      tab-active         = base01;
      notification       = base02;
      notification-error = base02;
      playback-bar       = base0D;
      misc               = base03;
    };
  };
}
