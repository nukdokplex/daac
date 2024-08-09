{ lib, pkgs, config, ... }: lib.cor.mkHomeManagerAppModule {
  inherit config;
  name = "r2modman";
  enableDefault = false;
  moduleCfg = {
    home.packages = [ pkgs.r2modman ];
  };
}
