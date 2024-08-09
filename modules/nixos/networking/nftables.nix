{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "networking";
  name = "nftables";
  enableDefault = true;
  moduleCfg = {
    networking.nftables.enable = true;
  };
}
