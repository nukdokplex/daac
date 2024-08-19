{ config, lib, ... }: {
  networking.networkmanager = lib.mkDefault {
    enable = true;
  };
}
