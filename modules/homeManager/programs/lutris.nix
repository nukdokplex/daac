{ config, lib, pkgs, ... }: {
  options.programs.lutris = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.programs.lutris.enable {
    home.packages = with pkgs; [
      (lutris.override {
        steamSupport = false;
      })
    ];
  };
}
