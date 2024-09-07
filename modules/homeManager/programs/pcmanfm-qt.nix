{
  lib,
  config,
  pkgs,
  ...
}: {
  options.programs.pcmanfm-qt = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.programs.pcmanfm-qt.enable {
    home.packages = [
      pkgs.lxqt.pcmanfm-qt
    ];
  };
}
