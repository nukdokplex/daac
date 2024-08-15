{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "networking";
  name = "networkmanager";
  privilegedUsersGroup = "networkmanager";
  enableDefault = true;
  moduleCfg = {
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.scanRandMacAddress = false; # prevent some issues
  };
}
