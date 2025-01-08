{ self, pkgs, config, ... }: {
  stylix = {
    enable = true;
    # https://www.pixel4k.com/wp-content/uploads/2018/09/tokyo-night-city-skyscrapers-4k_1538067528.jpg
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    image = "${pkgs.nur.repos.nukdokplex.gruvbox-wallpapers.irl}/board.png";
    cursor =
      {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
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
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVuSansM Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
