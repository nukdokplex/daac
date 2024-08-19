{ lib, config, pkgs, ... }:
{
  programs.wofi = lib.mkDefault {
    enable = config.wayland.windowManager.hyprland.enable;
    package = pkgs.wofi;
  };
}
