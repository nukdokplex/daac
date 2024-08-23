{ lib, pkgs, config, ... }: {
  stylix = {
    enable = true;
  };

  gtk.iconTheme = {
    name =
      if config.stylix.polarity == "dark"
      then "Papirus-Dark"
      else "Papirus";

    package = pkgs.papirus-icon-theme.override { color = "adwaita"; };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";

    style = {
      name =
        if config.stylix.polarity == "dark"
        then "Adwaita-Dark"
        else "Adwaita";

      package = pkgs.adwaita-qt;
    };
  };
}
