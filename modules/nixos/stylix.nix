{ lib, pkgs, ... }: {
  stylix = lib.mkDefault {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  };
}
