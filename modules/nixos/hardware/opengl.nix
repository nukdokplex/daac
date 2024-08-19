{ config, lib, ... }: {
  hardware.opengl = lib.mkDefault {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
