{ lib, pkgs, config, ... }:
let
  cfg = config.cor.home.apps.hyprlock;
in
{
  options.cor.home.apps.hyprlock = {
    enable = lib.cor.mkEnableOption
      false
      "Whether to enable hyprlock in current Home Manager configuration."
    ;

    enableHyprlandIntegration = lib.cor.mkEnableOption
      true
      "Whether to enable hyprlock integration with hyprland in current Home Manager configration"
    ;

    colorFormat = lib.mkOption {
      type = lib.types.nonEmptyStr;
      description = "Color format to copy.";
      default = "${config.xdg.userDirs.pictures}/Screenshots";
    };
  };

  config.home.packages = lib.mkIf cfg.enable [ pkgs.hyprlock ];

  config.services.hypridle.settings.general = lib.mkIf (cfg.enable && cfg.enableHyprlandIntegration) {
    lock_cmd = "pidof hyprlock || hyprlock";
  };
}
