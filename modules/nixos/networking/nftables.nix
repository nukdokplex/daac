{ config, lib, ... }: {
  networking.nftables = lib.mkDefault {
    enable = true;
  };
}
