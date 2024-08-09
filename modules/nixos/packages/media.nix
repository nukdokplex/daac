{ config, lib, pkgs, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "packages";
  name = "media";
  enableDefault = false;
  moduleCfg = {
    environment.systemPackages = with pkgs; [
      handbrake
      inkscape
      kdenlive
      obs-studio
    ];
  };
}
