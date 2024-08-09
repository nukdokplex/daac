{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "hardware";
  name = "bluetooth";
  enableDefault = true;
  moduleCfg = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };
}
