{
  config,
  lib,
  pkgs,
  ...
}: {
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
        extraLibraries = pkgs: [
          pkgs.graphene
          pkgs.libgudev
          pkgs.pango
          pkgs.dav1d
          pkgs.cairo
          pkgs.libvpx
          pkgs.bzip2
          pkgs.ffmpeg
          pkgs.libwebp
          pkgs.libusb1
          pkgs.gst_all_1.gst-plugins-rs
        ];
      })
    ];
  };
}
