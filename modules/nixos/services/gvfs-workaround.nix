{ config, lib, pkgs, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "services";
  name = "gvfs-workaround";
  enableDefault = true;
  moduleCfg = {
    services.gvfs = {
      enable = true;
      package = pkgs.gnome.gvfs;
    };
    services.tumbler.enable = true;
  };
}
