{ config, lib, ... }: {
  services.printing = lib.mkDefault {
    enable = true;
    logLevel = "debug";
  };
}
