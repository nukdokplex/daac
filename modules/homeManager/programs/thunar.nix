{
  pkgs,
  lib,
  config,
}: {
  options.programs.thunar = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    setDefault = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.programs.thunar.enable {
    home.packages = [
      pkgs.xfce.thunar
    ];

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = ["thunar.desktop"];
      
    };
  };
}
