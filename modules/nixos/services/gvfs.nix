{ config, lib, ... }: {
  services.gvfs = lib.mkDefault {
    enable = true;
  };
}