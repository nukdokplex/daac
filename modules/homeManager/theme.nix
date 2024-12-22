{ lib
, pkgs
, config
, ...
}: {
  options = {
    custom.borders.radius = lib.mkOption {
      default = 17;
      type = lib.types.int;
    };

    custom.borders.width = lib.mkOption {
      default = 2;
      type = lib.types.int;
    };
  };

  config = {
    stylix = {
      enable = true;
    };

    gtk.iconTheme = {
      name =
        if config.stylix.polarity == "dark"
        then "Papirus-Dark"
        else "Papirus";

      package = pkgs.papirus-icon-theme;
    };
  };
}
