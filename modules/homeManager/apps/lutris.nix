{ lib, pkgs, config, ... }: lib.cor.mkHomeManagerAppModule {
  inherit config;
  name = "lutris";
  enableDefault = false;
  moduleCfg = {
    home.packages = [
      (pkgs.lutris.override {
        steamSupport = false;
      })
    ];
  };
}