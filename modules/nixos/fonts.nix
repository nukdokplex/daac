{pkgs, ...}: {
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts-extra
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];
}
