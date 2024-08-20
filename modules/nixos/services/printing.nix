{ config, lib, ... }: {
  services.printing = {
    enable = true;
    logLevel = "debug";
  };
}
