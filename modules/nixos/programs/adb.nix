{ lib, config, ... }: {
  programs.adb = lib.mkDefault {
    enable = true;
  };
}