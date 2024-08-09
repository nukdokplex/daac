{ config, lib, pkgs, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "misc";
  name = "fonts";
  enableDefault = true;
  moduleCfg = {
    fonts.packages = with pkgs;[
      jetbrains-mono
      noto-fonts
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-extra
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "JetBrainsMono" ]; })
    ];
  };
}
