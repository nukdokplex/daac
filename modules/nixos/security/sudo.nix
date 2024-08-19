{ config, lib, ... }: {
  security.sudo = lib.mkDefault {
    enable = true;
    wheelNeedsPassword = true;
  };
}
