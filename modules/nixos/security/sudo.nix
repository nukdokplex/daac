{ config, lib, ... }: {
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
