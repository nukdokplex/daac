{ self, pkgs, config, ... }: {
  stylix = {
    enable = true;
    # https://www.pixel4k.com/wp-content/uploads/2018/09/tokyo-night-city-skyscrapers-4k_1538067528.jpg
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    image = pkgs.fetchurl {
      urls = [
        "https://www.pixel4k.com/wp-content/uploads/2018/09/tokyo-night-city-skyscrapers-4k_1538067528.jpg"
        "https://web.archive.org/web/20240820194945/https://www.pixel4k.com/wp-content/uploads/2018/09/tokyo-night-city-skyscrapers-4k_1538067528.jpg"
      ];

      hash = "sha256-Ak/wZYbqmTxSq/U0e31HzAH5KZKqQJIKFEMLZCZNSC8=";
    };

    cursor =
      let
        themeVariant = "Dracula";
        colorVariant = "Green";

        # afterglow from nixpkgs
        package = pkgs.afterglow-cursors-recolored.override {
          themeVariants = [ themeVariant ];
          draculaColorVariants = [ colorVariant ];
        };

        # package = self.inputs.nukdokplex-nix-packages.packages.${pkgs.system}.afterglow-cursors-recolored-custom.override {
        #   colorScheme = with config.lib.stylix.colors.withHashtag; {
        #     # original colors
        #     # main = "#8a80e0";
        #     # stroke = "#1c1a2d";
        #     # accent = "#c1bbfe";
        #     # contextMenu = "#c1bbfe";
        #     # loadingBackground = "#534d86";
        #     # loadingForeground = "#8a80e0";
        #     # notAllowed = "#8a80e0";

        #     # opinionated bind to base16 colors
        #     main = base00; # #1d2021
        #     stroke = base0D; # #83a598
        #     accent = base0E; # #d3869b
        #     contextMenu = base0E; # #d3869b
        #     loadingBackground = base00; # #1d2021
        #     loadingForeground = base0D; # #83a598
        #     notAllowed = base08; # #fb4934
        #   };
        # };
      in
      {
        inherit package;
        name = "Afterglow-Recolored-${themeVariant}-${colorVariant}";
        size = 32;
      };

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerdfonts.override {
          fonts = [ "DejaVuSansMono" ];
        };
        name = "DejaVuSansM Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
