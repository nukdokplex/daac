{ lib, pkgs, config, ... }: lib.cor.mkHomeManagerAppModule {
  inherit config;
  name = "steam";
  enableDefault = false;
  moduleCfg = {
    home.packages = [ pkgs.steam ];
  };
}
