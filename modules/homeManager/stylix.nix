{ self, lib, ... }: {
  imports = [ self.inputs.stylix.homeManagerModules.stylix ];

  stylix = lib.mkDefault {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  };
}
