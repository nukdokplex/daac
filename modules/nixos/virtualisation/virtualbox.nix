{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "virtualisation";
  name = "virtualbox";
  privilegedUsersGroup = "vboxusers";
  enableDefault = false;
  moduleCfg = {
    virtualisation.virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
}
