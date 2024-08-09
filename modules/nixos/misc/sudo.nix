{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "misc";
  name = "sudo";
  privilegedUsersGroup = "wheel";
  enableDefault = false;
  moduleCfg = {
    security.sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
  };
}
