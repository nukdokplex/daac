{ lib, pkgs, config, ... }:
let 
  cfg = config.cor.home.apps.alacritty;
in {
  options.cor.home.apps.alacritty = {
    enable = lib.cor.mkEnableOption
      false
      "Whether to enable alacritty in current Home Manager configuration."
    ;
    
    enableHyprlandIntegration = lib.cor.mkEnableOption
      true
      "Whether to enable alacritty integration with hyprland in current Home Manager configration"
    ;
  };

  config.home.packages = lib.mkIf cfg.enable [
    pkgs.alacritty
  ];

  config.wayland.windowManager.hyprland.settings = lib.mkIf (cfg.enable && cfg.enableHyprlandIntegration) {
    bind = [
      "$mainMod, Q, exec, alacritty"
    ];
  };
}