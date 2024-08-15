{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "misc";
  name = "sudo";
  privilegedUsersGroup = "wheel";
  enableDefault = true;
  moduleCfg = {
    security.sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
  };
}
