{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "hardware";
  name = "fstrim";
  enableDefault = false;
  moduleCfg = {
    services.fstrim.enable = true;
  };
}
