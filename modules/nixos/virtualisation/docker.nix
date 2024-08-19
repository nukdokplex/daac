{ config, lib, ... }: {
  virtualisation.docker = lib.mkDefault {
    enable = true;
  };
}
