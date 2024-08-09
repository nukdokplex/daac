{ lib, config, ... }:
let
  cfg = config.cor.home.apps.gaming;
in
{
  options.cor.home.apps.gaming.enable = lib.cor.mkEnableOption
    false
    "Whether to enable gaming options in current Home Manager"
  ;

  config = lib.mkIf cfg.enable {
    cor.home.apps = {
      lutris.enable = true;
      mangohud.enable = true;
      r2modman.enable = true;
      steam.enable = true;
      wine.enable = true;
    };
  };
}
