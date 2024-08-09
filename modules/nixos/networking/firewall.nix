{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "networking";
  name = "firewall";
  enableDefault = true;
  moduleCfg = {
    networking.firewall = {
      enable = true;
      allowPing = true;
    };
  };
}
