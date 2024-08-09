{ lib, pkgs, config, ... }: lib.cor.mkHomeManagerAppModule {
  inherit config;
  name = "mangohud";
  enableDefault = false;
  moduleCfg = {
    programs.mangohud = {
      enable = true;
      settings = {
        full = true;
        toggle_hud = "Shift_R+F12";
      };
    };
  };
}
