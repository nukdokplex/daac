{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "virtualisation";
  name = "docker";
  enableDefault = false;
  privilegedUsersGroup = "docker";
  moduleCfg = {
    virtualisation.docker.enable = true;
  };
}
