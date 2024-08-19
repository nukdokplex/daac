{ lib, config, ... }: {
  options.custom.gaming = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config.programs = lib.mkIf config.custom.gaming.enable  {
    lutris.enable = lib.mkDefault true;
    mangohud.enable = lib.mkDefault true;
    r2modman.enable = lib.mkDefault true;
    steam.enable = lib.mkDefault true;
    wine.enable = lib.mkDefault true;
  };
}
