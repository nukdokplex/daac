{
  lib,
  config,
  pkgs,
  ...
}: {
  options.programs.r2modman = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.programs.r2modman.enable {
    home.packages = [
      pkgs.r2modman
    ];
  };
}
