{ lib, pkgs, config, ... }:
let 
  cfg = config.cor.home.apps.pcmanfm-qt;
in {
  options.cor.home.apps.pcmanfm-qt = {
    enable = lib.cor.mkEnableOption
      false
      "Whether to enable pcmanfm-qt in current Home Manager configuration."
    ;
    
    enableHyprlandIntegration = lib.cor.mkEnableOption
      true
      "Whether to enable pcmanfm-qt integration with hyprland in current Home Manager configration"
    ;
  };

  config.home.packages = lib.mkIf cfg.enable [
    pkgs.lxqt.pcmanfm-qt
  ];

  config.wayland.windowManager.hyprland.settings = lib.mkIf (cfg.enable && cfg.enableHyprlandIntegration) {
    bind = [
      "$mainMod, E, exec, pcmanfm-qt"
    ];
  };
}