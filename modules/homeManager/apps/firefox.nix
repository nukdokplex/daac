{ lib, pkgs, config, ... }:
let 
  cfg = config.cor.home.apps.firefox;
in {
  options.cor.home.apps.firefox = {
    enable = lib.cor.mkEnableOption
      false
      "Whether to enable firefox in current Home Manager configuration."
    ;
    
    enableHyprlandIntegration = lib.cor.mkEnableOption
      true
      "Whether to enable firefox integration with hyprland in current Home Manager configration"
    ;
  };

  config.home.packages = lib.mkIf cfg.enable [
    pkgs.firefox
  ];

  config.wayland.windowManager.hyprland.settings = lib.mkIf (cfg.enable && cfg.enableHyprlandIntegration) {
    bind = [
      "$mainMod, W, exec, firefox"
    ];
  };
}