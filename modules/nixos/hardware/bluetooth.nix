{ lib, ... }: {
  hardware.bluetooth = lib.mkDefault {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
}
