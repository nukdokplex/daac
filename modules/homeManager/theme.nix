{
  lib,
  pkgs,
  config,
  ...
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

      package = pkgs.papirus-icon-theme.override {color = "adwaita";};
    };

    stylix.targets.gtk.extraCss = ''
      window.background { border-radius: ${toString config.custom.borders.radius}; }

      tooltip {
        &.background {
          background-color: alpha(${config.lib.stylix.colors.withHashtag.base00}, ${builtins.toString config.stylix.opacity.popups});
          border: 1px solid ${config.lib.stylix.colors.withHashtag.base0D};
        }

        background-color: alpha(${config.lib.stylix.colors.withHashtag.base00}, ${builtins.toString config.stylix.opacity.popups});
        border-radius: ${toString config.custom.borders.radius};
        border: 1px solid ${config.lib.stylix.colors.withHashtag.base0D};
        color: white;
      }

      ${
        lib.optionalString (config.stylix.polarity == "light") "
        tooltip {
          &.background { background-color: alpha(${config.lib.stylix.colors.withHashtag.base05}, ${builtins.toString config.stylix.opacity.popups}); }
          background-color: alpha(${config.lib.stylix.colors.withHashtag.base05}, ${builtins.toString config.stylix.opacity.popups});
        }"
      }
    '';

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
  };
}
