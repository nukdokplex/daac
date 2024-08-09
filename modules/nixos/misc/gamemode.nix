{ config, lib, ... }: lib.cor.mkCorModule {
  inherit config;
  domain = "nixos";
  category = "misc";
  name = "gamemode";
  privilegedUsersGroup = "gamemode";
  enableDefault = false;
  moduleCfg = {
    programs.gamemode.enable = true;
  };
}
