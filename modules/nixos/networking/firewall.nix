{ config, lib, ... }: {
  networking.firewall = lib.mkDefault {
    enable = true;
    allowPing = true;
  };
}
