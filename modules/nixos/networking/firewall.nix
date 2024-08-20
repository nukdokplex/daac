{ config, lib, ... }: {
  networking.firewall = {
    enable = true;
    allowPing = true;
  };
}
