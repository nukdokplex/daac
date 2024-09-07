{
  lib,
  config,
  ...
}: {
  options.custom.gaming = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config.programs = lib.mkIf config.custom.gaming.enable {
    lutris.enable = true;
    mangohud.enable = true;
    r2modman.enable = true;
    steam.enable = true;
    wine.enable = true;
  };
}
