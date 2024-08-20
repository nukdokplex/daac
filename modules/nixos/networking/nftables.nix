{ config, lib, ... }: {
  networking.nftables = {
    enable = true;
  };
}
