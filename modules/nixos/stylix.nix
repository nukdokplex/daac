{ lib, pkgs, ... }: {
  stylix = {
    enable = true;
    # https://www.pixel4k.com/wp-content/uploads/2018/09/tokyo-night-city-skyscrapers-4k_1538067528.jpg
    base16Scheme = "${pkgs.base16-schemes}/share/themes/measured-dark.yaml";
    image = pkgs.fetchurl {
      urls = [
        "https://www.pixel4k.com/wp-content/uploads/2018/09/tokyo-night-city-skyscrapers-4k_1538067528.jpg"
        "https://web.archive.org/web/20240820194945/https://www.pixel4k.com/wp-content/uploads/2018/09/tokyo-night-city-skyscrapers-4k_1538067528.jpg"
      ];

      hash = "sha256-Ak/wZYbqmTxSq/U0e31HzAH5KZKqQJIKFEMLZCZNSC8=";
    };
  };
}
