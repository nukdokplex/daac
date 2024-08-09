{ lib, pkgs, config, ... }: lib.cor.mkHomeManagerAppModule {
  inherit config;
  name = "nheko";
  enableDefault = false;
  moduleCfg = {
    programs.nheko = {
      enable = true;
      package = pkgs.nheko;
    };
  };
}
