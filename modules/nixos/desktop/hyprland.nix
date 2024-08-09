{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "desktop";
  name = "hyprland";
  enableDefault = false;
  moduleCfg = {
    programs.hyprland.enable = true;
  };
}
