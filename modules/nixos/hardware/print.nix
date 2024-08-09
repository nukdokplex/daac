{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "hardware";
  name = "print";
  enableDefault = true;
  moduleCfg = {
    services.printing = {
      enable = true;
      logLevel = "debug";
    };
  };
}