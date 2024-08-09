{ lib, pkgs, config, ... }:
let
  cfg = config.cor.home.apps.hyprpicker;
in
{
  options.cor.home.apps.hyprpicker = {
    enable = lib.cor.mkEnableOption
      false
      "Whether to enable hyprpicker in current Home Manager configuration."
    ;

    enableHyprlandIntegration = lib.cor.mkEnableOption
      true
      "Whether to enable hyprpicker integration with hyprland in current Home Manager configration"
    ;

    colorFormat = lib.mkOption {
      type = lib.types.nonEmptyStr;
      description = "Color format to copy.";
      default = "${config.xdg.userDirs.pictures}/Screenshots";
    };
  };

  config.home.packages = lib.mkIf cfg.enable [ pkgs.hyprpicker ];

  config.wayland.windowManager.hyprland.settings = lib.mkIf (cfg.enable && cfg.enableHyprlandIntegration) {
    bind = [ 
      "$mainMod SHIFT, P, exec, hyprpicker -a -r -f ${cfg.colorFormat}"
    ];
  };
}
