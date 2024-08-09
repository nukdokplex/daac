{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "hardware";
  name = "libinput";
  privilegedUsersGroup = "input";
  enableDefault = false;
  moduleCfg = {
    services.libinput.enable = true;
  };
}
