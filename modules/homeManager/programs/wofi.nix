{ lib, config, pkgs, ... }:
{
  programs.wofi = {
    enable = config.wayland.windowManager.hyprland.enable;
    package = pkgs.wofi;
  };
}
