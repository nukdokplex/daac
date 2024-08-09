{ lib, pkgs, config, ... }:
let
  cfg = config.cor.home.apps.hyprshot;
in
{
  options.cor.home.apps.hyprshot = {
    enable = lib.cor.mkEnableOption
      false
      "Whether to enable hyprshot in current Home Manager configuration."
    ;

    enableHyprlandIntegration = lib.cor.mkEnableOption
      true
      "Whether to enable hyprshot integration with hyprland in current Home Manager configration"
    ;

    saveLocation = lib.mkOption {
      type = lib.types.nonEmptyStr;
      description = "Folder for screenshots made by hyprshot.";
      default = "${config.xdg.userDirs.pictures}/Screenshots";
    };
  };

  config.home.packages = lib.mkIf cfg.enable [ pkgs.hyprshot ];

  config.wayland.windowManager.hyprland.settings = lib.mkIf (cfg.enable && cfg.enableHyprlandIntegration) {
    bind = [
      "$mainMod, PRINT, exec, hyprshot --clipboard-only -o ${cfg.saveLocation} -m region"
      ", PRINT, exec, hyprshot --clipboard-only -o ${cfg.saveLocation} -m output"
    ];
  };
}
