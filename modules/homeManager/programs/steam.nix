{ lib, config, pkgs, ... }: {
  options.programs.steam = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.programs.steam.enable {
    home.packages = [
      pkgs.steam
    ];
  };
}