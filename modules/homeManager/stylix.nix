{ self, lib, pkgs, ... }: {
  imports = [ self.inputs.stylix.homeManagerModules.stylix ];

  stylix = lib.mkDefault {
    enable = true;
  };
}
