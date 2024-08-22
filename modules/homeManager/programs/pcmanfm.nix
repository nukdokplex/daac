{ lib, config, pkgs, ... }: {
  options.programs.pcmanfm = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.programs.pcmanfm.enable {
    home.packages = [
      pkgs.pcmanfm
    ];
  };
}