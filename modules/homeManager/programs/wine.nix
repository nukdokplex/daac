{
  config,
  lib,
  pkgs,
  ...
}: {
  options.programs.wine = {
    enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.programs.wine.enable {
    home.packages = with pkgs; [
      wine
      winetricks
    ];
  };
}
