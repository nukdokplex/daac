{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.programs.gwenview;
in {
  options.programs.gwenview = {
    enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
    package = lib.mkOption {
      default = pkgs.kdePackages.gwenview;
      type = lib.types.package;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
  };
}
