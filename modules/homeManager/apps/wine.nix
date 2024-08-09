{ lib, pkgs, config, ... }: lib.cor.mkHomeManagerAppModule {
  inherit config;
  name = "wine";
  enableDefault = false;
  moduleCfg = {
    home.packages = with pkgs; [ 
      wine
      winetricks
    ];
  };
}
